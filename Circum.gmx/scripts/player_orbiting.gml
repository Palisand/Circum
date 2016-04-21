///player_orbiting(player_obj, orb_obj)

//Called when orbiting
//Maintains orbit

var player_obj = argument0;
var orb_obj = argument1;

// the orb being orbited is stationary
current_orb.halt = true;

// Orbit
orbit += orbit_speed*global.speed_scale;
x = current_orb.x - cos(degtorad(orbit)) * current_orb.orbit_radius;
y = current_orb.y + sin(degtorad(orbit)) * current_orb.orbit_radius;
// set direction to orbit tangent
direction = orbit - (sign(orbit_speed) * 90);

// Launch
if ((keyboard_check_pressed(action_key)  // on action if there isn't a winner
    && (player_obj == o_player_debug || (player_obj == o_player && global.winner < 0)))
    ) {
    speed = launch_speed;
    orbiting = false;
    // reset orb speed and set direction
    current_orb.halt = false;
    current_orb.direction = point_direction(x, y, current_orb.x, current_orb.y);
}
