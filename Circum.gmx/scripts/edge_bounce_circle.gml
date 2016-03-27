/// edge_bounce_circle(radius)
/*
    For use with circular screen
*/
var rad = argument0;

var max_x_check = 0;
var max_y_check = 0;
var max_diff = 0;

for (var deg = 0; deg < 360; deg++) {
    var x_check = x + lengthdir_x(rad, deg);
    var y_check = y + lengthdir_y(rad, deg);
    var point_dist = point_distance(x_check, y_check, SCREEN_RADIUS, SCREEN_RADIUS);
    var diff = point_dist - SCREEN_RADIUS;
    if (diff > max_diff) {
        max_diff = diff;
        max_x_check = x_check;
        max_y_check = y_check;
    }
}

var point_dir = point_direction(max_x_check, max_y_check, SCREEN_RADIUS, SCREEN_RADIUS);

if (max_diff > 0) {
    // set collision status
    col_edge = true;
    // move out of edge
    x += lengthdir_x(max_diff, point_dir);
    y += lengthdir_y(max_diff, point_dir);
    // bounce (change direction)
    var obj_dir = direction - 180;
    var norm_dir = point_dir - 180;
    var incident_angle = angle_difference(obj_dir, norm_dir);
    direction = obj_dir + sign(norm_dir - 180) * incident_angle * 2;
}

var col_coords;
col_coords[0] = max_x_check;
col_coords[1] = max_y_check;

return col_coords;
