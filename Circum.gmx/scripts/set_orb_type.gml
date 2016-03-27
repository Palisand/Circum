/// set_orb_type(orb, type)

var orb = argument0;
var orb_type = argument1;

orb.type = orb_type;
switch(orb.type){
    case DEAD_ORB:
        orb.color = c_blue;
        break;
    case VOID_ORB:
        orb.color = c_purple;
        break;
    case MASTER_ORB:
        orb.color = c_yellow;
        break;
}
