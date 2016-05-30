///get_target_y(state0,offset0, state1,offset1, text_y)

var state0 = argument0;
var offset0 = argument1;

var state1 = argument2;
var offset1 = argument3;

var text_y = argument4;

if (submenu_state == state0 || submenu_state == state1) {
    var offset = offset0;
    if (submenu_state == state1) { offset = offset1; }
    
    var alt_pos = menu_start + offset*menu_spacing;
    return alt_pos;
}

return text_y;
