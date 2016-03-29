/// orb_update(orb_obj)

var orb_obj = argument0;

// bounce off the screen's edge
var col_edge_coords = edge_bounce_circle(orbit_radius);

// bounce off other orbs
with (orb_obj) {
    if (self.id != other.id) { orb_hit_orb(other); }
}

// Fade alpha depending on captured status
if (captured) {
    fill_alpha = lerp(fill_alpha, 1, fill_alpha_rate);
}
else {
    fill_alpha = lerp(fill_alpha, 0, fill_alpha_rate);
}

// collision-dependent
if (col_orb || col_edge || col_player) {
    orbit_radius_alpha = orbit_radius_alpha_max;  // reveal orbit radius on collision
}
else {
    orbit_radius_alpha = lerp(orbit_radius_alpha, 0, orbit_radius_alpha_rate);  // fade out otherwise
}

if (col_orb) {
    col_orb = false;
    if (type != DEAD_ORB) {
        collision_hit_burst(col_orb_coords[0], col_orb_coords[1], 0, 360, color, 100, 20, p_emitter, p_type);
    }
}

if (col_edge) {
    col_edge = false;
    if (type != DEAD_ORB) {
        collision_hit_burst(col_edge_coords[0], col_edge_coords[1], 0, 360, color, 300, 60, p_emitter, p_type);
    }
}

if (col_player) {
    col_player = false;
    // TODO: change this to be the void swallow effect
    /*
    if (!captured) {
        var dir = point_direction(capturer.x, capturer.y, x, y);
        part_system_depth(global.p_system, -99);
        part_type_shape(p_type, pt_shape_flare);
        part_type_blend(p_type, true);
        part_type_alpha2(p_type, 1, 0);
        part_type_colour1(p_type, color);
        part_type_direction(p_type, dir - 10, dir + 10, 0, 0);
        part_type_speed(p_type, 0, 4, 0, 0);
        part_type_size(p_type, 0.2, 0.2, 0, 0);
        part_type_life(p_type, 1, 30);
        part_type_orientation(p_type, 0, 0, 0, 0, true);
        part_type_scale(p_type, 1, 1);
        part_emitter_region(global.p_system, p_emitter, capturer.x, capturer.x, capturer.y, capturer.y, ps_shape_line, ps_distr_linear);
        part_emitter_burst(global.p_system, p_emitter, p_type, 100);
    }*/
    // TODO: shockwave
}

// Guarded
if (guarded) {
    if (guard_impact_alpha > 0) {
        guard_impact_alpha -= 0.1;
    }
}
else {
    guard_impact_alpha = 1;
}
