/// player_visuals()

draw_set_circle_precision(64);
draw_set_colour(color);

// draw player and trail
draw_fixed_trail(trail_length, draw_radius * 2, color, -1, true, 1);
draw_circle(x, y, draw_radius, false);

// draw tether
if (!enter_the_void && nearest_orb != -1) {
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
