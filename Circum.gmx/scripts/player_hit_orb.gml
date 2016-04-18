//Called when player is not orbiting (flying around or tethered)
//player_hit_orb(orb, orb_obj)

var orb = argument0;
var orb_obj = argument1;
var orad = orb.orbit_radius;
//unguarded void orbs should be harder to hit
if (orb.type == VOID_ORB && !orb.guarded) { orad = orb.radius; }

// if the player will collide with the orbit in the next step
if (point_in_circle(x + hspeed, y + vspeed, orb.x, orb.y, orad)) {
    // set orb collision status if not yet set
    if (!col_orb_set) {
        col_orb_set = true;
        orb.col_player = true;
    }
    
    var to_orb_dir = point_direction(x, y, orb.x, orb.y);
    
    switch (orb.type) {
        case VOID_ORB:
            if (orb.guarded) {
                ricochet_off_orb(orb,orad);
                collision_hit_burst(
                    x, y, to_orb_dir - 180 - 90, to_orb_dir - 180 + 90,
                    c_white, 300, 60, orb.p_emitter, orb.p_type
                );
                capture_streak = 0;  // reset capture streak
                play_ricochet(++ricochet_streak, scale);
            }
            else {
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
            }
            break;
        case MASTER_ORB:
            //bounce off the orb if we've got one recently
            if (orb.guarded) {
                ricochet_off_orb(orb,orad);
                collision_hit_burst(
                    x, y, to_orb_dir - 180 - 90, to_orb_dir - 180 + 90,
                    c_white, 300, 60, orb.p_emitter, orb.p_type
                );
                capture_streak = 0;  // reset capture streak
                play_ricochet(++ricochet_streak, scale);
                
                break; 
            }
            
            //otherwise, orbit it...
            set_to_orbit(orb, to_orb_dir);
            collision_hit_burst(orb.x, orb.y, 0, 360, c_white, 300, 60, orb.p_emitter, orb.p_type);
            
            //...and apply the key effect
            with (orb_obj) {
                var player_id = other.id;
                var orb_id = id;
                //once you hit a master orb, prevent from happening again until timeout
                if (type == MASTER_ORB) {
                    guarded = true;
                    guarder = player_id;
                    alarm[0] = GUARD_TIME;
                }
                
                // send payloads to void and captured orbs
                else if (type == VOID_ORB || (captured && capturer != player_id)) {
                    var pyld = instance_create(orb.x, orb.y, o_payload);
                    pyld.sender = player_id;
                    pyld.target = orb_id;
                }
            }   
            
            
            room_speed = 30;
            
            break;
            
        case DEAD_ORB:
            capture_streak = 0;
            play_ricochet(++ricochet_streak, scale);
            ricochet_off_orb(orb,orad);
            break;    
        case DEFAULT_ORB:
            // if CAPTURED orb
            if (orb.captured && orb.capturer != id) {
                ricochet_off_orb(orb,orad);
                collision_hit_burst(
                    x, y, to_orb_dir - 180 - 90, to_orb_dir - 180 + 90,
                    orb.color, 300, 60, orb.p_emitter, orb.p_type
                );
                capture_streak = 0;  // reset capture streak
    
                // if a player is tethered, it can release captured orbs
                if ((tethered && global.hammer)) {
                    // Decrement opponent player capture count
                    orb.capturer.num_orb_captured--;
                    // Visuals
                    room_speed = 20;
                    with (instance_create(orb.x, orb.y, o_release_effect)) {
                        color = orb.color;
                    }
                    instance_create(x, y, o_shockwave);
                    // Reset orb
                    orb.captured = false;
                    orb.capturer = -1;
                    orb.color = c_white;
                    audio_sound_pitch(audio_play_sound(snd_release, 0, 0), 4/3);
                }
                else { play_ricochet(++ricochet_streak, scale); }
            }
            // if OWNED orb
            else if (orb.captured && orb.capturer == id) {
                set_to_orbit(orb, to_orb_dir);
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
