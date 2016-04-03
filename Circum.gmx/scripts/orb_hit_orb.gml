//orb_hit_orb(orb)

var x1 = x;
var y1 = y;
var r1 = orbit_radius;

var orb = argument0;
var x2 = orb.x;
var y2 = orb.y;
var r2 = orb.orbit_radius;

//aabb
if (x1+r1+r2 > x2 and x1 < x2+r1+r2 and y1+r1+r2 > y2 and y1 < y2+r1+r2) {
    //circle-circle
    var dist = sqrt(sqr(x1-x2)+sqr(y1-y2));
    var diff = (r1 + r2) - dist;
    if (diff > 0) {  // dist < r1+r2
        
        // set orb collision statuses and coordinates
        col_orb = true;
        col_orb_coords[0] = ((x1 * r2) + (x2 * r1)) / (r1 + r2);
        col_orb_coords[1] = ((y1 * r2) + (y2 * r1)) / (r1 + r2);
        orb.col_orb_coords[0] = col_orb_coords[0];
        orb.col_orb_coords[1] = col_orb_coords[1];
        
        // bounce off orb
        var obj_dir = point_direction(x, y, orb.x, orb.y) - 180;
        var norm_dir = point_direction(col_orb_coords[0], col_orb_coords[1], orb.x, orb.y);
        var incident_angle = angle_difference(obj_dir, norm_dir);
        direction = obj_dir + sign(norm_dir - 180) * incident_angle * 2;
        
        obj_dir = point_direction(orb.x, orb.y, x, y) - 180;
        norm_dir = point_direction(col_orb_coords[0], col_orb_coords[1], x, y);
        indicent_angle = angle_difference(obj_dir, norm_dir);
        orb.direction = obj_dir + sign(norm_dir - 180) * incident_angle * 2;
        
        if (!halt) {  // if calling orb is not stationary
            // move out of orb
            var dir = point_direction(orb.x, orb.y, x, y);
            x += lengthdir_x(ceil(diff), dir);
            y += lengthdir_y(ceil(diff), dir);
        }
        
        // Play ricochet sound
        var s_engine = audio_play_sound(snd_orb_hit_orb, 1, 0);
        audio_sound_pitch(s_engine, 0.15 * global.scale[irandom(7)]);
    }
}
