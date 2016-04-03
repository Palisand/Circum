/// orb_update(orb_obj)

var orb_obj = argument0;

if (halt) {
    speed = lerp(speed, 0, 0.1);
}
else {
    speed = lerp(initial_speed,speed,0.1);
}

// bounce off the screen's edge
var col_edge_coords = edge_bounce_circle(orbit_radius);

// bounce off other orbs
for (var i = 0; i < instance_number(orb_obj); i++) {
    var orb = instance_find(orb_obj, i);
    if (self.id != orb.id) {
        orb_hit_orb(orb);
    }
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

// Void Effect
if (type == VOID_ORB) {
    part_system_depth(global.p_system, -99);
    part_type_shape(p_type_alt, pt_shape_line);
    part_type_blend(p_type_alt, true);
    part_type_alpha1(p_type_alt, 1);
    part_type_colour1(p_type_alt, color);
    part_type_speed(p_type_alt, 0, 2, 0, 0);
    part_type_size(p_type_alt, 0.2, 0.2, 0, 0);
    part_type_life(p_type_alt, 0, 10);
    part_type_orientation(p_type_alt, 0, 0, 0, 0, true);
    part_type_scale(p_type_alt, 1, 1);
    for (var start = 0; start < 360; start++) {
        var xx = x + lengthdir_x(radius, start);
        var yy = y + lengthdir_y(radius, start)
        var dir = point_direction(xx, yy, x, y);
        part_type_direction(p_type_alt, dir, dir, 0, 0);
        part_emitter_region(global.p_system, p_emitter, xx, xx, yy, yy, ps_shape_line, ps_distr_linear);
        part_emitter_burst(global.p_system, p_emitter, p_type_alt, 1);
    }
}

// Master Effect
if (type == MASTER_ORB) {

}
