/// player_update(player_obj, orb_obj);

var player_obj = argument0;
var orb_obj = argument1;

// screen edge collision
edge_bounce_circle(radius);

if (col_edge) {
    col_edge = false;
    
    if (tethered) {
        orbit_speed = -orbit_speed;  // reverse orbit speed
        ricochet_streak = 0;
    }
    
    // Remove capture streak
    capture_streak = 0;
    
    // Ricochet Streak Update
    // Increment the Ricochet Streak counter if the streak has already started
    if (ricochet_streak > 0) {
        ricochet_streak++;
        
        // Play ricochet sound
        var s_engine = audio_play_sound(snd_ricochet, 0, 0);
        // Modify the ricochet sound to reflect the value of ricochet_streak
        if (ricochet_streak < 8) {
            audio_sound_pitch(s_engine, scale[ricochet_streak]);
        }
        else {
            // If ricochet_streak is > 8, return to the bottom of the scale
            audio_sound_pitch(s_engine, scale[ricochet_streak % 8]);
        }
    }
    
    // Moving to the center
    // Player can face the center if they are using the action key on the edge
    if (keyboard_check(action_key)) {
        direction = point_direction (x, y, room_width/2, room_height/2); // Set direction to center of room
    }
}

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

if (tethered) {
    // the orb being tethered is stationary
    current_orb.speed = lerp(current_orb.speed, 0, 0.1);
    
    // Tether Orbit
    orbit += orbit_speed;
    x = current_orb.x - cos(degtorad(orbit)) * dist_to_nearest;
    y = current_orb.y + sin(degtorad(orbit)) * dist_to_nearest;
    // set direction to orbit tangent
    direction = orbit - (sign(orbit_speed) * 90);
    
    // Launch on key-release
    if (keyboard_check_released(action_key)) {
        speed = launch_speed;
        tethered = false;
        current_orb.speed = current_orb.initial_speed;
    }
    
}

