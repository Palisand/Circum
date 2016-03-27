/// set_orb_type(orb, type)

var orb = argument0;
var orb_type = argument1;

orb.type = orb_type;
switch(orb.type){
    case DEAD_ORB:
        orb.color = c_dkgray;  // will look like a dying star?
        break;
    case VOID_ORB:
        orb.color = c_red;  // will look like a black hole
        break;
    case MASTER_ORB:
        orb.color = c_orange;  // will be white but with a glowing core
        break;
}
