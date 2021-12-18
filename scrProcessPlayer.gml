function scrProcessPlayer() {
	var xx,yy,c1,c2,c3,c4;

	// применение гравитации и прыжков по Y
	y = y+grav;
	grav+=gravdelta;
	if( grav>=gravmax ) grav=gravmax;

	//БЛОК ПРЫЖКОВ И ПАДЕНИЯ

	if(!jump){									// если игрок уже прыгает, но ничего не делать
		if((keyboard_check(vk_space)) || (gamepad_button_check(0,gp_face1))){
			grav=grav_jump;						//активировать прыжок
			jump=true;							// отметить активацию прыжка	
		}
	}

	// проверка левого стика гейпмада (аналог - стрелки клавиатуры)
	stick_l_h = gamepad_axis_value(0,gp_axislh);// получить значение по горизонтали левого джойстика
	stick_l_v = gamepad_axis_value(0,gp_axislv);// получить значение по вертикали левого джойстика

	// перемещение по горизонтали
	if(stick_l_h < 0){							// если стик слева, двигайся влево
		move_left = true;
		move_right = false;
	} else if(stick_l_h > 0){					// если стик справа, двигайся вправо
		move_left = false;
		move_right = true;
	} else {									// если ни то, ни другое, то не двигайся
		move_left = false;
		move_right = false;
	}
	// перемещение по вертикали
	if(stick_l_v < 0){							// если стик находится наверху, то двигайся вверх
		move_up = true;
		move_down = false;
	} else if(stick_l_v > 0){					// если стик внизу, двигайся вниз
		move_up = false;
		move_down = true;
	} else {									// если ни то, ни другое, то не двигайся
		move_up = false;
		move_down = false;
	}


	if( grav<0 ){								// при прыжке проверка над игроком
	    sprite_index = sJump;
	} else {									// в противном случае, падая, проверка под игроком
	    if(jump){								// если идёт падение после прыжка, то отображается нужный спрайт
	        sprite_index = sJumpFall;
	    } else if(fall){						// при падении с края отображает спрайт падения
	        sprite_index = sFall;    
	    } else {								// если нет ни падения, ни прыжка
			grav = 0;							// первая остановка падения (нужно для лестниц)
			fall = true;						// отмечает, что игрок падает
		}
		// проверяет точки внизу игрока
		c1 = tilemap_get_at_pixel(oGame.map,x-(sprite_get_width(sprite_index)/2),y);	// слева
		c2 = tilemap_get_at_pixel(oGame.map,x+(sprite_get_width(sprite_index)/2),y);	// справа
		c3 = tilemap_get_at_pixel(oGame.map,x,y);										// по центру

		if( c1>=1 || c2>=1 || c3 >= 1){			// if they are intersecting with a tile
			if((c1 == 1) || (c2 == 1) || (c3 == 1) || (c1 == 3) || (c2 == 3) || (c3 == 3)){
				// если сквозь плитку, на которую падает игрок нельзя пройти 
				y = real(y&$ffffffc0);			// перемещает спрайт в верхнюю часть плитки
				sprite_index = choose(sidle1);	// устанавливает спрайт ожидания
				climbing = false;				// прекращает любое карабкание
				jump = false;					// прекращает любые прыжки
				fall = false;					// прекращает любые падения
			}
			if((c3 == 2) || (c3 == 2)){			// если игрок пересекается с лестницей
				can_climb = true;				// отмечает, что игрок карабкается
			}
		} else {								// если игрок не пересекает ни одной плитки
			climbing = false;					// отмечает, что взбираться не на что
		}
	}    

	// БЛОК ПЕРЕДВИЖЕНИЯ

	if((keyboard_check(vk_left)) || (oGame.button_down_left == true) || (gamepad_button_check(0,gp_padl)) || (move_left)){	// столкновение при движении влево
	    dir=-1;									// устанавливает правильное направление
		image_xscale = dir;						// разворачивает спрайт по направлению движения
		climbing = false;						// поскольку игрок движется влево, он не карабкается
		can_climb = false;						// и в принципе не может взбираться пока движется
	    if(!jump && !fall){						// если игрок не прыгает и не падает
	        sprite_index = sWalk;				// используется спрайт ходьбы 
	    }
	    x=x-xspeed								// переместить игрока влево
	    c2 = -1;
		c3 = -1;
		// проверка точек в нижней части спрайта
	    c1 = tilemap_get_at_pixel(oGame.map,x-(sprite_get_width(sprite_index)/2),y-1);				// слева
	    c3 = tilemap_get_at_pixel(oGame.map,x,y-1);													// по центру
	    if( y & $3f>0 ) c2=tilemap_get_at_pixel(oGame.map,x-(sprite_get_width(sprite_index)/2),y+1);	// слева внизу (только проверяет, есть ли плитка)
	    if(c1 == 3) || (c2 == 3){																	// если игрок пересекается с коробкой
			x = real(x & $ffffffc0)+(sprite_get_width(sprite_index)/2);								// останавливает движение игрока
	    }
		if(c3 == 2){							// если игрок пересекается с лестницей
			can_climb = true;					// отметить, что игрок может карабкаться
		} else {								// если не пересекается
			can_climb = false;					// отметить, что не может
			image_speed = anim_speed;			//проверка, что анимация будет проиграна с нужной скоростью
		}
		if(x < 0){								// если игрок переместился за край экрана
			x = room_width;						// перемещение на другую сторону экрана
		}
	}else if((keyboard_check(vk_right)) || (oGame.button_down_right == true) || (gamepad_button_check(0,gp_padr)) || (move_right)){			
		// столкновение при движении вправо (проверить у else, чтобы оба направления не могли быть запущены одновременно)
	    dir=1;									// установка правильного направления
		image_xscale = dir;						// установить спрайт по направлению движения
		climbing = false;						// установить, что игрок неподнимается
		can_climb = false;						// установить, что игрок не может подниматься
	    if(!jump && !fall){						// если игрок не прыгает и не падает
	        sprite_index = sWalk;				// то установить спрайт ходьбы
	    }
	    x=x+xspeed;								// перемещение игрока вправо
	    c2 = -1;
		c3 = -1;
		//  проверка точек в нижней части спрайта
	    c1 = tilemap_get_at_pixel(oGame.map,x+(sprite_get_width(sprite_index)/2),y-1);				// справа
		c3 = tilemap_get_at_pixel(oGame.map,x,y-1);													// по центру
	    if( y&$3f>0 ) c2=tilemap_get_at_pixel(oGame.map,x+(sprite_get_width(sprite_index)/2),y+1);	// справа внизу (только проверяет, есть ли плитка)
	    if(c1 == 3) || (c2 == 3){																	// если игрок пересекается с коробкой
				x = real(x&$ffffffc0)+oGame.tilesize-(sprite_get_width(sprite_index)/2);			// останавливает движение игрока
	    }
		if(c3 == 2){							// если игрок пересекается с лестницей
			can_climb = true;					// отметить, что игрок может карабкаться
		} else {								// если не пересекается
			can_climb = false;					// отметить, что не может
			image_speed = anim_speed;			// проверка, что анимация будет проиграна с нужной скоростью
		}
		if(x > room_width){						// если игрок переместился за край экрана
			x = 0;								//перемещение на другую сторону экрана
		}
	
	} else if(!can_climb){						// если игрок не движется ни влево, ни вправо, то включается проверка, не поднимается ли игрок
		if(!jump){
			sprite_index = choose(sidle1);	// установка одного из незанятых спрайтов (рандом)
		}
		image_speed = anim_speed;				// проверка, что анимация будет проиграна с нужной скоростью
	}

	//БЛОК КАРАБКАНЬЯ

	if(can_climb){									// если игрок может карабкаться
		c3 = tilemap_get_at_pixel(oGame.map,x,y-1);	// проверка нижнего центра спрайта
		if(c3 == 2){								// если он всё ещё находится на лестнице
			if((keyboard_check(vk_up)) || (oGame.button_down_up == true) || (gamepad_button_check(0,gp_padu)) || (move_up)){				// и нажимается кнопка Вверх
				y = y+yspeed;						// игрок начинает/продолжает подниматься
				image_index+=0.3;					// ручное управление, на каком кадре анимации находится спрайт
				climbing = true;					// отметка, что игрок карабкается
			}
			if((keyboard_check(vk_down)) || (oGame.button_down_down == true) || (gamepad_button_check(0,gp_padd)) || (move_down)){			// или если нажимается кнопка Вниз
				y = y-yspeed;						// игрок начинает/продолжает спускаться
				image_index+=0.3;					// ручное управление, на каком кадре анимации находится спрайт 
				climbing = true;					//отметка, что игрок карабкается
			}
			if(climbing){							// если игрок карабкается
				jump = false;						// проверка, что он не прыгает
				fall = false;						// проверка, что он не падает
				sprite_index = sClimb;				// установить спрайт карабкания
				image_speed = 0						// остановка воспроизведения анимации спрайта, т.к. она управляется вручную кнопками
				x = real(x&$ffffffc0)+oGame.tilesize-(sprite_get_width(sprite_index)/2);	// проверка, что игрок остаётся на лестнице
			}
		} else {									// если игрок больше не находится на лестнице
			can_climb = false;						// отметка, что игрок больше не может подниматься
		}
	}
}
