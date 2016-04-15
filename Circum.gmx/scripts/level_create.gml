/// level_create(restart)
//Places orbs & player, and initializes variables
/// level_create(bool restart_level)

//called by handler

var restart_level = argument0;

level_text_alpha = 0;
level_text = "";

// Spawn Orbs
if (restart_level) {
    spawn_orbs_saved();
}
else {
    if (tut_count < 0) {
        spawn_orbs_level();
    }
    else {
        spawn_tutorial_orbs();
    }
}
with (o_orb) {
    if (captured) {
        color = global.lock_color;
    }
}

// Spawn Starting Orb
var start_orb = instance_create(SCREEN_RADIUS, SCREEN_RADIUS, o_orb);
start_orb.speed = 0;  // not necessary if fixed = true, but let's keep it anyway
start_orb.fixed = true;

// Get number of orbs required to win (now that all orbs have been spawned)
num_to_win = 0;
with (o_orb) {
    if (type == DEFAULT_ORB) { other.num_to_win++; }
}

// Spawn Player
has_launched = false;
with (instance_create(SCREEN_RADIUS, SCREEN_RADIUS, o_player)) {
    color = global.player_color;
    action_key = vk_space;
    num_to_win =  other.num_to_win; 
}

