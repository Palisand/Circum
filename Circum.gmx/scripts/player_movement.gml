/// Movement & Capturing
//will work for both debug and regular players
//(specifiy which by the arguments)
var player_obj = argument0;
var orb_obj = argument1;

//check against the circle
if (edge_bounce_circle(radius)) {
    capture_streak = 0;
}

//check if other players' streaks affect you
var ricochet_captured = false;
var ricochet_free = false;
for(var i = 0; i < instance_number(player_obj); i++){
    if (i == pid) { continue; }
    if (global.streak_time[i] + STREAK_TIMEOUT > get_timer()) {
        ricochet_captured = true;
        ricochet_free = ricochet_free or (global.streak_type[i] == DOMINATION);
    }
}

//if we are orbiting an orb
if (orbiting) {
    current_orb.speed = lerp(current_orb.speed,0,0.1);  // the orb being orbited is stationary
    // launch (if there isn't a winner)
    if (keyboard_check_pressed(action_key) &&
        (player_obj == o_player_debug || (player_obj == o_player && global.winner < 0))
        ) {
        speed = launch_speed;
        orbiting = false;
    }
    // orbit
    orbit += orbit_speed;
    x = current_orb.x - cos(degtorad(orbit)) * current_orb.orbit_radius;
    y = current_orb.y + sin(degtorad(orbit)) * current_orb.orbit_radius;
    // set direction to orbit tangent
    direction = orbit - (sign(orbit_speed) * 90);
}

//we're flying around the room
else {

    //we have to check against all other orbs
    for (var i = 0; i < instance_number(orb_obj); i++) {
        var orb = instance_find(orb_obj, i);

        // if the player will collide with the orbit in the next step
        if (point_in_circle(x + hspeed, y + vspeed, orb.x, orb.y, orb.orbit_radius)) {

            //if the collision will be with a void orb, die
            if (orb.type == VOID_ORB) {
                instance_destroy();
                break;
            }
            
            // if the collision will be with an opponent-captured orb
            if ((orb.type == DEFAULT_ORB && orb.capturer != -1 && orb.capturer != id)
                //OR a dead orb
                || orb.type == DEAD_ORB
                //OR opponent has a streak reward
                || (orb.capturer == id && ricochet_captured)
                || (!orb.captured && ricochet_free)) {
                ricochet_off_orb(orb, false);
                capture_streak = 0;
                break;
            }
            
            // translate onto orbit
            orbit = point_direction(x, y, orb.x, orb.y);
            x = orb.x - cos(degtorad(orbit)) * orb.orbit_radius;
            y = orb.y + sin(degtorad(orbit)) * orb.orbit_radius;
            // set clockwise or counter-clockwise orbit depending on collision angle
            orbit_speed = sign(angle_difference(orbit, direction)) * orbit_speed_set;
            if (orbit_speed == 0) {
                orbit_speed = choose(orbit_speed_set, -orbit_speed_set);
            }
            
            // set orb capture status if not yet captured
            if (!orb.captured) {
                orb.captured = true;
                orb.capturer = self.id;
                orb.color = self.color;
                num_orb_captured++;
                
                //Handle capture streaks
                capture_streak++;
                if (capture_streak == 3 || capture_streak == 5) {
                    global.streak_time[pid] = get_timer();
                    global.streak_type[pid] = POSSESSION;
                    if (capture_streak == 5) { global.streak_type[pid] = DOMINATION; }
                }
            }
            
            //we bumped into one of our own, so it's not captured
            else { capture_streak = 0; }
            
            //we're orbiting now
            speed = 0;
            orbiting = true;
            current_orb = orb;
                        
            //you won
            if (orb.type == MASTER_ORB) {
                num_orb_captured = instance_number(orb_obj);
            }
        }
    }
    
    // Reset orb speed
    if (current_orb != -1) {
        current_orb.speed = lerp(current_orb.speed,current_orb.initial_speed,0.1);
    }
    
    speed = launch_speed;
}
