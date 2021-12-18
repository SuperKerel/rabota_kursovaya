/// Передвижение облаков
for(i=0;i<array_length_1d(clouds);i++){														// цикл облака
	layer_sprite_x(clouds[i], layer_sprite_get_x(clouds[i])+1);								// перемещение вправо
	if(layer_sprite_get_x(clouds[i]) > room_width){											// если находится за пределами конца экрана
		layer_sprite_x(clouds[i],-sprite_get_width(layer_sprite_get_sprite(clouds[i])));	// переиещение в начало экрана
	}
}

// процесс нажатия кнопок на экране
for(i=0;i<4;i++){																			// перебор доступных устройств мыши
	if(device_mouse_check_button(i,mb_left)){												// проверка, нажато ли устройство
		scrCheckPress(i);																	// обработка устройства
	}
}

//сброс всех кнопок, если какие-либо были отпущены
if((device_mouse_check_button_released(0,mb_left)) || (device_mouse_check_button_released(1,mb_left))  || (device_mouse_check_button_released(2,mb_left))  || (device_mouse_check_button_released(3,mb_left)) ){
	button_pressed = false;
	button_down_left = false;
	button_down_right = false;
	button_down_up = false;
	button_down_down = false;
}

if(button_pressed == true){																	// если была нажата какая-ибо кнопка
	button_a += (0.6 - button_a) * 0.4;														// время активации и действия кнопки
} else {
	button_a += (0 - button_a) * 0.1;														// время отключения кнопки
}
