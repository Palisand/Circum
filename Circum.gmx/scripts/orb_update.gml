/// orb_update(orb_obj)

var orb_obj = argument0;

if (halt) {
    speed = lerp(speed, 0, 0.1);
}
else {
    speed = lerp(speed, initial_speed*global.speed_scale*global.orb_speed_multiplier, 0.1);
}

// Fixed Orbit
if (fixed) {
    initial_speed = 0;
    fixed_orbit += fixed_orbit_speed * global.speed_scale * global.orb_speed_multiplier;
    x = room_width/2 - cos(degtorad(fixed_orbit)) * fixed_orbit_radius;
    y = room_height/2 + sin(degtorad(fixed_orbit)) * fixed_orbit_radius;
}

// bounce off the screen's edge
if (!fixed) {
    var col_edge_coords = edge_bounce_circle(orbit_radius);
}

// bounce off other orbs
if (fixed_orbit_speed == 0) {
    for (var i = 0; i < instance_number(orb_obj); i++) {
        var orb = instance_find(orb_obj, i);
        if (self.id != orb.id && point_distance(x, y, orb.x, orb.y) < orbit_radius * 2) {
            orb_hit_orb(orb);
        }
    }
}

// collision-dependent
if (col_orb || col_edge || col_player) {
    orbit_radius_alpha = orbit_radius_alpha_max;  // reveal orbit radius on collision
}
else {
    orbit_radius_alpha = lerp(orbit_radius_alpha, orbit_radius_alpha_min, orbit_radius_alpha_rate);  // fade out otherwise
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

// Void Effect
if (type == VOID_ORB) {
    void_orb_particles();
}

// Master Effect
if (type == MASTER_ORB) {
    master_orb_particles();
}
