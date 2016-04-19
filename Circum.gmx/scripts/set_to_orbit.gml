// set_to_orbit(orb, to_orb_dir)

var orb = argument0;
// translate into orbit
orbit = argument1;
x = orb.x - cos(degtorad(orbit)) * orb.orbit_radius;
y = orb.y + sin(degtorad(orbit)) * orb.orbit_radius;
// set clockwise or counter-clockwise orbit depending on collision angle
orbit_speed = sign(angle_difference(orbit, direction)) * orbit_speed_set;
if (orbit_speed == 0) {
    orbit_speed = choose(orbit_speed_set, -orbit_speed_set);
}

// start orbiting
speed = 0;
orbiting = true;
latch_time = get_timer();

//if tethered, release that anchor
if (tethered) { current_orb.halt = false; }
tethered = false;

current_orb = orb;
nearest_orb = orb.id;
current_orb.halt = true;

// reset ricochet streak
ricochet_streak = -1;
                        
// Play capture sound
var s_engine = audio_play_sound(snd_capture, 0, 0);

// Modify the capture sound to reflect the value of capture_streak
if (capture_streak > -1 and orb.type != MASTER_ORB){
    if (capture_streak < 8) {
        audio_sound_pitch(s_engine, scale_capture[capture_streak]);
    }
    else {
        // If capture_streak is > 8, return to the bottom of the scale
        audio_sound_pitch(s_engine, scale_capture[capture_streak % 8]);
    }
}
