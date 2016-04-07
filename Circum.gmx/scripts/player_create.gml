/// player_create()

// Set in o_handler Create Event
color = c_white;
action_key = vk_shift;

trail_length = 30;
draw_radius = 5;
radius = 5;

launch_speed = 20;
direction = choose(1, -1); // randomly begin with a clockwise or counter-clockwise rotation
orbit = 0;
orbit_speed = 0;
orbit_speed_set = 4;
orbiting = false;
tethered = false;
tether_radius = 0;

single = true;
num_orb_captured = 0;
num_to_win = -1;
current_orb = -1;
nearest_orb = -1;
dist_to_nearest = room_width * 2;  // pseudo MAX_INT

// Capture Streak
capture_streak = -1;  // offset by one because we will capture the initial orb
possession_streak_used = false;

// Collision
col_edge = false;
col_orb_set = false;
enter_the_void = false;

// Ricochet Streak Variables
ricochet_streak = -1;  // Counter for the current ricochet streak
ricochet_reward = 0;  // Records the ricochet reward (for the current version either 3 or 6)

// Sound
scale[0] = 2/3;
scale[1] = 3/4;
scale[2] = 5/6;
scale[3] = 8/9;
scale[4] = 1/1;
scale[5] = 9/8;
scale[6] = 5/4;
scale[7] = 4/3;
scale_capture[0] = 4/3;
scale_capture[1] = 3/2;
scale_capture[2] = 5/3;
scale_capture[3] = 7/4;
scale_capture[4] = 2/1;
scale_capture[5] = 17/8;
scale_capture[6] = 9/4;
scale_capture[7] = 7/3;
