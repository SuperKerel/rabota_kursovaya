// ссылка на скрипт передвижения
scrProcessPlayer();
if (health <= 0) then	 // если жизни кончились
{
  sprite_index = sDeath  // текущий спрайт заменяется на спрайт смерти
   image_speed = 1       // скорость анимации спрайта
xspeed = 0   // скорость игрока становится нулю, чтобы анимация смерти не обрывалась
 if image_index = 12  // когда анимация спрайта смерти доходит до кадра 12 
 {
 game_restart() // игра перезапускается
 }

   }
   