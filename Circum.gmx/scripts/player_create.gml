/// player_create()

p_emitter = part_emitter_create(global.p_system);
p_type = part_type_create();

// Set in o_handler Create Event
color = c_white;
action_key = vk_shift;

radius = 3;
draw_radius = radius;

launch_speed = 15;
homing_speed = 1.5;
orb_pull_speed = 0;
tether_cap = 1.3;
direction = choose(1, -1); // randomly begin with a clockwise or counter-clockwise rotation
orbit = 0;
orbit_speed = 0;
orbit_speed_set = 4;
holding_button = false;
//flags for state
orbiting = false;
tethered = false;
just_released = false;

single = true;
num_orb_captured = 0;
num_to_win = -1;
current_orb = -1;
nearest_orb = -1;
dist_to_nearest = room_width * 2;  // pseudo MAX_INT

// Trail
trail_length = 30;
trail_id[0] = -1;
trail_tethered[0] = -1;
ricochet_time = trail_length;  //steps since last ricochet
latch_time = -1;  //time at which we tethered/orbited

// Capture Streak
capture_streak = -1;  // offset by one because we will capture the initial orb

// Collision
col_edge = false;
col_orb_set = false;
enter_the_void = false;

// Ricochet Streak Variables
ricochet_streak = -1;  // Counter for the current ricochet streak

// Sound
scale[0] = 2/3;
scale[1] = 3/4;
scale[2] = 5/6;
scale[3] = 8/9;
scale[4] = 1/1;
scale[5] = 9/8;
scale[6] = 5/4;
scale[7] = 4/3;

scale_capture[0] = 2/3;
scale_capture[1] = 3/4;
scale_capture[2] = 5/6;
scale_capture[3] = 8/9;
scale_capture[4] = 1/1;
scale_capture[5] = 9/8;
scale_capture[6] = 5/4;
scale_capture[7] = 4/3;
