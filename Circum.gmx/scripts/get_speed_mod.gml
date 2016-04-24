/// get_speed_mod()

var speed_mod = irandom (80) - 40;

speed_mod = (speed_mod / 100);
if (speed_mod > 0){
    speed_mod += 0.2;
}
else {
    speed_mod -= 0.2;
}

return speed_mod;
