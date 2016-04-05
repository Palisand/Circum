/// set_orb_type(orb, type)

var orb = argument0;
var orb_type = argument1;

orb.type = orb_type;
switch(orb.type){
    case DEAD_ORB:
        orb.color = c_gray;
        break;
    case VOID_ORB:
        orb.color = c_red;
        break;
    case MASTER_ORB:
        orb.color = c_white;
        break;
    case CAPTURED_ORB:  // for single-player use
        var fake_player;
        if (!instance_exists(o_fake_player)) {
            fake_player = instance_create(0, 0, o_fake_player);
        }
        orb.captured = true;
        with (o_fake_player) {
            orb.capturer = id;
        }
        orb.type = DEFAULT_ORB;
        break;
}
