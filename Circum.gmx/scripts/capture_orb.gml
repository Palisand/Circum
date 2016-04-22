/// capture_orb(orb, orb_obj)

var orb = argument0;
var orb_obj = argument1;

// set capture status
orb.captured = true;
orb.capturer = self.id;
orb.color = self.color;
num_orb_captured++;
//Handle capture streaks
capture_streak++;

// Visuals
with (instance_create(orb.x, orb.y, o_release_effect)) {
    color = other.color;
    orb_follow = orb.id;
}
