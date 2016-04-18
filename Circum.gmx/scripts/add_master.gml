
var symmetric = argument0;

var void_counter = 0;
var lock_counter = 0;
with o_orb {
    if (type == VOID_ORB) { void_counter++; }
    if (captured) { lock_counter++; }
}

//make a master orb to make things a tad easier
if (void_counter > 3 || lock_counter > 4) {
    with (o_orb) {
        if (type == DEFAULT_ORB && !captured) {
            set_orb_type(self,MASTER_ORB);
            if (argument0) {
                var nx = -(x-SCREEN_RADIUS);
                var ny = -(SCREEN_RADIUS-y);
                var refl = instance_position(nx+SCREEN_RADIUS, SCREEN_RADIUS-ny, o_orb);
                set_orb_type(refl,MASTER_ORB);
            }
            
            break;
        }
    }
}
