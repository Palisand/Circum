/// orb_visuals()

// Orb
draw_sprite_ext(s_ring, 0, x, y, draw_scale, draw_scale, 0, c_white, 1 - fill_alpha);
draw_sprite_ext(s_ring, 0, x, y, draw_scale, draw_scale, 0, color, fill_alpha); 

// Orbit
if (instance_exists(o_player) && id = o_player.current_orb && o_player.orbiting) {
    orbit_radius_alpha_min = 0.15;
}
else {
    orbit_radius_alpha_min = 0;
}
draw_set_alpha(orbit_radius_alpha);
draw_set_blend_mode(bm_add);
draw_circle_colour(x, y, orbit_radius, c_black, color, false);
draw_set_blend_mode(bm_normal);
draw_set_alpha(1);

// Fade fill_alpha depending on captured status
if (captured) {
    fill_alpha = lerp(fill_alpha, 1, fill_alpha_rate);
}
else {
    fill_alpha = lerp(fill_alpha, 0, fill_alpha_rate);
}
