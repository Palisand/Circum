/// Menu Interact

// Update Level Shown
menu_items[SUBMENU_LEVEL, 0] = "LEVEL : " + string(global.current_level);
menu_items[SUBMENU_COLOR, 0] = "COLOR : " + color_text[global.color_index];
//update arrow status
var guide_arrow_on;
if (global.draw_guide_arrow) { guide_arrow_on = "YES"; }
else { guide_arrow_on = "NO"; }
menu_items[SUBMENU_ARROW, 0] = "Guide Arrow On : " + guide_arrow_on;

// Item Select
if (keyboard_check_pressed(vk_down)) {
    audio_play_sound(snd_menu_nav, 0, 0);
    current_item = ds_grid_get(transition, DOWN_ARROW,current_item);    
    switch(submenu_state){
    case CLOSED_SUBMENU:
        break;
    case OPEN_PLAY:
        if (current_item == MENU_OPTIONS) { submenu_state = CLOSED_SUBMENU; }
        break;
    case OPEN_OPTIONS:
        if (current_item == MENU_CREDITS) { submenu_state = CLOSED_SUBMENU; }
        break;
    case OPEN_CREDITS:
        if (current_item == MENU_EXIT) { submenu_state = CLOSED_SUBMENU; }
        break;
    }
    
}

if (keyboard_check_pressed(vk_up)) {
    audio_play_sound(snd_menu_nav, 0, 0);
    current_item = ds_grid_get(transition, UP_ARROW,current_item);
    switch(submenu_state){
    case CLOSED_SUBMENU:
        break;
    case OPEN_PLAY:
        if (current_item == MENU_PLAY) { submenu_state = CLOSED_SUBMENU; }
        break;
    case OPEN_OPTIONS:
        if (current_item == MENU_OPTIONS) { submenu_state = CLOSED_SUBMENU; }
        break;
    case OPEN_CREDITS:
        if (current_item == MENU_CREDITS) { submenu_state = CLOSED_SUBMENU; }
        break;
    }
}

//change submenu state or go to different room
if (keyboard_check_pressed(vk_space)) {
    audio_play_sound(snd_menu_nav, 0, 0);
    switch(current_item) {
        case MENU_PLAY:
            submenu_state = OPEN_PLAY;
            current_item = SUBMENU_LEVEL;
            break;
        
        case SUBMENU_LEVEL:
            room_goto(rm_play);
            break;
            
        case SUBMENU_RANDOM:
            global.current_level = RANDOM_LEVEL;
            room_goto(rm_play);
            break;
            
        case MENU_OPTIONS:
            submenu_state = OPEN_OPTIONS;
            current_item = SUBMENU_COLOR;
            break;
        case MENU_CREDITS:
            submenu_state = OPEN_CREDITS;
            current_item = SUBMENU_NAMES;
            break;
        
        case MENU_EXIT:
            menu_reveal_radius = room_width/2;
            game_exit = true;
            
        default:
            break;
    }
}

// Level Select
if (current_item == SUBMENU_LEVEL) {
    if (keyboard_check_pressed(vk_right)
        && global.current_level < global.max_level_unlocked
        ) {
        audio_play_sound(snd_menu_nav, 0, 0);
        global.current_level++;
        side_index_level = (side_index_level + 1) % 4;
        press_dir = RIGHT;
        menu_items[SUBMENU_LEVEL, 0] = "LEVEL : " + string(global.current_level);
    }
    else if (keyboard_check_pressed(vk_left) && global.current_level > 0) {
        audio_play_sound(snd_menu_nav, 0, 0);
        global.current_level--;
        side_index_level = (side_index_level + 3) % 4;
        press_dir = LEFT;
        menu_items[SUBMENU_LEVEL, 0] = "LEVEL : " + string(global.current_level);
    }
}

// Color Select
if (current_item == SUBMENU_COLOR) {
    if (keyboard_check_pressed(vk_right)) {
        audio_play_sound(snd_menu_nav, 0, 0);
        global.color_index = (global.color_index + 3) % 4;
        side_index_color = (side_index_color + 1) % 4;
        press_dir = RIGHT;
        global.player_color = color[global.color_index];
    }
    else if (keyboard_check_pressed(vk_left)) {
        audio_play_sound(snd_menu_nav, 0, 0);
        global.color_index = (global.color_index + 1) % 4;
        side_index_color = (side_index_color + 3) % 4;
        press_dir = LEFT;
        global.player_color = color[global.color_index];
    }
}

// Guide Arrow Toggle
if (current_item == SUBMENU_ARROW) {
    if (keyboard_check_pressed(vk_right) || keyboard_check_pressed(vk_left) || keyboard_check_pressed(vk_space)) {
        audio_play_sound(snd_menu_nav, 0, 0);
        global.draw_guide_arrow = !global.draw_guide_arrow;
    }
}
