/// master_orb_particles()

part_system_depth(global.p_system, -99);
part_type_sprite(p_type_alt, s_flare, false, false, false);
part_type_blend(p_type_alt, true);
part_type_alpha2(p_type_alt, 1, 0);
part_type_colour1(p_type_alt, color);
part_type_speed(p_type_alt, 0, 4, 0, 0);
part_type_size(p_type_alt, 0.13, 0.13, 0, 0);
part_type_life(p_type_alt, 0, 10);
part_type_orientation(p_type_alt, 0, 0, 0, 0, true);
part_type_scale(p_type_alt, 1, 1);
part_type_direction(p_type_alt, 0, 360, 0, 0);
part_emitter_region(global.p_system, p_emitter, x - radius, x + radius, y - radius, y + radius, ps_shape_ellipse, ps_distr_linear);
if (guarded) {
    part_emitter_burst(global.p_system, p_emitter, p_type_alt, (GUARD_TIME - alarm[0]) / 8);
}
else {
    part_emitter_burst(global.p_system, p_emitter, p_type_alt, 100);
}