//if we are orbiting an orb
if (orbiting) {
    // the orb being orbited is stationary
    current_orb.speed = lerp(current_orb.speed, 0, 0.1);
    
    // Orbit
    orbit += orbit_speed;
    x = current_orb.x - cos(degtorad(orbit)) * current_orb.orbit_radius;
    y = current_orb.y + sin(degtorad(orbit)) * current_orb.orbit_radius;
    // set direction to orbit tangent
    direction = orbit - (sign(orbit_speed) * 90);
    
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
}
//we're flying around the room or tethered
else {
    speed = launch_speed;
    
    if (! tethered) {
        // update nearest FREE or OWNED orbs
        if (nearest_orb != -1) {
            dist_to_nearest = point_distance(x, y, nearest_orb.x, nearest_orb.y);
        }
        
        with (orb_obj) {
            if (!captured || capturer.id == other.id) {
                dist_to_orb = point_distance(x, y, other.x, other.y);
                if (dist_to_orb < other.dist_to_nearest) {
                    other.dist_to_nearest = dist_to_orb;
                    other.nearest_orb = id;
                }
            }
        }
        
        // tether (if not already tethered)
        if (keyboard_check_pressed(action_key) && nearest_orb != -1) {
            current_orb = nearest_orb;
            tethered = true;
            orbit = point_direction(x, y, nearest_orb.x, nearest_orb.y);
            orbit_speed = sign(angle_difference(orbit, direction)) * orbit_speed_set;
        }
    }
    
    // check against all other orbs
    for (var i = 0; i < instance_number(orb_obj); i++) {
        var orb = instance_find(orb_obj, i);

        // if the player will collide with the orbit in the next step
        if (point_in_circle(x + hspeed, y + vspeed, orb.x, orb.y, orb.orbit_radius)) {
            
            // set orb collision status if not yet set
            if (!col_orb_set) {
                col_orb_set = true;
                orb.col_player = true;
            }
            
            switch (orb.type) {
                case VOID_ORB:
                    // for every orb the player once owned, reset it
                    with (orb_obj) {
                        if (capturer == other.id) {
                            captured = false;
                            capturer = -1;
                            color = c_white;
                        }
                        if (guarder == other.id) {
                            guarded = false;
                            guarder = -1;
                        }
                    }            
                    instance_destroy();  // player dies
                    break;
                case MASTER_ORB:
                    // player wins iff the master orb is unguarded
                    if (!orb.guarded || orb.guarder == id) {
                        //set to max
                        num_orb_captured = instance_number(orb_obj);  
                    }
                    break;
                case DEAD_ORB:
                    ricochet_streak++;
                    capture_streak = 0;
                    ricochet_off_orb(orb, false);
                    break;
                case DEFAULT_ORB:
                    var to_orb_dir = point_direction(x, y, orb.x, orb.y);
                    // if OPPONENT-GUARDED orb
                    if (orb.guarded && orb.guarder != id) {
                        ricochet_off_orb(orb, false);
                        collision_hit_burst(
                            x, y, to_orb_dir - 180 - 90, to_orb_dir - 180 + 90,
                            orb.guarder.color, 300, 60, orb.p_emitter, orb.p_type
                        );
                        capture_streak = 0;  // reset capture streak
                        ricochet_streak++;
                        
                        // Play ricochet sound
                        var s_engine = audio_play_sound(snd_ricochet, 0, 0);
                        // Modify the ricochet sound to reflect the value of ricochet_streak
                        if (ricochet_streak < 8) {
                            audio_sound_pitch(s_engine, scale[ricochet_streak]);
                        }
                        else {
                            // If ricochet_streak is > 8, return to the bottom of the scale
                            audio_sound_pitch(s_engine, scale[ricochet_streak % 8]);
                        }
                    }
                    // if OPPONENT-CAPTURED orb
                    else if (orb.captured && orb.capturer != id) {
                        ricochet_streak++;
                        
                        // Play ricochet sound
                        var s_engine = audio_play_sound(snd_ricochet, 0, 0);
                        // Modify the ricochet sound to reflect the value of ricochet_streak
                        if (ricochet_streak < 8) {
                            audio_sound_pitch(s_engine, scale[ricochet_streak]);
                        }
                        else {
                            // If ricochet_streak is > 8, return to the bottom of the scale
                            audio_sound_pitch(s_engine, scale[ricochet_streak % 8]);
                        }
                        
                        // the only time a player will not bounce off an opponent's orb
                        // is when the player is stealing
                        if (ricochet_reward != THEFT) {
                            ricochet_off_orb(orb, false);
                            collision_hit_burst(
                                x, y, to_orb_dir - 180 - 90, to_orb_dir - 180 + 90,
                                orb.color, 300, 60, orb.p_emitter, orb.p_type
                            );
                            capture_streak = 0;  // reset capture streak
                        }
                        
                        // Common to ALL ricochet rewards
                        if (global.hammer || ricochet_reward == THEFT || ricochet_reward == RELEASE) {
                            // Decrement opponent player capture count
                            orb.capturer.num_orb_captured--; // MUST OCCUR BEFORE THEFT CHECK BELOW!
                            // Slow-Mo!!!
                            room_speed = 20;
                        }
                        
                        if (ricochet_reward == THEFT) {
                            // Reset streak (since highest reward used)
                            ricochet_streak = 0;
                            capture_orb(orb, orb_obj);
                            // Reset ricochet_reward
                            ricochet_reward = NONE;
                        }
                        else if (global.hammer || ricochet_reward == RELEASE) {
                            // Visuals
                            with (instance_create(orb.x, orb.y, o_release_effect)) {
                                color = orb.color;
                            }
                            // Reset orb capture status 
                            orb.captured = false;
                            orb.capturer = -1; // default
                            // Reset orb color
                            orb.color = c_white;
                            // Reset ricochet_reward
                            ricochet_reward = NONE;
                        }
                    }
                    // if OWNED orb
                    else if (orb.captured && orb.capturer == id) {
                        set_to_orbit(orb, to_orb_dir);
                        // reset all streaks
                        possession_streak_used = false;
                        capture_streak = 0;
                    } 
                    // if FREE orb
                    else if (!orb.captured) {
                        set_to_orbit(orb, to_orb_dir);
                        capture_orb(orb, orb_obj);
                    }
                    break;   
            }
        }
    }
}
