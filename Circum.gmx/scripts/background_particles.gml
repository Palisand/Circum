// background_particles()

part_system_depth(global.p_system, -98);
part_type_sprite(p_type, s_flare, false, false, false);
part_type_blend(p_type, true);
part_type_alpha2(p_type, 1, 0);
part_type_colour1(p_type, c_white);
part_type_direction(p_type, 0, 360, 0, 0); // completely random direction
part_type_speed(p_type, 0, 4, 0, 0);
part_type_size(p_type, 0.13, 0.13, 0, 0);
part_type_life(p_type, 1, 120);
part_type_orientation(p_type, 0, 360, 0, 0, false);
part_type_scale(p_type, 1, 1);
part_emitter_region(global.p_system, p_emitter, 0, room_width, 0, room_height, ps_shape_ellipse, ps_distr_linear);
part_emitter_burst(global.p_system, p_emitter, p_type, random(5));
