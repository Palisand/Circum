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
    
    //six of the nine menu items are at fixed offsets
    var text_y = menu_start + text_y_offset[i]*menu_spacing;
    //the remaining three change depending on state
    switch(i){
    case MENU_OPTIONS:
        options_y = lerp(options_y,get_target_y(OPEN_PLAY,3,OPEN_PLAY,3,text_y),MENU_VERT_SPD);
        text_y = options_y;
        break;
    case MENU_CREDITS:
        credits_y = lerp(credits_y,get_target_y(OPEN_PLAY,4,OPEN_OPTIONS,4,text_y),MENU_VERT_SPD);
        text_y = credits_y;
        break;
    case MENU_EXIT:
        exit_y = lerp(exit_y,get_target_y(OPEN_CREDITS,4,CLOSED_SUBMENU,3,text_y),MENU_VERT_SPD);
        text_y = exit_y;
        break;
    }
    
    //not the current selection
    if (current_item != i) {
        draw_set_colour(c_white);
        var color_to = 0;
        var level_to = 0;
        var random_to = 0;
        var arrow_to = 0;
        var names_to = 0;
        
        switch(submenu_state){
        case CLOSED_SUBMENU:
            break;
        case OPEN_PLAY:
            draw_set_alpha(0.1);
            level_to = 1;
            random_to = 1;
            if (i == SUBMENU_LEVEL || i == SUBMENU_RANDOM) {
                draw_set_alpha(1);
            }
            break;
        case OPEN_OPTIONS:
            draw_set_alpha(0.1);
            color_to = 1;
            arrow_to = 1;
            if (i == SUBMENU_COLOR || i == SUBMENU_ARROW) {
                draw_set_alpha(1);
            }
            break;
        case OPEN_CREDITS:
            draw_set_alpha(0.1);
            names_to = 1;
            break;
        }
        menu_items[SUBMENU_LEVEL, 1] = lerp(menu_items[SUBMENU_LEVEL, 1], level_to, MENU_HOR_SPD);
        menu_items[SUBMENU_RANDOM, 1] = lerp(menu_items[SUBMENU_RANDOM, 1], random_to, MENU_HOR_SPD);
        menu_items[SUBMENU_COLOR, 1] = lerp(menu_items[SUBMENU_COLOR, 1], color_to, MENU_HOR_SPD);
        menu_items[SUBMENU_ARROW, 1] = lerp(menu_items[SUBMENU_ARROW, 1], arrow_to, MENU_HOR_SPD);
        menu_items[SUBMENU_NAMES, 1] = lerp(menu_items[SUBMENU_NAMES, 1], names_to, MENU_HOR_SPD);
        
        //unselected items can be no more than 100% size
        if (menu_items[i,1] > 1) { menu_items[i,1] -= 0.05; }
        
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
