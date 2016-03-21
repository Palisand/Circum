///ricochet_off_orb(orb, is_orb)

/***** 
    ALERT!!!!
    Messing around in the debug room reveals this script is wrong.
    Objects reflect in the wrong direction!
*****/

var orb = argument0;
var is_orb = argument1;
var dir = point_direction(orb.x, orb.y, x, y);  // direction from orb center to self center

/* something like this should be in orb_hit_orb(), which would make the is_orb parameter useless */
var dist = point_distance(orb.x, orb.y, x, y);
var rad = radius;
if (is_orb) {
    var rad = orbit_radius;
}
var diff = sqrt(sqr(orb.x - x) + sqr(orb.y - y)) - (orb.orbit_radius + rad);
// move out of orb
if (diff < 0) {
    x += lengthdir_x(abs(diff), dir);
    y += lengthdir_y(abs(diff), dir);
}
/* -------------------------------------------------------------------------------------------- */

// "bounce" off in appropriate direction
if (direction < dir) {
    direction -= dir;
}
else if (direction > dir) {
    direction += dir;
}
else {
    direction = -direction;
}
