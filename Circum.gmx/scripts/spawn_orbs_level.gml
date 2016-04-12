/// spawn_orbs_level()

// Spawning Orbs NEW
// Consider spawning with three different methods (the exact one will be selected at random):
//  1. Creating fixed-orbit rings in a setup that is prebuilt by hand
//  2. Creating fixed-orbit rings in a setup that is randomly generated
//  3. Creating randomly orbs (not fixed) in a randomly generated setup
// To implement the above, first we decide on which level generation method we will be using
// Comment: Use at least 2.25 as the denominator of room_width/x; otherwise orbs get close enough to constantly collide against edge of room
var spawning_type = irandom(2);         // Gives a number between 0 ~ 2 (including 2)
//spawning_type = S_FIXED_PREBUILT;
switch (spawning_type) {
    case S_FIXED_PREBUILT:  // Fixed orbit rings; prebuilt setups
        // We can have another switch statement here to pick out the prebuilt setup to use OR we can make a new function for that
        var num_prebuilt = 5;                           // Number of pre-built stages
        var fixed_select = irandom(num_prebuilt - 1);   // This makes it easier to access a particular stage in the following switch
        //fixed_select = 4;
        switch (fixed_select) {
            case 0:
                // Alternating Death; Difficulty: Medium
                spawn_orbs(true, room_width/7, -0.25, 0, get_orb_pattern(4, VOID_ORB));
                spawn_orbs(true, room_width/3.5, 0.3, 0, get_orb_pattern (4, DEFAULT_ORB, DEAD_ORB));
                spawn_orbs(true, room_width/2.25, -0.4, 0, get_orb_pattern (4, DEFAULT_ORB, DEAD_ORB, DEFAULT_ORB));
                break;
            case 1:  // The Cage; Difficulty: Easy (Relaxing) 
                spawn_orbs(true, room_width/7, 0, 0, get_orb_pattern(8, DEAD_ORB));
                spawn_orbs(true, room_width/5, 0, 22.5, get_orb_pattern(8, DEAD_ORB));
                spawn_orbs(false, room_width/4, 0, 0, get_orb_pattern(5, DEFAULT_ORB, CAPTURED_ORB));
                break;
            case 2: // Life or Death (aka Flaming Hell); Difficulty: Very Hard
                spawn_orbs(true, room_width/7, -0.25, 0, get_orb_pattern(8, DEFAULT_ORB, VOID_ORB));
                spawn_orbs(true, room_width/3.5, 0.5, 0, get_orb_pattern (8, VOID_ORB, DEFAULT_ORB));
                spawn_orbs(true, room_width/2.25, -0.5, 0, get_orb_pattern (8, DEFAULT_ORB));
                break;
            case 3: // Carefree Carousel; Difficulty: Medium
                spawn_orbs(true, room_width/7, -0.25, 0, get_orb_pattern(4, CAPTURED_ORB));
                spawn_orbs(true, room_width/3.5, 0.3, 0, get_orb_pattern (8, DEFAULT_ORB));
                spawn_orbs(true, room_width/2.25, -0.4, 0, get_orb_pattern (12, DEFAULT_ORB));
                break;
            case 4: // The Cage 2.0; Easy but Tedious
                spawn_orbs(true, room_width/7, 0, 0, get_orb_pattern(7, DEAD_ORB));
                spawn_orbs(true, room_width/4.75, 0, 20, get_orb_pattern(6, DEAD_ORB, DEFAULT_ORB, CAPTURED_ORB));
                spawn_orbs(false, room_width/2.5, 0, 0, get_orb_pattern(4, DEFAULT_ORB, CAPTURED_ORB, CAPTURED_ORB));
                spawn_orbs(false, room_width/2.5, 0, 0, get_orb_pattern(1, MASTER_ORB));
        }
        break;
    case S_FIXED_RANDOM:    // Fixed orbit rings; random setup
        var orbit_lanes = 1 + irandom(S_MAX_LANES); // Find out how many lanes we are going to have; default [1,3]
        //orbit_lanes = 1;
        switch (orbit_lanes) {
            case 1: // One lane
                spawn_orbs(true, room_width/3, -0.5, 0, get_orb_pattern(3, DEFAULT_ORB, irandom(CAPTURED_ORB), irandom(CAPTURED_ORB), irandom(CAPTURED_ORB)));
                break;
            case 2: // Two lanes
                spawn_orbs(true, room_width/5, -0.5, 0, get_orb_pattern(3, DEFAULT_ORB, irandom(CAPTURED_ORB)));
                spawn_orbs(true, room_width/2.5, +0.5, 0, get_orb_pattern(2, DEFAULT_ORB, irandom(CAPTURED_ORB), irandom(CAPTURED_ORB), irandom(CAPTURED_ORB)));
                break;
            case 3: // Three lanes
                spawn_orbs(true, room_width/7, -0.25, 0, get_orb_pattern(2, irandom(CAPTURED_ORB), irandom(CAPTURED_ORB)));
                spawn_orbs(true, room_width/3.5, 0.5, 0, get_orb_pattern (3, irandom(CAPTURED_ORB), irandom(CAPTURED_ORB)));
                spawn_orbs(true, room_width/2.25, -0.5, 0, get_orb_pattern (4, DEFAULT_ORB, irandom(CAPTURED_ORB), irandom(CAPTURED_ORB)));
                break;
        }
        
        break;
    case S_RANDOM:          // Random spawning of orbs   
        spawn_orbs(false, room_width/3, 0, 0, get_orb_pattern(1 + irandom(S_MAX_LANES), 
                    DEFAULT_ORB, irandom(DEAD_ORB), irandom(DEAD_ORB), DEFAULT_ORB, DEFAULT_ORB));
        spawn_orbs(false, room_width/2.5, 0, 0, get_orb_pattern(1, irandom(CAPTURED_ORB), irandom(CAPTURED_ORB)));
        break;
}

// Save Layout
save_level();
