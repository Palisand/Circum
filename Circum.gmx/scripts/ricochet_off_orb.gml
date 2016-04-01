///ricochet_off_orb(orb, is_orb)

var orb = argument0;
var is_orb = argument1;

var dir = point_direction(orb.x, orb.y, x, y);  // direction from orb center to self center

// if an orb is calling this script, don't bother moving that orb out of the colliding orb
// since that functionality has already been implemented in orb_hit_orb()
if (!is_orb) {
    var diff = sqrt(sqr(orb.x - x) + sqr(orb.y - y)) - (orb.orbit_radius + radius);
    // move out of orb
    if (diff < 0) {
        x += lengthdir_x(abs(diff), dir);
        y += lengthdir_y(abs(diff), dir);
    }
    
}

//if the player is thethered, switch orbit direction
if (!is_orb && tethered) { orbit_speed *= -1; }

//otherwise, "bounce" off in appropriate direction
else {
    var obj_dir = (direction + 180) % 360;
    var norm_dir = dir - 180;
    var incident_angle = angle_difference(obj_dir, norm_dir);
    direction = obj_dir + sign((norm_dir + 180)%360) * incident_angle * 2;
}
