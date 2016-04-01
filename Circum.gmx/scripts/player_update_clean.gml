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
        ricochet_streak = 0;
    }
    
    // Ricochet Streak Update
    // Increment the Ricochet Streak counter if the streak has already started
    if (ricochet_streak > 0) {
        play_ricochet(++ricochet_streak, scale);
    }
}

// Ricochet Streak Update
// Check if our streak is high enough for a streak reward / power-up
/*
if (ricochet_streak == RELEASE) {
    ricochet_reward = RELEASE;
}
else if (ricochet_streak == THEFT) {
    ricochet_reward = THEFT;
}
*/

// reset orb collision set flag (otherwise landing on a free or owned orb won't result in a radius reveal)
col_orb_set = false;

//if we are tethered to an orb
if (tethered) { player_tethered(); }

//if we are orbiting an orb
if (orbiting) { player_orbit(player_obj, orb_obj); }

//we've launched or tethered
else {
    speed = launch_speed;

    //we've launched
    if (! tethered) { player_launched(orb_obj); }
    
    // in either launched or tethered state, check against all orbs
    for (var i = 0; i < instance_number(orb_obj); i++) {
        var orb = instance_find(orb_obj, i);
        player_hit_orb(orb, orb_obj);
    }
}
