score++;						// увеличить счёт игрока
with(other){					// уничтожить объект
	instance_destroy();
}

if(!instance_exists(oEnergy)){	// если энергетики на уровне кончатся
	if(room == rGrass){			// если игрок на уровне травы
		room_goto_next();		// переместить на уровень песка
	} else {					// если игрок на уровне песка
		room_goto_previous();	// переместить на уровень травы
	}
}
