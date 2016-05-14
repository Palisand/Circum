/// Menu
draw_set_alpha(1);
draw_set_colour(c_white);
draw_set_halign(fa_center);

draw_set_font(title_font);
draw_text(room_width/2, 512, "CIRCUM");

draw_set_font(menu_font);
draw_set_valign(fa_center);

for (var i = 0; i < num_menu_item; i++) {
    draw_set_alpha(1);
    
    var text_x = room_width/2;
    
    if (submenu_state == OPEN_PLAY) {
        option_yval = lerp(option_yval,option_yval_play,MENU_VERT_SPD);
        exit_yval = option_yval + 2*menu_spacing;
    }
    else {
        option_yval = lerp(option_yval,option_yval_default,MENU_VERT_SPD);
        if (submenu_state == OPEN_OPTIONS) { exit_yval = lerp(exit_yval,exit_yval_options,MENU_VERT_SPD); }
        else { exit_yval = lerp(exit_yval,exit_yval_default,MENU_VERT_SPD); }
    }
    
    var text_y = menu_start + (menu_spacing * i * 2);
    if (i == MENU_EXIT) { text_y = exit_yval; }
    else if (i >= MENU_OPTIONS) { text_y = option_yval + (i - MENU_OPTIONS)*2*menu_spacing; }
    
    //not the current selection
    if (current_item != i) {
        draw_set_colour(c_white);
        var color_to = 0;
        var level_to = 0;
        var random_to = 0;
        var arrow_to = 0;
        
        switch(submenu_state){
        case CLOSED_SUBMENU:
            break;
        case OPEN_PLAY:
            level_to = 1;
            random_to = 1;
            if (i == MENU_PLAY || i == MENU_OPTIONS || i == MENU_EXIT) {
                draw_set_alpha(0.1);
            }
            break;
        case OPEN_OPTIONS:
            color_to = 1;
            arrow_to = 1;
            if (i == MENU_PLAY || i == MENU_OPTIONS || i == MENU_EXIT) {
                draw_set_alpha(0.1);
            }
            break;
        }
        menu_items[SUBMENU_LEVEL, 1] = lerp(menu_items[SUBMENU_LEVEL, 1], level_to, MENU_HOR_SPD);
        menu_items[SUBMENU_RANDOM, 1] = lerp(menu_items[SUBMENU_RANDOM, 1], random_to, MENU_HOR_SPD);
        menu_items[SUBMENU_COLOR, 1] = lerp(menu_items[SUBMENU_COLOR, 1], color_to, MENU_HOR_SPD);
        menu_items[SUBMENU_ARROW, 1] = lerp(menu_items[SUBMENU_ARROW, 1], arrow_to, MENU_HOR_SPD);
        
        if (menu_items[i, 1] > 1) {
            menu_items[i, 1] -= 0.05;
        }
        
        draw_text_transformed(text_x, text_y, menu_items[i, 0], menu_items[i, 1], menu_items[i, 1], 0);
        continue;
    }
    
    //the current selection
    if (menu_items[i, 1] < 1.5) {
        menu_items[i, 1] += 0.1;
    }
    
    var scale = menu_items[i, 1];
    draw_set_colour(global.player_color);
    
    if (current_item == SUBMENU_LEVEL) {  // level select
        for(var j = 0; j < 4; j++) {
            
            draw_set_alpha(1);
            draw_set_color(global.player_color);
                
            var k = (side_index_level+j)%4;
            
            if (press_dir != CENTER){
                side_scale_level[j] = lerp(side_scale_level[j],
                                                side_scale_standard[k], MENU_HOR_SPD);
                side_pos_level[j] = lerp(side_pos_level[j],
                                                side_pos_standard[k], MENU_HOR_SPD);
            }
            
            var level_val = global.current_level;
            if (k == 1) { level_val = global.current_level-1; }
            if (k == 3) { level_val = global.current_level+1; }
            if (k == 2) { level_val = global.current_level+2; }
            
            var disp = string(level_val);
            if (level_val < 0) { disp = ""; }
            else if (level_val > global.max_level) { disp = ""; level_val = global.max_level; }
            
            if (level_val > global.max_level_unlocked) {
                draw_set_alpha(0.5);
                draw_set_color(c_white);
            }
            
            draw_text_transformed(side_pos_level[j], text_y, disp,
                                side_scale_level[j]*scale, side_scale_level[j]*scale, 0);
        }
    }
    
    else if (current_item == SUBMENU_COLOR) {  // color select
    
        for(var j = 0; j < 4; j++) {
            draw_set_alpha(0.5);
            draw_set_color(c_white);
            
            var k = (side_index_color+j)%4;
            
            if (press_dir != CENTER){
                side_scale_color[j] = lerp(side_scale_color[j], side_scale_standard[k], MENU_HOR_SPD);
                side_pos_color[j] = lerp(side_pos_color[j], side_pos_standard[k], MENU_HOR_SPD);
            }
            
            if (j == global.color_index) {
                draw_set_alpha(1);
                draw_set_color(color[j]);
            }
            
            draw_text_transformed(side_pos_color[j], text_y, color_text[j],
                                side_scale_color[j]*scale, side_scale_color[j]*scale, 0);
        }
    }
    
    else {
        draw_text_transformed(text_x, text_y, menu_items[i, 0], scale, scale, 0);
    }
    
}

draw_set_alpha(1);
