/// player_update(player_obj, orb_obj);

var player_obj = argument0;
var orb_obj = argument1;

// screen edge collision
edge_bounce_circle(radius);

if (col_edge) {
    col_edge = false;
    
    // Remove capture streak
    capture_streak = 0;
    
    if (tethered) {
        orbit_speed = -orbit_speed;  // reverse orbit speed
        ricochet_streak = -1;
        ricochet_time = 0;
    }
    
    // Increment the ricochet streak and play the ricochet sound
    play_ricochet(++ricochet_streak, scale);
}

// reset orb collision set flag (otherwise landing on a free or owned orb won't result in a radius reveal)
col_orb_set = false;

// if collided with void orb
if (enter_the_void) {
    move_towards_point(current_orb.x, current_orb.y, 10);
    trail_length--;
    if (trail_length < 0) {
        instance_destroy();
        audio_play_sound(snd_game_over, 0, 0);
    }
}
else {
    //if we are tethered to an orb
    if (tethered) { 
        just_released = false;
        player_tethered(); 
        //audio_resume_sound(snd_tether);
        audio_sound_gain(snd_tether, tether_volume(player_obj, current_orb), 0);
        if (!audio_is_playing(snd_tether)) {
            audio_play_sound(snd_tether, 0, 0);
        }
    }
    else { /*audio_pause_sound(snd_tether)*/ audio_stop_sound(snd_tether); }
    
    //if we are orbiting an orb
    if (orbiting) { player_orbiting(player_obj, orb_obj); }
    
    //we've launched or tethered
    else {
        speed = launch_speed;
    
        //we've launched
        if (! tethered) { 
            player_launched(orb_obj);
            if (! just_released) {
                audio_play_sound(snd_tether_fade, 2, 0);
            }
            just_released = true;
        }
        
        // in either launched or tethered state, check against all orbs
        for (var i = 0; i < instance_number(orb_obj); i++) {
            var orb = instance_find(orb_obj, i);
            player_hit_orb(orb, orb_obj);
        }
    }
}
