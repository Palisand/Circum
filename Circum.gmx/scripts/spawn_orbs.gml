/// spawn_orbs(fixed, ring_radius, ring_speed, ring_offset, orb_array)

var fixed = argument0;          // boolean
var ring_radius = argument1;
var ring_speed = argument2;     // negative for counter-clockwise
var ring_offset = argument3;
var orb_array = argument4;

var orb_array_len = array_length_1d(orb_array);
var index = 0;  // GML can't handle multiple loop variables?!?!
for (var dir = 0; dir < 360; dir += 360/orb_array_len) {
    orb = instance_create(0, 0, o_orb);
    set_orb_type(orb, orb_array[index++]);
    if (fixed) {
        orb.fixed = true;
        orb.fixed_orbit = dir + ring_offset;
        orb.fixed_orbit_speed = ring_speed;
        orb.fixed_orbit_radius = ring_radius;
    }
    else {
        orb.x = SCREEN_RADIUS + lengthdir_x(ring_radius, dir + ring_offset);
        orb.y = SCREEN_RADIUS + lengthdir_y(ring_radius, dir + ring_offset);
    }
}
