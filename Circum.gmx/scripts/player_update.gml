/// player_update(player_type, orb_type);

var player_obj = argument0;
var orb_obj = argument1;

// screen edge collision
edge_bounce_circle(radius);

// Ricochet Streak Update
// Check if our streak is high enough for a streak reward / power-up
if (ricochet_streak == RELEASE) {
    ricochet_reward = RELEASE;
}
else if (ricochet_streak == THEFT) {
    ricochet_reward = THEFT;
}

// reset orb collision set flag (otherwise landing on a free or owned orb won't result in a radius reveal)
col_orb_set = false;

// On edge collision
if (col_edge) {
    col_edge = false;
    
    // Remove capture streak
    capture_streak = 0;
    
    // Ricochet Streak Update
    // Increment the Ricochet Streak counter if the streak has already started
    if (ricochet_streak > 0) {
        ricochet_streak++;
    }
    
    // Moving to the center
    // Player can face the center if they are using the action key on the edge
    if (keyboard_check(action_key)) {
        direction = point_direction (x, y, room_width / 2, room_height / 2); // Set direction to center of room
    }
}

//if we are orbiting an orb
if (orbiting) {
    // the orb being orbited is stationary
    current_orb.speed = lerp(current_orb.speed, 0, 0.1);
    // Launch
    if ((keyboard_check_pressed(action_key)  // on action if there isn't a winner
        && (player_obj == o_player_debug || (player_obj == o_player && global.winner < 0)))
        || (current_orb.guarded && current_orb.guarder != id)  // if the orb is or has become guarded
        || current_orb.capturer != id  // the orb no longer belongs to the player
        ) {
        speed = launch_speed;
        orbiting = false;
        // reset orb speed and set direction
        current_orb.speed = current_orb.initial_speed;
        current_orb.direction = point_direction(x, y, current_orb.x, current_orb.y);
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

            // set orb collision status if not yet set
            if (!col_orb_set) {
                col_orb_set = true;
                orb.col_player = true;
            }
             
            // if the collision will be with a void orb, die
            if (orb.type == VOID_ORB) {
                instance_destroy();
                break;
            }
            
            // Ricochet Streak Update
            // The following is a check to see if we are hitting an enemy-owned orb, if so...
            // Start the streak counter if it hasn't been started already, otherwise, increase the counter
            if (orb.type == DEAD_ORB) {
                ricochet_streak++;
            }
            
            if (orb.type == DEFAULT_ORB && orb.captured && orb.capturer != id) {
                
                ricochet_streak++;   // This will increment streak or start one if needed
                
                // Ricochet "Theft" Effect - Release and capture orb
                // Player will release the enemy orb at this point and it will be captured later in the function
                // The orb must be an opponent captured orb and we must have the Ricochet reward
                if (ricochet_reward == THEFT) {
                    // Decrement opponent player capture count
                    orb.capturer.num_orb_captured--;
                    
                    // Reset the orb
                    orb.captured = false;   // The orb is no longer considered "captured"
                    orb.capturer = -1;      // The default capturer condition is -1
                
                    // Since we just gave out the highest reward, we will reset streak and reward
                    ricochet_reward = NONE;
                    ricochet_streak = 0;
                }
            }
            
            var to_orb_dir = point_direction(x, y, orb.x, orb.y);
            
            // if the collision will be with an opponent-captured orb
            if ((orb.type == DEFAULT_ORB && orb.captured && orb.capturer != id)
                // OR a dead orb
                || orb.type == DEAD_ORB
                // OR an opponent-guarded orb (as a result of a capture streak)
                || orb.guarded && orb.guarder != id) {
                
                // Ricochet "Release" Effect - Orb capture status is unset
                // Player will still ricochet off of the enemy orb...
                // Except as it "leaves" orbit, the orb is reset to uncaptured
                if (orb.type == DEFAULT_ORB && orb.captured && orb.capturer != id && ricochet_reward == RELEASE) {
                    // Decrement opponent player capture count
                    orb.capturer.num_orb_captured--;
                    
                    // Reset the orb
                    orb.captured = false;   // The orb is no longer considered "captured"
                    orb.capturer = -1;      // The default capturer condition is -1
                
                    // Since we just gave out the x3 reward, we will reset ricochet_reward to 0
                    ricochet_reward = NONE;
                }
                                
                ricochet_off_orb(orb, false);
                collision_hit_burst(
                    x, y, to_orb_dir - 180 - 90, to_orb_dir - 180 + 90,
                    orb.color, 300, 60, orb.p_emitter, orb.p_type
                );
                capture_streak = 0;
                break;
            }
            
            // translate into orbit
            orbit = to_orb_dir;
            x = orb.x - cos(degtorad(orbit)) * orb.orbit_radius;
            y = orb.y + sin(degtorad(orbit)) * orb.orbit_radius;
            // set clockwise or counter-clockwise orbit depending on collision angle
            orbit_speed = sign(angle_difference(orbit, direction)) * orbit_speed_set;
            if (orbit_speed == 0) {
                orbit_speed = choose(orbit_speed_set, -orbit_speed_set);
            }
            
            // we bumped into one of our own, streak statuses reset
            if (orb.captured && orb.capturer == id) {
                possession_streak_used = false;
                capture_streak = 0;
                ricochet_streak = 0;
            }
            
            // set orb capture status if not yet captured
            if (orb.type == DEFAULT_ORB && !orb.captured) {
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
    
    // Reset orb speed (now reset on launch)
    /*
    if (current_orb != -1) {
        current_orb.speed = lerp(current_orb.speed, current_orb.initial_speed, 0.1);
    }*/
    
    speed = launch_speed;
}
