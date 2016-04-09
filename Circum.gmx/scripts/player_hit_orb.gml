//Called when player is not orbiting (flying around or tethered)
//player_hit_orb(orb, orb_obj)

var orb = argument0;
var orb_obj = argument1;

// if the player will collide with the orbit in the next step
if (point_in_circle(x + hspeed, y + vspeed, orb.x, orb.y, orb.orbit_radius)) {
    // set orb collision status if not yet set
    if (!col_orb_set) {
        col_orb_set = true;
        orb.col_player = true;
    }
    
    var to_orb_dir = point_direction(x, y, orb.x, orb.y);
    
    switch (orb.type) {
    case VOID_ORB:
        collision_hit_burst(
            x, y, 0, 360,
            color, 300, 60, orb.p_emitter, orb.p_type
        );
        color = c_white;
        room_speed = 20;
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
        current_orb = orb;
        tethered = false;
        
        enter_the_void = true;      
        audio_sound_pitch(audio_play_sound(snd_death, 0, 0), 1/3);
        break;
    case MASTER_ORB:
        // player wins iff the master orb is unguarded
        if (!orb.guarded || orb.guarder == id) {
            //set to max
            num_orb_captured = instance_number(orb_obj);  
        }
        break;
    case DEAD_ORB:
        capture_streak = 0;
        ricochet_off_orb(orb);
        play_ricochet(++ricochet_streak, scale);
        break;    
    case DEFAULT_ORB:
        // if GUARDED orb
        if (orb.guarded) {
            // if OPPONENT-GUARDED (multiplayer)
            if (orb.guarder != id) {
                ricochet_off_orb(orb);
                collision_hit_burst(
                    x, y, to_orb_dir - 180 - 90, to_orb_dir - 180 + 90,
                    orb.guarder.color, 300, 60, orb.p_emitter, orb.p_type
                );
                capture_streak = 0;  // reset capture streak
                play_ricochet(++ricochet_streak, scale);
            }
            // if SELF-GUARDED and this is SINGLE PLAYER, release
            if (orb.guarder == id && (instance_exists(o_single_handler) || instance_exists(o_handler_debug))) {
                ricochet_off_orb(orb);
                collision_hit_burst(
                    x, y, to_orb_dir - 180 - 90, to_orb_dir - 180 + 90,
                    orb.guarder.color, 300, 60, orb.p_emitter, orb.p_type
                );
                capture_streak = 0;  // reset capture streak
                play_ricochet(++ricochet_streak, scale);
                
                orb.guarded = false;
                // Visuals
                room_speed = 20;
                with (instance_create(orb.x, orb.y, o_release_effect)) {
                    color = orb.color;
                }
                instance_create(x, y, o_shockwave);
                // Reset orb capture status 
                orb.captured = false;
                orb.capturer = -1; // default
                // Reset orb color
                orb.color = c_white;
            }
        }
        // if OPPONENT-CAPTURED orb
        else if (orb.captured && orb.capturer != id) {
            play_ricochet(++ricochet_streak, scale);
            
            ricochet_off_orb(orb);
            collision_hit_burst(
                x, y, to_orb_dir - 180 - 90, to_orb_dir - 180 + 90,
                orb.color, 300, 60, orb.p_emitter, orb.p_type
            );
            capture_streak = 0;  // reset capture streak
            
            // if player is tethered to an owned orb, it can Release opponent orbs
                     
            if ((tethered && global.hammer)) { // (ricochet_reward == THEFT || ricochet_reward == RELEASE) {
                // Decrement opponent player capture count
                orb.capturer.num_orb_captured--;
                // Visuals
                room_speed = 20;
                with (instance_create(orb.x, orb.y, o_release_effect)) {
                    color = orb.color;
                }
                instance_create(x, y, o_shockwave);
                // Reset orb capture status 
                orb.captured = false;
                orb.capturer = -1; // default
                // Reset orb color
                orb.color = c_white;
            }
            
            /* No Theft... for now    
            if (ricochet_reward == THEFT) {
                // Reset streak (since highest reward used)
                ricochet_streak = 0;
                set_to_orbit(orb, to_orb_dir);
                capture_orb(orb, orb_obj);
                // Reset ricochet_reward
                ricochet_reward = NONE;
            }
            */
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
