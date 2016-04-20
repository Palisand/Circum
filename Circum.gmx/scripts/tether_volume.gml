player = argument0;
orb = argument1;

vol = 0;
dis = abs(player.x - orb.x);
max_dis = distance(player, orb);

return dis / max_dis;
