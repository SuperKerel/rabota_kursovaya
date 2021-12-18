if(health < 3){				// если у игрока макс. хп
	health++;				// добавить один хп
	with(other){			// уничтожить объект
		instance_destroy();
		}
}
