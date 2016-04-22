/// spawn_tutorial_orbs()

/*
switch(tut_count) {
// Launch
case 0:
    level_text = "Press [SPACE] to Launch"
    spawn_orbs(true,SCREEN_RADIUS/2,-0.3,0,get_orb_pattern(1,DEFAULT_ORB));
    break;

// Tether
case 1:
    level_text = "Hold [SPACE] while in the air to Tether";
    break;

// Hammer Unlock
case 2:
    level_text = "While Tethering you can Unlock Orbs";
    break;

// Key Orb Unlock
case 3:
    level_text = "You can also temporarily Unlock#by capturing Key Orbs";
    spawn_orbs(true,SCREEN_RADIUS/2,-0.3,0,get_orb_pattern(1,MASTER_ORB,CAPTURED_ORB,CAPTURED_ORB,CAPTURED_ORB));
    break;
    
// Dead Orbs
case 4:
    level_text = "Dead Orbs can't be captured";
    spawn_orbs(true,SCREEN_RADIUS/4,-0.5,random(360),get_orb_pattern(1,DEFAULT_ORB,DEAD_ORB,DEAD_ORB,DEAD_ORB,DEAD_ORB,DEAD_ORB,DEAD_ORB,DEAD_ORB,DEAD_ORB,DEAD_ORB,DEAD_ORB,DEAD_ORB,DEAD_ORB,DEAD_ORB,DEAD_ORB));
    break;
    
// Void Orbs
case 5:
    level_text = "Void Orbs should be aVOIDed... sorry";
    spawn_orbs(true,SCREEN_RADIUS/4,-0.5,random(360),get_orb_pattern(1,DEFAULT_ORB,VOID_ORB,VOID_ORB,VOID_ORB,VOID_ORB,VOID_ORB,VOID_ORB,VOID_ORB,VOID_ORB,VOID_ORB,VOID_ORB,VOID_ORB,VOID_ORB,VOID_ORB,VOID_ORB));
    break;

// Key Orb Void Guard
case 6:
    level_text = "But Key Orbs can protect you from them";
    spawn_orbs(true,SCREEN_RADIUS/4,-0.5,random(360),get_orb_pattern(1,MASTER_ORB,VOID_ORB,VOID_ORB,VOID_ORB,VOID_ORB,DEFAULT_ORB,VOID_ORB,VOID_ORB,VOID_ORB,VOID_ORB,DEFAULT_ORB,VOID_ORB,VOID_ORB,VOID_ORB,VOID_ORB));
    break;
}

/* TODO: these make good beginner levels
//dead orbs (all moving)
case 2:
    level_text = "Dead end";
    spawn_orbs(true,SCREEN_RADIUS/4,0.1,0,get_orb_pattern(2,DEFAULT_ORB,DEAD_ORB));
    spawn_orbs(true,SCREEN_RADIUS/2,-0.1,0,get_orb_pattern(2,DEFAULT_ORB,DEAD_ORB));
    break;
    
//void orbs (inner not moving, outer moving)
case 3:
    level_text = "Avoid the void";
    spawn_orbs(true,SCREEN_RADIUS/4,0,0,get_orb_pattern(2,DEFAULT_ORB,VOID_ORB));
    spawn_orbs(true,3*SCREEN_RADIUS/4,-0.1,0,get_orb_pattern(2,DEFAULT_ORB,DEFAULT_ORB));
    break;

//master and captured (all moving)
case 4:
    level_text = "Keys and locks";
    spawn_orbs(true,SCREEN_RADIUS/4,0.1,0,get_orb_pattern(2,DEFAULT_ORB,DEFAULT_ORB,MASTER_ORB));
    spawn_orbs(true,SCREEN_RADIUS/2,-0.1,0,get_orb_pattern(3,DEFAULT_ORB,CAPTURED_ORB));
    break;
        
//hammer and capture (inner not moving, outer moving)
case 5:
    level_text = "Locks can be#hammered open";
    spawn_orbs(true,SCREEN_RADIUS/4,0,0,get_orb_pattern(4,CAPTURED_ORB));
    spawn_orbs(true,3*SCREEN_RADIUS/4,0.1,0,get_orb_pattern(3,DEAD_ORB,DEFAULT_ORB));
    break;
    
//everything
case 6:
    level_text = "Freedom";
    spawn_orbs(false,SCREEN_RADIUS/4,0,0,get_orb_pattern(2,DEFAULT_ORB,MASTER_ORB));
    spawn_orbs(false,SCREEN_RADIUS/2,-0.1,0,get_orb_pattern(2,DEAD_ORB,DEFAULT_ORB,VOID_ORB));
    spawn_orbs(false,3*SCREEN_RADIUS/4,0.1,0,get_orb_pattern(2,DEFAULT_ORB,CAPTURED_ORB,DEFAULT_ORB));
}

