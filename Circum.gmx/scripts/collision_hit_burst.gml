/// collision_hit_burst(x, y, dir_min, dir_max, color, amount, lifetime, emitter, type)

var xx = argument0;
var yy = argument1;
var dir_min = argument2;
var dir_max = argument3;
var color = argument4;
var amount = argument5;
var lifetime = argument6;
var emitter = argument7;
var type = argument8;

part_system_depth(global.p_system, -99);
part_type_shape(type, pt_shape_line);
part_type_blend(type, true);
part_type_alpha2(type, 1, 0);
part_type_colour1(type, color);
part_type_direction(type, dir_min, dir_max, 0, 0);
part_type_speed(type, 0, 8, 0, 0);
part_type_size(type, 0.2, 0.2, 0, 0);  // REMINDER: cool effects when wiggle used (particularly for speed and size)
part_type_life(type, 1, lifetime);
part_type_orientation(type, 0, 0, 0, 0, true);
part_type_scale(type, 1, 1);
part_emitter_region(global.p_system, emitter, xx, xx, yy, yy, ps_shape_ellipse, ps_distr_gaussian);
part_emitter_burst(global.p_system, emitter, type, amount);
