/// spawn_tutorial_orbs()

switch(tut_count) {
//launch and tether (not moving)
case 0:
    tutorial_text = "Tap to launch#Hold to tether";
    spawn_orbs(true,SCREEN_RADIUS/2,0,0,get_orb_pattern(4,DEFAULT_ORB));
    break;
    
//dead orbs (all moving)
case 1:
    tutorial_text = "Dead end";
    spawn_orbs(true,SCREEN_RADIUS/4,0.1,0,get_orb_pattern(2,DEFAULT_ORB,DEAD_ORB));
    spawn_orbs(true,SCREEN_RADIUS/2,-0.1,0,get_orb_pattern(2,DEFAULT_ORB,DEAD_ORB));
    break;
    
//void orbs (inner not moving, outer moving)
case 2:
    tutorial_text = "Avoid the void";
    spawn_orbs(true,SCREEN_RADIUS/4,0,0,get_orb_pattern(2,DEFAULT_ORB,VOID_ORB));
    spawn_orbs(true,3*SCREEN_RADIUS/4,-0.1,0,get_orb_pattern(2,DEFAULT_ORB,DEFAULT_ORB));
    break;
    
//hammer and capture (inner not moving, outer moving)
case 3:
    tutorial_text = "Tether and hammer";
    spawn_orbs(true,SCREEN_RADIUS/4,0,0,get_orb_pattern(4,CAPTURED_ORB));
    spawn_orbs(true,3*SCREEN_RADIUS/4,0.1,0,get_orb_pattern(3,DEAD_ORB,DEFAULT_ORB));
    break;
    
//master and captured (all moving)
case 4:
    tutorial_text = "The master orb#masters the orbs";
    spawn_orbs(true,SCREEN_RADIUS/4,0.1,0,get_orb_pattern(2,DEFAULT_ORB,DEFAULT_ORB,MASTER_ORB));
    spawn_orbs(true,SCREEN_RADIUS/2,-0.1,0,get_orb_pattern(3,DEFAULT_ORB,CAPTURED_ORB));
    break;

//everything
case 5:
    tutorial_text = "Freedom";
    spawn_orbs(false,SCREEN_RADIUS/4,0,0,get_orb_pattern(2,DEFAULT_ORB,MASTER_ORB));
    spawn_orbs(false,SCREEN_RADIUS/2,-0.1,0,get_orb_pattern(2,DEAD_ORB,DEFAULT_ORB,VOID_ORB));
    spawn_orbs(false,3*SCREEN_RADIUS/4,0.1,0,get_orb_pattern(2,DEFAULT_ORB,CAPTURED_ORB,DEFAULT_ORB));
}
