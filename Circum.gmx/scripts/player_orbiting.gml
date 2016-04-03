///player_orbiting(player_obj, orb_obj)

//Called when orbiting
//Maintains orbit

var player_obj = argument0;
var orb_obj = argument1;

// the orb being orbited is stationary
current_orb.halt = true;

// Orbit
orbit += orbit_speed;
x = current_orb.x - cos(degtorad(orbit)) * current_orb.orbit_radius;
y = current_orb.y + sin(degtorad(orbit)) * current_orb.orbit_radius;
// set direction to orbit tangent
direction = orbit - (sign(orbit_speed) * 90);

// Launch
if ((keyboard_check_pressed(action_key)  // on action if there isn't a winner
    && (player_obj == o_player_debug || (player_obj == o_player && global.winner < 0)))
    || (current_orb.guarded && current_orb.guarder != id)  // if the orb is or has become guarded
    || current_orb.capturer != id  // the orb no longer belongs to the player
    ) {
    speed = launch_speed;
    orbiting = false;
    // reset orb speed and set direction
    current_orb.halt = false;
    current_orb.direction = point_direction(x, y, current_orb.x, current_orb.y);
}
