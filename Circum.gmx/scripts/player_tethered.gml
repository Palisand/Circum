/// player_tethered()

// the orb being tethered is stationary
current_orb.halt = true;

// Tether Orbit
if (!current_orb.captured) {
	global.pre_fix_trail = true;
    // home in on orb
    dist_to_nearest -= homing_speed;
    // visuals
    var dir = point_direction(x, y, current_orb.x, current_orb.y);
    part_system_depth(global.p_system, -99);
    part_type_sprite(p_type, s_line, false, false, false);
    part_type_blend(p_type, true);
    part_type_alpha2(p_type, 1, 0);
    part_type_colour2(p_type, color, current_orb.color);
    part_type_direction(p_type, dir, dir, 0, 0);
    part_type_speed(p_type, 0, 8, 0, 0);
    part_type_size(p_type, 0.2, 0.2, 0, 0);
    part_type_life(p_type, 1, 60);
    part_type_orientation(p_type, 0, 0, 0, 0, true);
    part_type_scale(p_type, 1, 1);
    part_emitter_region(global.p_system, p_emitter, x, x, y, y, ps_shape_line, ps_distr_linear);
    part_emitter_burst(global.p_system, p_emitter, p_type, 5);
}
else {
    global.pre_fix_trail = false;
}

var tether_orbit_speed = sign(orbit_speed) * (launch_speed * room_speed) / dist_to_nearest;
var fastest = tether_cap*orbit_speed
if (abs(tether_orbit_speed) > abs(fastest)) {
    tether_orbit_speed = fastest;
}

orbit += tether_orbit_speed;
x = current_orb.x - cos(degtorad(orbit)) * dist_to_nearest;
y = current_orb.y + sin(degtorad(orbit)) * dist_to_nearest;
// set direction to orbit tangent
direction = orbit - (sign(orbit_speed) * 90);

// Launch
if (keyboard_check_released(action_key)  // on key-release
    // or if the orb is captured by an opponent (i.e. not released anymore)
    || (current_orb.captured && current_orb.capturer != id)
    ) {
    current_orb.halt = false;
    speed = launch_speed;
    tethered = false;
}
