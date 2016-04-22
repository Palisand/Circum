//Called when player is not orbiting (flying around or tethered)
//player_hit_orb(orb, orb_obj)

var orb = argument0;
var orb_obj = argument1;
var orad = orb.orbit_radius;

// if the player will collide with the orbit in the next step
if (point_in_circle(x + hspeed, y + vspeed, orb.x, orb.y, orad)) {
    // set orb collision status if not yet set
    if (!col_orb_set) {
        col_orb_set = true;
        orb.col_player = true;
    }
    
    var to_orb_dir = point_direction(x, y, orb.x, orb.y);
    
    // if CAPTURED orb
    if (orb.captured) {
        release_orb(orb,orad,to_orb_dir)
    }
    // if FREE orb
    else if (!orb.captured) {
        set_to_orbit(orb, to_orb_dir);
        capture_orb(orb, orb_obj);
    }
}
