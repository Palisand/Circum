var orb = argument0;
var orb_type = argument1;

orb.orb_type = orb_type;
if (orb_type == DEAD_ORB) { orb.color = c_blue; }
else if (orb_type == VOID_ORB) { orb.color = c_purple; }
else if (orb_type == MASTER_ORB) { orb.color = c_yellow; }
