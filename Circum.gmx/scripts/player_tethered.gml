/// player_tethered()

// the orb being tethered is stationary
current_orb.halt = true;

// Tether Orbit
if (current_orb.captured == false) {
    dist_to_nearest -= homing_speed;
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
var key_launch;

if (global.tap_tether) {
    key_launch = keyboard_check_pressed(action_key);
}
else {
    key_launch = keyboard_check_released(action_key);
}

if (keyboard_check_released(action_key)) {
    holding_button = false;
}

var hold_check = !global.tap_tether || (global.tap_tether && !holding_button);

if (key_launch && hold_check) {
    holding_button = true;
    current_orb.halt = false;
    speed = launch_speed;
    tethered = false;
}
