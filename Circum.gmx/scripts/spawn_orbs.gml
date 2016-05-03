/// spawn_orbs(fixed, ring_radius, ring_speed, ring_offset, orb_amount, origin_dist, origin_dir, origin_speed, orb_rad)

var fixed = argument0;          // boolean
var ring_radius = argument1;
var ring_speed = argument2;     // negative for counter-clockwise
var ring_offset = argument3;
var orb_amount = argument4;
var origin_dist = argument5;    // 'dist'ance from screen center
var origin_dir = argument6;     // 'dir'ection from screen center
var origin_speed = argument7;
var orb_rad = argument8;      // array or a valid radius

var index = 0;
for (var dir = 0; dir < 360; dir += 360/orb_amount) {
    orb = instance_create(0, 0, o_orb);
    if (is_array(orb_rad)) {
        orb.orbit_radius = orb_rad[index];
        orb.radius = orb.orbit_radius / 2;
        orb.draw_scale = orb.radius * 2/sprite_get_width(s_ring);
        index = (index + 1) % array_length_1d(orb_rad);
    }
    else if (orb_rad == RAD_SMALL || orb_rad == RAD_AVRG || orb_rad == RAD_LARGE) {
        orb.orbit_radius = orb_rad;
        orb.radius = orb.orbit_radius / 2;
        orb.draw_scale = orb.radius * 2/sprite_get_width(s_ring);
    }
    
    if (fixed) {
        orb.fixed = true;
        orb.fixed_orbit = dir + ring_offset;
        orb.fixed_orbit_speed = ring_speed;
        orb.fixed_orbit_radius = ring_radius;
        orb.fixed_origin_dist = origin_dist;
        orb.fixed_origin_dir = origin_dir;
        orb.fixed_origin_speed = origin_speed;
    }
    else {
        orb.x = SCREEN_RADIUS + lengthdir_x(origin_dist, origin_dir) + lengthdir_x(ring_radius, dir + ring_offset);
        orb.y = SCREEN_RADIUS + lengthdir_y(origin_dist, origin_dir) + lengthdir_y(ring_radius, dir + ring_offset);
    }
}
