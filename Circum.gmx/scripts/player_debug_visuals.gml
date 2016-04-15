/// player_debug_visuals()

draw_set_colour(color);
var debug_text = ("Captured: " + string(num_orb_captured) + "#");
debug_text += ("Ricochet: " + string(ricochet_streak) + "#");
debug_text += ("Capture: " + string(capture_streak) + "#");
draw_text_transformed(x, y + 20, debug_text, 2, 2, 0);

// directional guideline
draw_set_alpha(0.3);
draw_line_width(x, y, x + lengthdir_x(room_width, direction), y + lengthdir_y(room_width, direction), 5);
draw_set_alpha(1);

