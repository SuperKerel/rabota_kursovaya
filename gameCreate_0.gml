/// Инициализация
tilesize = 64;															// размер плиток
map = layer_tilemap_get_id("Collisions");								// это будет слой, используемый для столкновений
hills = layer_get_all_elements("Hills");								// все спрайты холмов
energy = layer_get_all_elements("Energy");								// все спрайты энергетиков
clouds = layer_get_all_elements("Clouds");								// все спрайты облаков

// изменение всех спрайтов на песочные альтернативы
switch(room){
	case rSand:															// если игрок на уровне песка
		for(i=0;i<array_length_1d(hills);i++){							// циклом проверить все спрайты
			if(layer_sprite_get_sprite(hills[i]) == sBGHills_grass){	// если спрайт по умолчанию является травяным
				layer_sprite_change(hills[i],sBGHills_sand);			// установите его на песочный по умолчанию
			} else {													// если это не по умолчанию
				layer_sprite_change(hills[i],sBGHills1_sand);			// замени его на другой песчаный
			}
		}
		for(i=0;i<array_length_1d(clouds);i++){							// проверка всех облачных спрайтов
			if(layer_sprite_get_sprite(clouds[i]) == sCloud_grass){		// если спрайт по умолчанию является травяным
				layer_sprite_change(clouds[i],sCloud_sand);				// установите его на песочный по умолчанию
			} else {													// если это не по умолчанию
				layer_sprite_change(clouds[i],sCloud1_sand);			// замени его на другой песчаный
			}
	}
		for(i=0;i<array_length_1d(energy);i++){							// проверка всех спрайтов энергетиков
			layer_sprite_change(energy[i],sStar_grass);					// без изменений
		}
		break;
}
// элементы управления на экране
button_pressed = false;													// отметка, нажата ли какая-либо кнопка
button_down_left = false;												// если нажата левая кнопка
button_down_right = false;												// если нажата правая кнопка
button_down_up = false;													// если нажата кнопка вверх
button_down_down = false;												// если нажата кнопка вниз
button_down_jump = false;												// если нажата кнопка прыжка
button_x_left = 100;													// установка значения x для левой кнопки
button_x_right = 300;													// установка значения x для правой кнопки
button_x_jump = view_wport[0]-100;										// установка значения x для кнопки прыжка
button_y = view_hport[0] - 100;											// установка значения y для кнопок
button_r = 80;															// радиус действия кнопок
button_a = 0;															// используется для остановки кнопок
button_x1 = view_wport[0]-300-button_r;									// левое значение х для кнопок вверх и вниз
button_x2 = view_wport[0]-300+button_r;									// правое значение х для кнопок вверх и вниз
button_y1_up = button_y-button_r;										// верхнее значение кнопки вверх
button_y2_up = button_y-(button_r/8);									// нижнее значение кнопки вверх
button_y1_down = button_y+(button_r/8);									// верхнее значение кнопки вниз
button_y2_down = button_y+button_r;										// нижнее значение кнопки вниз
