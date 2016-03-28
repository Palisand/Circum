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
if (capture_streak >= POSSESSION  && capture_streak < DOMINATION && !possession_streak_used) {
    possession_streak_used = true;
    // launch payloads to opponent-captured orbs
    with (orb_obj) {
        var orb_id = id;
        var sender_id = other.id;
        if (type == DEFAULT_ORB && captured && capturer != other.id) {
            with (instance_create(other.x, other.y, o_payload)) {
                sender = sender_id;
                target = orb_id;
            }
        }
    }
}
if (capture_streak >= DOMINATION) {
    // launch payloads to opponent-captured orbs and free orbs (including master)
    with (orb_obj) {
        var orb_id = id;
        var sender_id = other.id;
        if ((type == DEFAULT_ORB || type == MASTER_ORB) 
            && (!captured || (captured && capturer != other.id))) {
            with (instance_create(other.x, other.y, o_payload)) {
                sender = sender_id;
                target = orb_id;
            }
        }
    }
    possession_streak_used = false;  // reset possession streak flag
    capture_streak = 0; // reset capture streak
}
