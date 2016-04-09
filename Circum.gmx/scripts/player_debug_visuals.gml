/// player_debug_visuals()

draw_set_colour(color);
var debug_text = ("Captured: " + string(num_orb_captured) + "#");
debug_text += ("Ricochet: " + string(ricochet_streak) + "#");
debug_text += ("Capture: " + string(capture_streak) + "#");
draw_text_transformed(x, y + 20, debug_text, 2, 2, 0);
/*
if (ricochet_reward == THEFT) {
    draw_text_transformed(x, y - 40, "THEFT", 2, 2, 0);
}

if (ricochet_reward == RELEASE) {
    draw_text_transformed(x, y - 40, "RELEASE", 2, 2, 0);
}
*/
