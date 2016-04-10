
switch(tut_count) {
//launch and tether (not moving)
case 0:
    spawn_orbs(true,SCREEN_RADIUS/2,0,0,get_orb_pattern(4,DEFAULT_ORB));
    break;
    
//dead orbs (all moving)
case 1:
    spawn_orbs(true,SCREEN_RADIUS/4,0.1,0,get_orb_pattern(2,DEFAULT_ORB,DEAD_ORB));
    spawn_orbs(true,SCREEN_RADIUS/2,-0.1,0,get_orb_pattern(2,DEFAULT_ORB,DEAD_ORB));
    break;
    
//void orbs (inner not moving, outer moving)
case 2:
    spawn_orbs(true,SCREEN_RADIUS/4,0,0,get_orb_pattern(2,DEFAULT_ORB,VOID_ORB));
    spawn_orbs(true,3*SCREEN_RADIUS/4,-0.1,0,get_orb_pattern(2,DEFAULT_ORB,DEFAULT_ORB));
    break;
    
//hammer and capture (inner not moving, outer moving)
case 3:
    spawn_orbs(true,SCREEN_RADIUS/4,0,0,get_orb_pattern(2,CAPTURED_ORB, DEAD_ORB));
    spawn_orbs(true,3*SCREEN_RADIUS/4,0.1,0,get_orb_pattern(3,DEAD_ORB,DEFAULT_ORB));
    break;
    
//master and captured (all moving)
case 4:
    spawn_orbs(true,SCREEN_RADIUS/4,0.1,0,get_orb_pattern(2,DEFAULT_ORB,DEFAULT_ORB,MASTER_ORB));
    spawn_orbs(true,SCREEN_RADIUS/2,-0.1,0,get_orb_pattern(3,DEFAULT_ORB,CAPTURED_ORB));
    break;

//everything
case 5:
    spawn_orbs(false,SCREEN_RADIUS/4,0,0,get_orb_pattern(2,DEFAULT_ORB,MASTER_ORB));
    spawn_orbs(false,SCREEN_RADIUS/2,-0.1,0,get_orb_pattern(2,DEAD_ORB,DEFAULT_ORB,VOID_ORB));
    spawn_orbs(false,3*SCREEN_RADIUS/4,0.1,0,get_orb_pattern(2,DEFAULT_ORB,CAPTURED_ORB,DEFAULT_ORB));
}
