//orb_hit_orb(orb)

var x1 = x;
var y1 = y;
var r1 = radius;

var orb = argument0;
var x2 = orb.x;
var y2 = orb.y;
var r2 = orb.radius;

//aabb
if (x1+r1+r2 > x2 and x1 < x2+r1+r2 and y1+r1+r2 > y2 and y1 < y2+r1+r2) {
    //circle-circle
    var dist = sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2));
    if (dist < r1+r2) {
    
        //this orb is stationary
        if (speed == 0) { return 0; }
        
        //this orb has hit a stationary orb
        else if (orb.speed == 0) {
            ricochet_off_orb(orb);
            return 0;
        }
    
        //both orbs are moving
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
}
