/// spawn_orbs_level()

// TODO: One gigantic switch statement on 'global.current_level' to deal with each level
/* 
    Difficulty progression as noted in the guide:
    1.  Stationary
    2.  Stationary and Fixed-Orbit Ring
    3.  Fixed-Orbit Ring
    4.  Stationary and Random
    5.  Random
    
    5 Levels for each difficulty tier increase?
*/
global.current_level = 15;
switch (global.current_level) {
    // 1. Stationary Orb Levels
    case 0:     // Easiest level, 1 stationary orb (1)
        spawn_orbs (true, room_width/3, 0, 100, 1);
        break;
    case 1:     // 2 stationary orbs (2)
        spawn_orbs (true, room_width/3, 0, 150, 2);
        break;
    case 2:     // 3 stationary orbs (3)
        spawn_orbs (true, room_width/7, 0, 190, 1);
        spawn_orbs (true, room_width/3.5, 0, 100, 1);
        spawn_orbs (true, room_width/3.5, 0, 330, 1);
        break;
    case 3:     // 4 stationary orbs (4)
        spawn_orbs (true, room_width/2.5, 0, 60, 2);
        spawn_orbs (true, room_width/5, 0, 330, 2);
        break;
    case 4:     // 6 stationary orbs (6)
        spawn_orbs (true, room_width/2.5, 0, 0, 2);
        spawn_orbs (true, room_width/4, 0, 80, 2);
        spawn_orbs (true, room_width/7, 0, 120, 2);
        break;
    case 5:     // 9 stationary orbs (9)
        spawn_orbs (true, room_width/7, 0, 0, 3);
        spawn_orbs (true, room_width/3.5, 0, 20, 3);
        spawn_orbs (true, room_width/2.25, 0, 60, 3);
        break;
    // Stopping at 5 for completely stationary levels because a player commented that it was starting to test her patience.
    // 2. Stationary and Fixed-Orbit Rings (Moving)
    case 6:     // Introduce Fixed-Orbit Rings!! (3)
        spawn_orbs (true, room_width/3, 0.25, 0, 3);
        break;
    case 7:     // 2 stationary (outside), 3 fixed-orbit (inside) (5)
        spawn_orbs (true, room_width/6, -0.25, 0, 3);
        spawn_orbs (true, room_width/3, 0, 100, 2);
        break;
    case 8:     // 1 stationary (inside), 4 fixed-orbit (middle), 1 stationary outside (6)
        spawn_orbs (true, room_width/7, 0, 90, 1);
        spawn_orbs (true, room_width/4, 0.25, 0, 4);
        spawn_orbs (true, room_width/2.5, 0, 220, 1);
        break;
    case 9:     // 3 stationary (inside), 3 fixed-orbit (outside) (6)
        spawn_orbs (true, room_width/3, -0.25, 0, 3);
        spawn_orbs (true, room_width/7, 0, 0, 3);
        break;
    case 10:    // Progression 2 boss battle!! (10)
        spawn_orbs (true, room_width/7, 0.25, 0, 3);
        spawn_orbs (true, room_width/3.5, 0, 30, 4);
        spawn_orbs (true, room_width/2.25, -0.40, 0, 3);
        break;
    // 3. Fixed-Orbit Rings!!
    case 11:    // Fast Ring of 4! (4)
        spawn_orbs (true, room_width/4, 0.6, 0, 4);
        break;
    case 12:    // Opposite Direction: 2 Rings! (6)
        spawn_orbs (true, room_width/6, 0.4, 0, 3);
        spawn_orbs (true, room_width/3, -0.5, 0, 3);
        break;
    case 13:    // 3 Rings in the Same Direction! (9) <-- Awesome Design
        var level_13_speed = 0.5;
        spawn_orbs (true, room_width/7, level_13_speed, 0, 3);
        spawn_orbs (true, room_width/4, level_13_speed, 90, 3);
        spawn_orbs (true, room_width/2.25, level_13_speed, 75, 3);
        break;
    case 14:    // Overlapping Danger! (7)
        spawn_orbs (true, room_width/7.5, -0.2, 60, 2);
        spawn_orbs (true, room_width/6, 0.5, 30, 4);
        spawn_orbs (true, room_width/2.25, 0.4, 45, 1);
        break;
    case 15:    // Boss Level: Banking on those overlaps (11)
        spawn_orbs (true, room_width/6.5, -0.2, 60, 3);
        spawn_orbs (true, room_width/5, 0.5, 30, 4);
        spawn_orbs (true, room_width/2.5, 0.45, 90, 2);
        spawn_orbs (true, room_width/4, 0.2, 120, 2); 
        break;
    // 4. Stationary and Randoms
    // 5. Random Maps
    // 6. To infinitum, generate random maps with stationary, fixed-orbits, and random movements
    default:
        // This will change to implement the function described in progression stage 6. "To infinitum"
        // For now, this will have to do... for now...
        spawn_orbs (false, room_width/3, 0, 0, 10);
        break;
}

