/// player_visuals()

draw_set_circle_precision(64);
draw_set_colour(color);
draw_trail(trail_length, radius * 2, color, -1, true, 1);
draw_circle(x, y, draw_radius, false);

if (!enter_the_void && nearest_orb != -1 && (!nearest_orb.guarded || nearest_orb.guarder == id)) {
    var alpha = 0.3;
    if (tethered) {
        alpha = 1;
    }
    var dir = point_direction(x, y, nearest_orb.x, nearest_orb.y);
    draw_set_alpha(alpha);
    draw_line_width_colour(
        x, y,
        nearest_orb.x - lengthdir_x(nearest_orb.radius, dir),
        nearest_orb.y - lengthdir_y(nearest_orb.radius, dir),
        3, color, nearest_orb.color
    );
    draw_set_alpha(1);
}

/*
draw_set_halign(fa_center);
if (ricochet_reward == THEFT) {
    draw_text_transformed(x, y - 40, "THEFT", 2, 2, 0);
}
if (ricochet_reward == RELEASE) {
    draw_text_transformed(x, y - 40, "RELEASE", 2, 2, 0);
}
*/
