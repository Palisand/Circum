/// edge_bounce_circle(radius)
/*
    For use with circular screen
*/
var rad = argument0;

var bounce = false;

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
        
        // First attempt (objects do not get 'stuck', but still completely wrong!)
        direction = (direction - 180) + angle_difference(direction - 180, point_dir - 180) * 2;
        
        // Second attempt
        // http://gamedev.stackexchange.com/questions/33384/how-to-bounce-a-2d-point-particle-off-of-a-circular-edge
        /*
        var vx = cos(degtorad(direction));
        var vy = sin(degtorad(direction));
        var nx = cos(degtorad(point_dir));
        var ny = sin(degtorad(point_dir));
        var n_len = sqrt(sqr(nx) + sqr(ny));
        nx /= n_len;
        ny /= n_len;
        var rx = vx - 2 * (nx * vx) * nx;
        var ry = vy - 2 * (ny * vy) * ny;
        direction = radtodeg(arctan(ry / rx));*/
    }
}
