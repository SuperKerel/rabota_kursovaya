/// Инициализация
dir = -1;					// направление игрока
spd = 5;					// скорость движения игрока
g = 0.2;					// гравитация игрока
sprite_index = sidle1;		// стандартная анимация ожидания (бездействия)
anim_speed = 0.7;			// скорость анимации по умолчанию
image_speed = anim_speed;	// присвоение скорости анимации
health = 3;					// жизни игрока
can_climb = false;			// отметка, может ли игрок подняться
climbing = false;			// отметка, поднимается ли игрок
xspeed = 6;					// горизонтальная скорость игрока
yspeed = -6;				// вертикальная скорость игрока	
fall = false;				// отметка, если игрок падает
grav=0;						// сила тяжести, применяемая к игроку
gravmax=12;					// конечная скорость при падении
gravdelta=1.2;				// разница в силе тяжести
grav_jump = -18;			// гравитация прыжка (отрицательна, т.к. гравитация работает вниз)
jump=false;					// отметка, прыгает ли игрок

// камера следует за игроком
view_enabled = true;
view_visible[0] = true;
view_xport[0] = 0;
view_yport[0] = 0;
view_wport[0] = 960;
view_hport[0] = 540;
view_camera[0] = camera_create_view(0, 0, view_wport[0], view_hport[0], 0, oPlayer, -1, -1, 1000, 1000);
surface_resize(application_surface, 960, 540);
window_set_size(view_wport[0],view_hport[0]);


// установка мёртвой зоны для ввода с геймпада или клавиатуры
gamepad_set_axis_deadzone(0,0.2);