/*
// Spawning Orbs NEW
// Consider spawning with three different methods (the exact one will be selected at random):
//  1. Creating fixed-orbit rings in a setup that is prebuilt by hand
//  2. Creating fixed-orbit rings in a setup that is randomly generated
//  3. Creating randomly orbs (not fixed) in a randomly generated setup
// To implement the above, first we decide on which level generation method we will be using
// Comment: Use at least 2.25 as the denominator of room_width/x; otherwise orbs get close enough to constantly collide against edge of room
var spawning_type = irandom(2);         // Gives a number between 0 ~ 2 (including 2)
//spawning_type = S_FIXED_RANDOM;
switch (spawning_type) {
    case S_FIXED_PREBUILT:  // Fixed orbit rings; prebuilt setups
        // We can have another switch statement here to pick out the prebuilt setup to use OR we can make a new function for that
        var num_prebuilt = 4;                           // Number of pre-built stages
        var fixed_select = irandom(num_prebuilt - 1);   // This makes it easier to access a particular stage in the following switch
        //fixed_select = 4;
        switch (fixed_select) {
            case 0:
                // Alternating Death; Difficulty: Medium
                level_text = "Alternating Death";
                spawn_orbs(true, room_width/7, -0.25, 0, get_orb_pattern(4, VOID_ORB));
                spawn_orbs(true, room_width/3.5, 0.3, 0, get_orb_pattern (4, DEFAULT_ORB, DEAD_ORB));
                spawn_orbs(true, room_width/2.25, -0.4, 0, get_orb_pattern (4, DEFAULT_ORB, DEAD_ORB, DEFAULT_ORB));
                break;
            case 1:  // The Cage; Difficulty: Easy (Relaxing) 
                level_text = "The Cage";
                spawn_orbs(true, room_width/7, 0, 0, get_orb_pattern(8, DEAD_ORB));
                spawn_orbs(true, room_width/5, 0, 22.5, get_orb_pattern(8, DEAD_ORB));
                spawn_orbs(false, room_width/4, 0, 0, get_orb_pattern(5, DEFAULT_ORB, CAPTURED_ORB));
                break;
            case 2: // Carefree Carousel; Difficulty: Medium
                level_text = "Carefree Carousel";
                spawn_orbs(true, room_width/7, -0.25, 0, get_orb_pattern(4, CAPTURED_ORB));
                spawn_orbs(true, room_width/3.5, 0.3, 0, get_orb_pattern (8, DEFAULT_ORB));
                spawn_orbs(true, room_width/2.25, -0.4, 0, get_orb_pattern (12, DEFAULT_ORB));
                break;
            case 3: // The Cage 2.0; Easy but Tedious
                level_text = "The Cage 2.0";
                spawn_orbs(true, room_width/7, 0, 0, get_orb_pattern(7, DEAD_ORB));
                spawn_orbs(true, room_width/4.75, 0, 20, get_orb_pattern(6, DEAD_ORB, DEFAULT_ORB, CAPTURED_ORB));
                spawn_orbs(false, room_width/2.5, 0, 0, get_orb_pattern(4, DEFAULT_ORB, CAPTURED_ORB, CAPTURED_ORB));
                spawn_orbs(false, room_width/2.5, 0, 0, get_orb_pattern(1, MASTER_ORB));
                break;
                /*
            case 4: // Life or Death (aka Flaming Hell); Difficulty: Very Hard
                level_text = "Life or Death";
                spawn_orbs(true, room_width/7, -0.25, 0, get_orb_pattern(8, DEFAULT_ORB, VOID_ORB));
                spawn_orbs(true, room_width/3.5, 0.5, 0, get_orb_pattern (8, VOID_ORB, DEFAULT_ORB));
                spawn_orbs(true, room_width/2.25, -0.5, 0, get_orb_pattern (8, DEFAULT_ORB));
                break;
                */
        /*}
        break;
    case S_FIXED_RANDOM:    // Fixed orbit rings; random setup
        var orbit_lanes = 1 + irandom(S_MAX_LANES); // Find out how many lanes we are going to have; default [1,3]
        var a = irandom(CAPTURED_ORB);
        var b = irandom(CAPTURED_ORB);
        var c = irandom(CAPTURED_ORB);
        var d = irandom(CAPTURED_ORB);
        var e = irandom(CAPTURED_ORB);
        var f = irandom(CAPTURED_ORB);
        
        switch (orbit_lanes) {
        
            case 1: // One lane
                var arr = build_array(DEFAULT_ORB, a,b,c);
                var candidate_inner = build_array(3, a, b, c);
                var type_count = count_type(candidate_inner);
                add_master_fixed(arr, type_count, 4, 9);
                
                spawn_orbs(true, room_width/3, -0.5, 0, get_orb_pattern(3,arr));
                break;
                
            case 2: // Two lanes
                var arr = build_array(DEFAULT_ORB, a,b,c,d);
                
                var candidate_inner = build_array(3, a);
                var candidate_outer = build_array(2, b, c, d);
                var type_count = count_type(candidate_inner, candidate_outer);
                add_master_fixed(arr, type_count, 4, 9);
                
                spawn_orbs(true, room_width/5, -0.5, 0, get_orb_pattern(3, arr[0], arr[1]));
                spawn_orbs(true, room_width/2.5, +0.5, 0, get_orb_pattern(2, DEFAULT_ORB, arr[2], arr[3], arr[4]));
                
                break;
            case 3: // Three lanes
                var arr = build_array(DEFAULT_ORB, a,b,c,d,e,f);
                
                var candidate_near = build_array(2, a, b);
                var candidate_mid = build_array(3, c, d);
                var candidate_far = build_array(4, e, f);
                var type_count = count_type(candidate_near, candidate_mid, candidate_far);
                add_master_fixed(arr, type_count, 4, 18);
                
                spawn_orbs(true, room_width/7, -0.25, 0, get_orb_pattern(2, arr[1], arr[2]));
                spawn_orbs(true, room_width/3.5, 0.5, 0, get_orb_pattern (3, arr[3], arr[4]));
                spawn_orbs(true, room_width/2.25, -0.5, 0, get_orb_pattern (4, arr[0], arr[5], arr[6]));
                break;
        }
        
        break;
    case S_RANDOM:          // Random spawning of orbs   
        var orbit_lanes = irandom(S_MAX_LANES);
        var a = irandom(CAPTURED_ORB);
        var b = irandom(CAPTURED_ORB);
        
        switch (orbit_lanes) {
            case 0: // No lanes of dead orbs
                spawn_orbs(false, room_width/3, 0, 0, get_orb_pattern(1 + irandom(S_MAX_LANES), 
                        DEFAULT_ORB, irandom(DEAD_ORB), irandom(DEAD_ORB), DEFAULT_ORB, DEFAULT_ORB));
                spawn_orbs(false, room_width/2.5, 0, 0, get_orb_pattern(1, a, b));
                
                break;
            case 1: // 1 lane of dead orbs
                spawn_orbs(true, room_width/3.5, 0, 0, get_orb_pattern (10, DEAD_ORB));
                spawn_orbs(false, room_width/6, 0, 0, get_orb_pattern (2 + irandom(S_MAX_LANES), 
                        irandom(DEAD_ORB), a));
                spawn_orbs(false, room_width/2.5, 0, 0, get_orb_pattern(2 + irandom(S_MAX_LANES),
                        DEFAULT_ORB, irandom(DEAD_ORB), irandom(DEAD_ORB)));
                spawn_orbs(false, room_width/7, 0, 0, get_orb_pattern(1, b));
                break;
            case 2: // 2 lanes of dead orbs
                spawn_orbs(true, room_width/5.25, 0, 0, get_orb_pattern (6, DEAD_ORB));
                spawn_orbs(true, room_width/3, 0, 40, get_orb_pattern (3, DEAD_ORB, a));
                spawn_orbs(false, room_width/3.5, 0, 0, get_orb_pattern (2 + irandom(S_MAX_LANES),
                        DEFAULT_ORB, irandom(DEAD_ORB)));
                spawn_orbs(false, room_width/2.5, 0, 0, get_orb_pattern(1, b));
                break;
        }
        
        add_master_random();
        
        break;
}

// Save Layout
save_level();
