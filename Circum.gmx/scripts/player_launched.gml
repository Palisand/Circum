// player_launched(orb_obj)

//Called when player is neither tethered nor orbiting
var orb_obj = argument0;

// update nearest orb (cannot be VOID or CAPTURED)
if (nearest_orb != -1) {
    dist_to_nearest = point_distance(x, y, nearest_orb.x, nearest_orb.y);
}
with (orb_obj) {
    if (type != VOID_ORB && (!captured || capturer.id == other.id)) {
        dist_to_orb = point_distance(x, y, other.x, other.y);
        if (dist_to_orb < other.dist_to_nearest) {
            other.dist_to_nearest = dist_to_orb;
            other.nearest_orb = id;
        }
    }
}

// tether
if (keyboard_check_pressed(action_key) && nearest_orb != -1) {
    current_orb = nearest_orb;
    current_orb.halt = true;
    tethered = true;
    orbit = point_direction(x, y, nearest_orb.x, nearest_orb.y);
    orbit_speed = sign(angle_difference(orbit, direction)) * orbit_speed_set;
    tether_radius = point_distance(x, y, nearest_orb.x, nearest_orb.y); // distance(self,current_orb);
    latch_time = get_timer();
}
