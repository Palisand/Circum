///wall_bounce_circle(radius)

var rad = argument0;

for (var dir = 0; dir < 360; dir++) {
    var x_check = x + lengthdir_x(rad, dir); 
    var y_check = y + lengthdir_y(rad, dir);
    
    if (x_check < 0 || x_check > room_width) {
        hspeed = -hspeed;
    }
    if (y_check < 0 || y_check > room_height) {
        vspeed = -vspeed;
    }
}
