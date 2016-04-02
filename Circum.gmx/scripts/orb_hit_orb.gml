//orb_hit_orb(orb)

//this orb is stationary, so it cannot have hit anything
if (halt) { return 0; }

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
    
        // move out of orb
        var dir = point_direction(orb.x, orb.y, x, y);
        x += lengthdir_x(diff, dir);
        y += lengthdir_y(diff, dir);
        
        // set orb collision statuses and coordinates
        col_orb = true;
        orb.col_orb = true;
        col_orb_coords[0] = ((x1 * r2) + (x2 * r1)) / (r1 + r2);
        col_orb_coords[1] = ((y1 * r2) + (y2 * r1)) / (r1 + r2);
        other.col_orb_coords[0] = col_orb_coords[0];
        other.col_orb_coords[1] = col_orb_coords[1];
        
        //this orb has hit a stationary orb
        if (orb.halt) { ricochet_off_orb(orb, true); }
        
        //both orbs are moving
        else {
            var vx1 = hspeed;
            var vy1 = vspeed;
            
            var vx2 = orb.hspeed;
            var vy2 = orb.vspeed;
            
            var newVx1 = (vx1*(r1-r2)+2*r2*vx2)/(r1+r2);
            var newVy1 = (vy1*(r1-r2)+2*r2*vy2)/(r1+r2);
            var newVx2 = (vx2*(r2-r1)+2*r1*vx1)/(r1+r2);
            var newVy2 = (vy2*(r2-r1)+2*r1*vy1)/(r1+r2);
            
            hspeed = newVx1;
            vspeed = newVy1;
            orb.hspeed = newVx2;
            orb.vspeed = newVy2;
            
            x += hspeed;
            y += vspeed;
            orb.x += orb.hspeed;
            orb.y += orb.vspeed;
        }
        
        // Play ricochet sound
        var s_engine = audio_play_sound(snd_orb_hit_orb, 1, 0);
        audio_sound_pitch(s_engine, 0.15 * global.scale[irandom(7)]);
    }
}
