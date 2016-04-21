/// player_tethered()

// the orb being tethered is stationary
current_orb.halt = true;

// Tether Orbit
if (current_orb.type != DEAD_ORB && current_orb.captured == false) {
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
if (keyboard_check_released(action_key)  // on key-release
    // or if the orb is captured by an opponent (i.e. not released anymore)
    || (current_orb.captured && current_orb.capturer != id)
    ) {
    current_orb.halt = false;
    speed = launch_speed;
    tethered = false;
}
