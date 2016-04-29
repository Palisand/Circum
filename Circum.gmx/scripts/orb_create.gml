/// orb_create()

capturer = -1;
captured = false;

// fixed
fixed = false;
fixed_orbit = 0;
fixed_orbit_speed = 0;
fixed_orbit_radius = 0;
fixed_origin_dist = 0;
fixed_origin_dir = 0;
fixed_origin_speed = 0;

// for capture streaks
guarder = -1;
guarded = false;

orbit_radius = 50;
radius = orbit_radius / 2;

direction = random(360);
initial_speed = random_range(3, 5);
speed = initial_speed;
halt = false;

// collision
col_orb = false;
col_edge = false;
col_player = false;
col_orb_coords[0] = 0; // x
col_orb_coords[1] = 0; // y

// draw & fx
color = c_white;
fill_alpha = 0;
fill_alpha_rate = 0.04;
orbit_radius_alpha = 0;
orbit_radius_alpha_max = 0.5;
orbit_radius_alpha_min = 0;
orbit_radius_alpha_rate = 0.1;
guard_impact_alpha = 0;
draw_scale = radius * 2/sprite_get_width(s_ring);

p_emitter = part_emitter_create(global.p_system);
p_type = part_type_create();
p_type_alt = part_type_create();
