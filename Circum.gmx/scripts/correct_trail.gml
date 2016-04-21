/// correct_trail(Min)

var Min = argument0;

//if the orb is moving on a fixed path
if ((orbiting || tethered)
    && current_orb.fixed && current_orb.fixed_orbit_speed != 0) {
    
    trail_id[0] = latch_time;
    trail_tethered[0] = -1;
    if (tethered) { trail_tethered[0] = current_orb; }
    
    //get relevant parameters of the orb and player
    var ox = current_orb.x;
    var oy = current_orb.y;
    var spd = orbit_speed;
    var orad = current_orb.orbit_radius;
    if (tethered) {
        orad = dist_to_nearest;
        spd = sign(orbit_speed) * (launch_speed * room_speed) / dist_to_nearest;
    }
    
    //account for orb movement, for the points that have left the ricochet point
    var end_loop = min(Min,ricochet_time);
    for(var i = 0; i < end_loop; i++){
        var newX, newY;
        
        if (i > 0 && trail_id[i] != latch_time) {
            var oldX = ArrayTrail[i,0];
            var oldY = ArrayTrail[i,1];
            var prevX = ArrayTrail[i-1,0];
            var prevY = ArrayTrail[i-1,1];
        
            //the previous point pulls this one closer (scale down the distance)
            newX = prevX + 0.7*(oldX - prevX);
            newY = prevY + 0.7*(oldY - prevY);

            //is the point being pulled through the orb?
            if (orbiting &&
                (
                point_distance(newX,newY,ox,oy) < orad ||
                (trail_tethered[i] == current_orb && point_distance(oldX,oldY,ox,oy) > orad)
                )
                ) {
                //push it out
                 var dir = point_direction(ox,oy,newX,newY);
                 newX = ox + lengthdir_x(orad,dir);
                 newY = oy + lengthdir_y(orad,dir);
                 trail_id[i] = latch_time;
            }
            
            //check if orbit/tether radius has been reached
            else if (point_distance(newX,newY,ox,oy) == orad) { trail_id[i] = latch_time; }            
            
        }
        
        else {
            //calculate based on player's angular location
            var angle = orbit-i*spd;
            newX = ox - orad*dcos(angle);
            newY = oy + orad*dsin(angle);
        }
        
        ArrayTrail[i,0] = newX;
        ArrayTrail[i,1] = newY;
    }
}

else { trail_id[0] = -1; }
