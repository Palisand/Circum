/// edge_bounce_circle(radius)
/*
    For use with circular screen
*/
var rad = argument0;

for (var deg = 0; deg < 360; deg++) {
    var x_check = x + lengthdir_x(rad, deg); 
    var y_check = y + lengthdir_y(rad, deg);
    var point_dir = point_direction(x_check, y_check, room_width/2, room_height/2);  // TODO: these should be constants
    var point_dist = point_distance(x_check, y_check, room_width/2, room_height/2);
    var diff = point_dist - room_width/2;  // the circular screen "radius"
    
    if (diff > 0) {
        // move out of edge
        x += lengthdir_x(diff, point_dir);
        y += lengthdir_y(diff, point_dir);
        // bounce (change direction)
        var obj_dir = direction - 180;
        var norm_dir = point_dir - 180;
        var incident_angle = angle_difference(obj_dir, norm_dir);
        direction = obj_dir + sign(norm_dir - 180) * incident_angle * 2;
        break;
    }
}
