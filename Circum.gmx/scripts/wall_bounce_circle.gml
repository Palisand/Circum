///wall_bounce_circle(radius)

var rad = argument0;

var bounce_x = false;
var bounce_y = false;

for (var dir = 0; dir < 360; dir++) {
    var x_check = x + lengthdir_x(rad, dir); 
    var y_check = y + lengthdir_y(rad, dir);
    
    if (x_check < 0 || x_check > room_width) {
        bounce_x = true;
    }
    if (y_check < 0 || y_check > room_height) {
        bounce_y = true;
    }
}

if (bounce_x) { hspeed = -hspeed; }
if (bounce_y) { vspeed = -vspeed; }
