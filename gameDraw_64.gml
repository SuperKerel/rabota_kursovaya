for(i=0;i<health;i++){												// проверерка количества имеющихся сердец
	draw_sprite(sHeart,0,50+(sprite_get_width(sHeart)*i),50);		// отображение текущего количества
}
draw_set_valign(fa_middle);											// использовать середину вертикального расположения
draw_set_halign(fa_right);											// использовать правую позицию горизонтального расположения
draw_set_colour(c_black);											// выбор цвета текста
draw_sprite(sPickupEnergy,0,view_wport[0]-50,50);						// отобразить спрайт энергетика
draw_text(view_wport[0]-20-sprite_get_width(sPickupEnergy),57,score);	// отобразить количество энергетиков

	// элементы управления на экране
draw_set_colour(c_white);											// задать цвет кнопок
draw_set_alpha(button_a);											// установить альфа-значение
draw_circle(button_x_left,button_y,button_r,false);					// отобразить левую кнопку
draw_circle(button_x_right,button_y,button_r,false);				// отобразить правую кнопку
draw_roundrect(button_x1,button_y1_up,button_x2,button_y2_up,false);		// отобразить кнопку вверх
draw_roundrect(button_x1,button_y1_down,button_x2,button_y2_down,false);	// и кнопку вниз
draw_circle(button_x_jump,button_y,button_r,false);					// кнопку прыжка
draw_set_alpha(1);													// сбросить альфа значение		
