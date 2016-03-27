///ricochet_off_orb(orb, is_orb)

var orb = argument0;
var is_orb = argument1;
var dir = point_direction(orb.x, orb.y, x, y);  // direction from orb center to self center

// TODO: try with this commented out
/* is these needed for orb-orb since it is already included in orb_hit_orb? */
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
/* ------------------------------------------------------------------------- */

// "bounce" off in appropriate direction
var obj_dir = direction - 180;
var norm_dir = dir - 180;
var incident_angle = angle_difference(obj_dir, norm_dir);
direction = obj_dir + sign(norm_dir - 180) * incident_angle * 2;
