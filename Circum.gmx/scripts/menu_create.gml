/// Menu
window_set_cursor(cr_none); 
menu_reveal_radius = 0;
game_exit = false;

// init global vars
// TODO: levels and color selection should be loaded from file
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

menu_start = 734;
menu_spacing = 128; 
num_menu_item = MENU_EXIT+1;
current_item = MENU_PLAY;

// colors
color[0] = c_lime;
color_text[0] = "LIME";
color[1] = c_fuchsia;
color_text[1] = "FUCHSIA";
color[2] = c_aqua;
color_text[2] = "AQUA";
color[3] = c_yellow;
color_text[3] = "GOLD";

//rotate to align with user's color
while(color[0] != global.player_color) {
    var c = color[0];
    var c_text = color_text[0];
    
    color[0] = color[3];
    color_text[0] = color_text[3];
    color[3] = color[2];
    color_text[3] = color_text[2];
    color[2] = color[1];
    color_text[2] = color_text[1];
    
    color[1] = c;
    color_text[1] = c_text;
}
global.color_index = 0;

// text
title_font = quicksand_book_title;
menu_font = quicksand_bold_main;

menu_items[MENU_PLAY, 0] = "PLAY";

menu_items[SUBMENU_LEVEL, 0] = "LEVEL : " + string(global.current_level);
menu_items[SUBMENU_RANDOM, 0] = "RANDOM";

menu_items[MENU_OPTIONS, 0] = "OPTIONS";
menu_items[SUBMENU_COLOR, 0] = "COLOR : " + color_text[global.color_index];
menu_items[SUBMENU_ARROW, 0] = "ARROW";

menu_items[MENU_CREDITS,0] = "CREDITS";
menu_items[SUBMENU_NAMES,0] = "Panagis Alisandratos, Albert Cheu,#Rob Chiarelli, Shunman Tse";

menu_items[MENU_EXIT, 0] = "EXIT";

//which submenu, if any is open
submenu_state = CLOSED_SUBMENU;

//PLAY / [LEVEL] / [RANDOM] / OPTIONS / [COLOR] / [ARROW] / CREDITS / [NAMES] / EXIT

//variables for smooth contraction/expansion
text_y_offset = build_array(0,1,2,1,2,3,2,3,5);
options_y = menu_start+1*menu_spacing;
credits_y = menu_start+2*menu_spacing;
exit_y = menu_start+3*menu_spacing;

//transition function(s) for menu item selection
//each row of the grid describes which item is current_item after pressing up/down
transition = ds_grid_create(2,num_menu_item);
fill_grid_row(transition, DOWN_ARROW, MENU_OPTIONS, SUBMENU_RANDOM, MENU_OPTIONS,
                                        MENU_CREDITS, SUBMENU_ARROW, MENU_CREDITS,
                                        MENU_EXIT, MENU_EXIT, MENU_PLAY);
fill_grid_row(transition, UP_ARROW, MENU_EXIT, MENU_PLAY, SUBMENU_LEVEL,
                                    MENU_PLAY, MENU_OPTIONS, SUBMENU_COLOR,
                                    MENU_OPTIONS,MENU_CREDITS,MENU_CREDITS);

// scales for the menu text
for(var i = 0; i < num_menu_item; i++){
    menu_items[i, 1] = 0;
    if (i == MENU_PLAY || i == MENU_OPTIONS
        || i == MENU_CREDITS || i == MENU_EXIT) {
        menu_items[i, 1] = 1;
    }
}

//sideways motion (level & color)
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
