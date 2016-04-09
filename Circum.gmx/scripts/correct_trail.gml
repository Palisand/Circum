/// correct_trail(Min)

var Min = argument0;

//if the orb is moving on a fixed path
if ((orbiting || tethered)
    && current_orb.fixed && current_orb.fixed_orbit_speed != 0) {
    
    trail_id[0] = latch_time;
    
    //get relevant parameters of the orb and player
    var ox = current_orb.x;
    var oy = current_orb.y;
    var spd = orbit_speed;
    var orad = current_orb.orbit_radius;
    if (tethered) {
        orad = tether_radius;
        spd = sign(orbit_speed) * (launch_speed * room_speed) / dist_to_nearest;
    }
    
    //account for orb movement, for the points that have left the ricochet point
    var end_loop = min(Min,ricochet_time);
    for(var i = 0; i < end_loop; i++){
        var newX, newY;
        
        if (i > 0 && trail_id[i] != latch_time) {
            //the previous point pulls this one closer (scale down the distance)
            newX = ArrayTrail[i-1,0] + 0.7*(ArrayTrail[i,0] - ArrayTrail[i-1,0]);
            newY = ArrayTrail[i-1,1] + 0.7*(ArrayTrail[i,1] - ArrayTrail[i-1,1]);
            //check if orbit/tether radius has been reached
            if (point_distance(newX,newY,ox,oy) == orad) { trail_id[i] = latch_time; }
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
