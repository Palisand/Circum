// player_launched(orb_obj)

//Called when player is neither tethered nor orbiting
var orb_obj = argument0;

// update nearest orb (cannot be VOID or CAPTURED)
if (nearest_orb != -1) {
    dist_to_nearest = point_distance(x, y, nearest_orb.x, nearest_orb.y);
    
    // move towards nearest free orb if close enough
    if (global.orb_gravity_on && nearest_orb.type == DEFAULT_ORB && !nearest_orb.captured && dist_to_nearest < 100) {
        orb_pull_speed = lerp(orb_pull_speed, launch_speed, 0.5);
        var dir = point_direction(x, y, nearest_orb.x, nearest_orb.y);
        direction = angle_approach(direction, dir, orb_pull_speed);
    }
    else {
        orb_pull_speed = lerp(orb_pull_speed, 0, 0.1);
    }
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
