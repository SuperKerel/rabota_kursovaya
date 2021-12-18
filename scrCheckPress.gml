/// scrCheckPress(device,x1,y1,x2,y2);
function scrCheckPress(argument0) {

	device = argument0;


	if(device_mouse_y_to_gui(device) == clamp(device_mouse_y_to_gui(device),button_y-button_r,button_y+button_r)){								// проверяет, находится ли мышь в области кнопки
		if(device_mouse_x_to_gui(device) == clamp(device_mouse_x_to_gui(device),button_x_left-button_r,button_x_left+button_r)){				// проверяет, находится ли она на левой кнопке
			// левая
			button_pressed = true;																												// выделяет нажатую кнопку
			button_down_left = true;																											// активирует кнопку
		}
		if(device_mouse_x_to_gui(device) == clamp(device_mouse_x_to_gui(device),button_x_right-button_r,button_x_right+button_r)){				// проверяет, находится ли она на правой кнопке
			// правая
			button_pressed = true;																												// выделяет нажатую кнопку
			button_down_right = true;																											// активирует кнопку
		}
		if(device_mouse_x_to_gui(device) == clamp(device_mouse_x_to_gui(device),button_x1,button_x2)){											// проверяет, нахдится ли мышь на кнопках вверх/вниз
			// блок взбирания по лестнице
			button_pressed = true;																												// выделяет нажатую кнопку
			if(device_mouse_y_to_gui(device) == clamp(device_mouse_y_to_gui(device),button_y1_up,button_y2_up)){								// проверяет кнопку вверх
				// вверх
				button_down_up = true;																											// активирует
			}
			if(device_mouse_y_to_gui(device) == clamp(device_mouse_y_to_gui(device),button_y1_down,button_y2_down)){							// проверяет кнопку вниз
				// вниз
				button_down_down = true;																										// активирует кнопку
			}
		
		}
	
	
		if(device_mouse_x_to_gui(device) == clamp(device_mouse_x_to_gui(device),button_x_jump-(button_r/2),button_x_jump+(button_r/2))){		// проверяет, есть ли кнопка прыжка
			button_pressed = true;																												// проверяет кнопку
			with(oPlayer){
				if( jump ) exit;																												// если мы уже прыгаем, то ничего не делать
				grav=grav_jump;																													// игрок прыгает
				jump=true;																														// отметить, что игрок прыгает
			}
		}
	}
}
