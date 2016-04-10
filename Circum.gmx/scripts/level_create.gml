/// Places orbs & player, and initializes variables
//called by handler

// Spawn Orbs
if (tut_count < 0) { spawn_orbs_level(); }
else { spawn_tutorial_orbs(); }

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
plr_color = choose(c_fuchsia, c_aqua, c_lime, c_yellow);
with (instance_create(SCREEN_RADIUS, SCREEN_RADIUS, o_player)) {
    color = other.plr_color;
    action_key = vk_space;
    num_to_win =  other.num_to_win; 
}
// set captured orbs' colors based on player color
with (o_orb) {
    if (captured) {
        do {
            color = choose(c_fuchsia, c_aqua, c_lime, c_yellow);
        } until (color != other.plr_color);
    }
}

// Spawn Hidden Opponent
instance_create(0, 0, o_fake_player);
