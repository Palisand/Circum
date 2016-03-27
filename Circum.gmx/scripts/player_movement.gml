/// player_movement(player_type, orb_type);
// will work for both debug and regular players

var player_obj = argument0;
var orb_obj = argument1;

// screen edge collision
edge_bounce_circle(radius)

// increment capture streak on edge collision only if the streak has already been started
if (col_edge) {
    col_edge = false;
    if (capture_streak > 0) {
        capture_streak++;
    }
}

//check if other players' streaks affect you
/*
var ricochet_captured = false;
var ricochet_free = false;
for(var i = 0; i < instance_number(player_obj); i++){
    if (i == pid) { continue; }
    if (global.streak_time[i] + STREAK_TIMEOUT > get_timer()) {
        ricochet_captured = true;
        ricochet_free = ricochet_free or (global.streak_type[i] == DOMINATION);
    }
}
*/

//if we are orbiting an orb
if (orbiting) {
    // the orb being orbited is stationary
    current_orb.speed = lerp(current_orb.speed,0,0.1);
    // launch on action if there isn't a winner or if the orb is guarded
    if ((keyboard_check_pressed(action_key)
        && (player_obj == o_player_debug || (player_obj == o_player && global.winner < 0)))
        || (current_orb.guarded && current_orb.guarder != id)) {
        speed = launch_speed;
        orbiting = false;
    }
    // orbit
    orbit += orbit_speed;
    x = current_orb.x - cos(degtorad(orbit)) * current_orb.orbit_radius;
    y = current_orb.y + sin(degtorad(orbit)) * current_orb.orbit_radius;
    // set direction to orbit tangent
    direction = orbit - (sign(orbit_speed) * 90);
}
//we're flying around the room
else {

    //check against all other orbs
    for (var i = 0; i < instance_number(orb_obj); i++) {
        var orb = instance_find(orb_obj, i);

        // if the player will collide with the orbit in the next step
        if (point_in_circle(x + hspeed, y + vspeed, orb.x, orb.y, orb.orbit_radius)) {

            // if the collision will be with a void orb, die
            if (orb.type == VOID_ORB) {
                instance_destroy();
                break;
            }
            
            // if the collision will be with an opponent-captured orb
            if ((orb.type == DEFAULT_ORB && orb.captured && orb.capturer != id)
                // OR a dead orb
                || orb.type == DEAD_ORB
                // OR an opponent-guarded orb (as a result of a capture streak)
                || orb.guarded && orb.guarder != id) {
                    //OR opponent has a streak reward
                    //|| (orb.capturer == id && ricochet_captured)
                    //|| (!orb.captured && ricochet_free)) {
                ricochet_off_orb(orb, false);
                capture_streak = 0;
                break;
            }
            
            // translate onto orbit
            orbit = point_direction(x, y, orb.x, orb.y);
            x = orb.x - cos(degtorad(orbit)) * orb.orbit_radius;
            y = orb.y + sin(degtorad(orbit)) * orb.orbit_radius;
            // set clockwise or counter-clockwise orbit depending on collision angle
            orbit_speed = sign(angle_difference(orbit, direction)) * orbit_speed_set;
            if (orbit_speed == 0) {
                orbit_speed = choose(orbit_speed_set, -orbit_speed_set);
            }
            
            // set orb capture status if not yet captured
            if (!orb.captured) {
                orb.captured = true;
                orb.capturer = self.id;
                orb.color = self.color;
                num_orb_captured++;
                
                //Handle capture streaks
                capture_streak++;
                if (capture_streak >= POSSESSION  && capture_streak < DOMINATION && !possession_streak_used) {
                    possession_streak_used = true;
                    // launch payloads to opponent-captured orbs
                    with (orb_obj) {
                        var orb_id = id;
                        var sender_id = other.id;
                        if (type == DEFAULT_ORB && captured && capturer != other.id) {
                            with (instance_create(other.x, other.y, o_payload)) {
                                sender = sender_id;
                                target = orb_id;
                            }
                        }
                    }
                    //global.streak_time[pid] = get_timer();
                    //global.streak_type[pid] = POSSESSION;
                    //if (capture_streak == 5) { global.streak_type[pid] = DOMINATION; }
                }
                if (capture_streak >= DOMINATION) {
                    // launch payloads to opponent-captured orbs and free orbs (including master)
                    with (orb_obj) {
                        var orb_id = id;
                        var sender_id = other.id;
                        if ((type == DEFAULT_ORB || type == MASTER_ORB) 
                            && (!captured || (captured && capturer != other.id))) {
                            with (instance_create(other.x, other.y, o_payload)) {
                                sender = sender_id;
                                target = orb_id;
                            }
                        }
                    }
                    possession_streak_used = false;  // reset possession streak flag
                    capture_streak = 0; // reset capture streak counter
                }
            }
            // we bumped into one of our own, capture streak status reset
            else {
                possession_streak_used = false;
                capture_streak = 0;
            }
            
            // we're orbiting now
            speed = 0;
            orbiting = true;
            current_orb = orb;
                        
            // you won
            if (orb.type == MASTER_ORB) {
                num_orb_captured = instance_number(orb_obj);
            }
        }
    }
    
    // Reset orb speed
    if (current_orb != -1) {
        current_orb.speed = lerp(current_orb.speed,current_orb.initial_speed,0.1);
    }
    
    speed = launch_speed;
}
