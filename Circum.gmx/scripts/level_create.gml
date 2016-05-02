/// level_create()

level_text_alpha = 0;
level_text = "";

// Spawn Orbs
//By default, our starting orb is small but that can change
start_orb_size = RAD_SMALL;

spawn_orbs_level();
//spawn_test_orbs();

// Spawn Starting Orb
var start_orb = instance_create(SCREEN_RADIUS, SCREEN_RADIUS, o_orb);
start_orb.speed = 0;
start_orb.fixed = true;
start_orb.orbit_radius = start_orb_size;
start_orb.radius = start_orb.orbit_radius / 2;
start_orb.draw_scale = start_orb.radius * 2/sprite_get_width(s_ring);

// Get number of orbs required to win (now that all orbs have been spawned)
num_to_win = 0;
with (o_orb) {
    other.num_to_win++;
}

// Spawn Player
has_launched = false;

with (instance_create(SCREEN_RADIUS, SCREEN_RADIUS, o_player)) {
    color = global.player_color;
    action_key = vk_space;
    num_to_win = other.num_to_win;
}
