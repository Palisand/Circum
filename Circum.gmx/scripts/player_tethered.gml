// the orb being tethered is stationary
current_orb.halt = true;

// Tether Orbit
orbit += orbit_speed;
x = current_orb.x - cos(degtorad(orbit)) * dist_to_nearest;
y = current_orb.y + sin(degtorad(orbit)) * dist_to_nearest;
// set direction to orbit tangent
direction = orbit - (sign(orbit_speed) * 90);

// Launch on key-release
if (keyboard_check_released(action_key)) {
    current_orb.halt = false;
    speed = launch_speed;
    tethered = false;
}
