/// void_orb_particles()

part_system_depth(global.p_system, -99);
part_type_sprite(p_type_alt, s_line, false, false, false);
part_type_blend(p_type_alt, true);
part_type_alpha1(p_type_alt, 1);
part_type_colour1(p_type_alt, color);
part_type_speed(p_type_alt, 0, 2, 0, 0);
part_type_size(p_type_alt, 0.13, 0.13, 0, 0);
part_type_life(p_type_alt, 0, 10);
part_type_orientation(p_type_alt, 0, 0, 0, 0, true);
part_type_scale(p_type_alt, 1, 1);
for (var start = 0; start < 360; start += 3) {
    var xx = x + lengthdir_x(radius, start);
    var yy = y + lengthdir_y(radius, start)
    var dir = point_direction(xx, yy, x, y);
    part_type_direction(p_type_alt, dir, dir, 0, 0);
    part_emitter_region(global.p_system, p_emitter, xx, xx, yy, yy, ps_shape_line, ps_distr_linear);
    part_emitter_burst(global.p_system, p_emitter, p_type_alt, 1);
}
