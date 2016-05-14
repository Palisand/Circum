window_set_cursor(cr_none); 
menu_reveal_radius = 0;
game_exit = false;

// init global vars
if (!instance_exists(o_globals)) {
    instance_create(0, 0, o_globals);
}

if (global.current_level == RANDOM_LEVEL) {
    global.current_level = global.max_level_unlocked; 
}

// Particles
p_emitter = part_emitter_create(global.p_system);
p_type = part_type_create();

// Screen (Circular)
screen = surface_create(room_width, room_height);
drawn_to_surface = false;

/// Menu
// TODO: levels and color selection should be loaded from file
menu_start = 734;
menu_spacing = 64; 
num_menu_item = MENU_EXIT+1;
current_item = 0;

option_yval_default = menu_start + 2*menu_spacing;
option_yval_play = menu_start + MENU_OPTIONS*2*menu_spacing;
option_yval = option_yval_default;

exit_yval_default = option_yval + 2*menu_spacing;
exit_yval_options = option_yval + (MENU_EXIT-MENU_OPTIONS)*2*menu_spacing;
exit_yval = exit_yval_default;

// colors
color[0] = c_lime;
color_text[0] = "LIME";
color[1] = c_fuchsia;
color_text[1] = "FUCHSIA";
color[2] = c_aqua;
color_text[2] = "AQUA";
color[3] = c_yellow;
color_text[3] = "GOLD";

// text
menu_items[MENU_PLAY, 0] = "PLAY";
menu_items[SUBMENU_LEVEL, 0] = "LEVEL : " + string(global.current_level);
menu_items[SUBMENU_RANDOM, 0] = "RANDOM";
menu_items[MENU_OPTIONS, 0] = "OPTIONS";
menu_items[SUBMENU_COLOR, 0] = "COLOR : " + color_text[global.color_index];
menu_items[SUBMENU_ARROW, 0] = "ARROW";
menu_items[MENU_EXIT, 0] = "EXIT";

//which submenu, if any is open
submenu_state = CLOSED_SUBMENU;

//transition functions!
closed_submenu_transition = ds_grid_create(2,num_menu_item);
fill_grid_row(closed_submenu_transition, DOWN_ARROW, MENU_OPTIONS,-1,-1,MENU_EXIT,-1,-1,MENU_PLAY);
fill_grid_row(closed_submenu_transition, UP_ARROW, MENU_EXIT,-1,-1,MENU_PLAY,-1,-1,MENU_OPTIONS);

open_play_transition = ds_grid_create(2,num_menu_item);
fill_grid_row(open_play_transition, DOWN_ARROW, SUBMENU_LEVEL,SUBMENU_RANDOM,MENU_OPTIONS,MENU_EXIT,-1,-1,MENU_PLAY);
fill_grid_row(open_play_transition, UP_ARROW, MENU_EXIT,MENU_PLAY,SUBMENU_LEVEL,SUBMENU_RANDOM,-1,-1,MENU_OPTIONS);

open_options_transition = ds_grid_create(2,num_menu_item);
fill_grid_row(open_options_transition, DOWN_ARROW, MENU_OPTIONS,-1,-1,SUBMENU_COLOR,SUBMENU_ARROW,MENU_EXIT,MENU_PLAY);
fill_grid_row(open_options_transition, UP_ARROW, MENU_EXIT,-1,-1,MENU_PLAY,MENU_OPTIONS,SUBMENU_COLOR,SUBMENU_ARROW);

// scales
for(var i = 0; i < num_menu_item; i++){
    menu_items[i, 1] = 0;
    if (i == MENU_PLAY || i == MENU_OPTIONS || i == MENU_EXIT) {
        menu_items[i, 1] = 1;
    }
}

//sideways motion
press_dir = CENTER;
//constant
side_scale_standard = build_array(1,0.5,0,0.5);
side_pos_standard = build_array(CENTER,LEFT,CENTER,RIGHT);

//which constant should the 0th item lerp to
side_index_level = 0;
//ith item = current scale/position of ith level
side_scale_level = build_array(1,0.5,0,0.5);
side_pos_level = build_array(CENTER,LEFT,CENTER,RIGHT);

//which constant should the 0th item lerp to
side_index_color = 0;
//ith item = current scale/position of ith color
side_scale_color = build_array(1,0.5,0,0.5);
side_pos_color = build_array(CENTER,LEFT,CENTER,RIGHT);

title_font = quicksand_book_title;
menu_font = quicksand_bold_main;
