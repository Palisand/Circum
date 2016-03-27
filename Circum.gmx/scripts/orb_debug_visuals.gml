/// orb_debug_visuals

draw_line(x, y, x + lengthdir_x(orbit_radius, direction), y + lengthdir_y(orbit_radius, direction));
draw_set_colour(c_white);
var dir = point_direction(x, y, room_width/2, room_height/2);
draw_line(x, y, x + lengthdir_x(orbit_radius, dir), y + lengthdir_y(orbit_radius, dir));
draw_circle(x, y, orbit_radius, true);

// Guard alarm
draw_text_transformed(x, y + orbit_radius, alarm[0], 2, 2, 0);

// Orb type
switch (type) {
    case DEAD_ORB:
        draw_text(x, y, "DEAD");
        break;
    case VOID_ORB:
        draw_text(x, y, "VOID");
        break;
    case MASTER_ORB:
        draw_text(x, y, "MASTER");
        break;
}
