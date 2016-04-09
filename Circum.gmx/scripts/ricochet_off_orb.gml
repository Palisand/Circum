///ricochet_off_orb(orb)

var orb = argument0;

var dir = point_direction(orb.x, orb.y, x, y);
var diff = sqrt(sqr(orb.x - x) + sqr(orb.y - y)) - (orb.orbit_radius + radius);
// move out of orb
if (diff < 0) {
    x += lengthdir_x(abs(diff), dir);
    y += lengthdir_y(abs(diff), dir);
}

//if the player is thethered, switch orbit direction
if (tethered) {
    orbit_speed *= -1;
    ricochet_time = 0;
}

//otherwise, "bounce" off in appropriate direction
else {
    var obj_dir = direction - 180;
    var norm_dir = dir - 180;
    var incident_angle = angle_difference(obj_dir, norm_dir);
    direction = obj_dir + sign(norm_dir - 180) * incident_angle * 2;
}
