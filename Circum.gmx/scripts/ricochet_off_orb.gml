///ricochet_off_orb(orb)

var orb = argument0;
var dir = point_direction(orb.x, orb.y, x, y);  // direction from orb center to player
  
if (direction < dir) {
    direction -= dir;
}
else if (direction > dir) {
    direction += dir;
}
else {
    direction = -direction;
}

