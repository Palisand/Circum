/// orb_update(orb_obj)

var orb_obj = argument0;

if (halt) {
    speed = lerp(speed, 0, 0.1);
}
else {
    speed = lerp(initial_speed,speed,0.1);
}

// bounce off the screen's edge
if (!fixed) {
    var col_edge_coords = edge_bounce_circle(orbit_radius);
}

// bounce off other orbs
if (fixed_orbit_speed == 0) {
    for (var i = 0; i < instance_number(orb_obj); i++) {
        var orb = instance_find(orb_obj, i);
        if (self.id != orb.id) {
            orb_hit_orb(orb);
        }
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
    void_orb_particles();
}

// Master Effect
if (type == MASTER_ORB) {
    master_orb_particles();
}
