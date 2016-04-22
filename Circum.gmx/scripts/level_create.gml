/// level_create(restart)


// TODO: instead of 'restart' the level number is needed


//Places orbs & player, and initializes variables
/// level_create(bool restart_level)

//called by handler

var restart_level = argument0; // TODO: no need to save orbs since levels are the same

level_text_alpha = 0;
level_text = "";

// Spawn Orbs
//spawn_orbs_level();
spawn_test_orbs();

// Spawn Starting Orb
var start_orb = instance_create(SCREEN_RADIUS, SCREEN_RADIUS, o_orb);
start_orb.speed = 0;  // not necessary if fixed = true, but let's keep it anyway
start_orb.fixed = true;

// Get number of orbs required to win (now that all orbs have been spawned)
num_to_win = 0;
with (o_orb) {
    if (type == DEFAULT_ORB) { other.num_to_win++; }
}
if (room_get_name(room) == "rm_tutorial" && (tut_count == 1 || tut_count == 2)) {
    num_to_win++;  // orb spawns during play
}

// Spawn Player
has_launched = false;
var player;
if (room_get_name(room) == "rm_tutorial" && tut_count == 0) {
    player = instance_create(room_width/2, room_height - 10, o_player);
    player.direction = 90;
}
else {
    player = instance_create(SCREEN_RADIUS, SCREEN_RADIUS, o_player)
}
player.color = global.player_color;
player.action_key = vk_space;
player.num_to_win = num_to_win; 

