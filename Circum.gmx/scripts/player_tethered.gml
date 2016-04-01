/// player_tethered()

// the orb being tethered is stationary
current_orb.halt = true;

// Tether Orbit
orbit += sign(orbit_speed) * (launch_speed * room_speed) / dist_to_nearest;
x = current_orb.x - cos(degtorad(orbit)) * dist_to_nearest;
y = current_orb.y + sin(degtorad(orbit)) * dist_to_nearest;
// set direction to orbit tangent
direction = orbit - (sign(orbit_speed) * 90);

// Launch
if (keyboard_check_released(action_key)  // on key-release
    || (current_orb.guarded && current_orb.guarder != id)  // if the orb is or has become guarded
    || (current_orb.captured && current_orb.capturer != id)  // the orb is captured by an opponent
    ) {
    current_orb.halt = false;
    speed = launch_speed;
    tethered = false;
}
