/// orb_visuals()

// Orb
switch(type) {
    case DEFAULT_ORB:
        draw_sprite_ext(s_ring, 0, x, y, draw_scale, draw_scale, 0, c_white, 1 - fill_alpha);
        draw_sprite_ext(s_ring, 0, x, y, draw_scale, draw_scale, 0, color, fill_alpha); 
        break;
    case DEAD_ORB:
        draw_sprite_ext(s_ring, 0, x, y, draw_scale, draw_scale, 0, color, 1);
        draw_set_colour(c_gray);
        draw_set_alpha(0.2);
        draw_circle(x, y, radius, false);
        draw_set_alpha(1);
        break;
    case VOID_ORB:
    case MASTER_ORB:
        draw_sprite_ext(s_ring, 0, x, y, draw_scale, draw_scale, 0, color, 1);
        break;
}

// Orbit
var orbit_radius_color;
if (guarded && guarder.id != -1) {
    orbit_radius_color = guarder.color;
    orbit_radius_alpha = orbit_radius_alpha_max / 2;
    draw_set_alpha(guard_impact_alpha);
    draw_circle(x, y, orbit_radius, false);
    draw_set_alpha(1);
}
else {
    orbit_radius_color = color;
}
draw_set_alpha(orbit_radius_alpha);
draw_set_blend_mode(bm_add);
draw_circle_colour(x, y, orbit_radius, c_black, orbit_radius_color, false);
draw_set_blend_mode(bm_normal);
draw_set_alpha(1);

// Fade guard_impact_alpha to 0
if (guarded) {
    if (guard_impact_alpha > 0) {
        guard_impact_alpha -= 0.1;
    }
}
else {
    guard_impact_alpha = 1;
}

// Fade fill_alpha depending on captured status
if (captured) {
    fill_alpha = lerp(fill_alpha, 1, fill_alpha_rate);
}
else {
    fill_alpha = lerp(fill_alpha, 0, fill_alpha_rate);
}
