/// player_launched(orb_obj)
/* When player is neither tethered nor orbiting */

var orb_obj = argument0;

// update nearest orb
if (nearest_orb != -1) {
    dist_to_nearest = point_distance(x, y, nearest_orb.x, nearest_orb.y);
}

with (orb_obj) {
    dist_to_orb = point_distance(x, y, other.x, other.y);
    if (dist_to_orb < other.dist_to_nearest) {
        other.dist_to_nearest = dist_to_orb;
        other.nearest_orb = id;
    }
}

if (keyboard_check_released(action_key)  // on key-release
)
{
    holding_button = false;
}
// tether
if (keyboard_check_pressed(action_key) && nearest_orb != -1 && !holding_button) {
    current_orb = nearest_orb;
    current_orb.halt = true;
    tethered = true;
    holding_button = true;
    orbit = point_direction(x, y, nearest_orb.x, nearest_orb.y);
    orbit_speed = sign(angle_difference(orbit, direction)) * orbit_speed_set;
    latch_time = get_timer();
}
