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
        var num_prebuilt = 4;                           // Number of pre-built stages
        var fixed_select = irandom(num_prebuilt - 1);   // This makes it easier to access a particular stage in the following switch
        //fixed_select = 1;
        switch (fixed_select) {
            case 0:
                // This level is actually REALLY hard - Alternating Death; Cleansed by Fire
                spawn_orbs(true, room_width/7, -0.25, 0, get_orb_pattern(4, VOID_ORB));
                spawn_orbs(true, room_width/3.5, 0.5, 0, get_orb_pattern (4, DEFAULT_ORB, DEAD_ORB));
                spawn_orbs(true, room_width/2.25, -0.5, 0, get_orb_pattern (4, DEFAULT_ORB, DEAD_ORB, DEFAULT_ORB));
                break;
            case 1:  // The Cage
                spawn_orbs(true, room_width/7, 0, 0, get_orb_pattern(8, DEAD_ORB));
                spawn_orbs(true, room_width/5, 0, 22.5, get_orb_pattern(8, DEAD_ORB));
                spawn_orbs(false, room_width/4, 0, 0, get_orb_pattern(5, DEFAULT_ORB, CAPTURED_ORB));
                break;
            case 2: // Life or Death
                spawn_orbs(true, room_width/7, -0.25, 0, get_orb_pattern(8, DEFAULT_ORB, VOID_ORB));
                spawn_orbs(true, room_width/3.5, 0.5, 0, get_orb_pattern (8, VOID_ORB, DEFAULT_ORB));
                spawn_orbs(true, room_width/2.25, -0.5, 0, get_orb_pattern (8, DEFAULT_ORB));
                break;
            case 3: // Carefree Carousel
                spawn_orbs(true, room_width/7, -0.25, 0, get_orb_pattern(4, CAPTURED_ORB));
                spawn_orbs(true, room_width/3.5, 0.5, 0, get_orb_pattern (8, DEFAULT_ORB));
                spawn_orbs(true, room_width/2.25, -0.5, 0, get_orb_pattern (12, DEFAULT_ORB));
                break;
        }
        break;
    case S_FIXED_RANDOM:    // Fixed orbit rings; random setup
        var orbit_lanes = 1 + irandom(S_MAX_LANES); // Find out how many lanes we are going to have; default [1,3]
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
                    DEFAULT_ORB, irandom(DEAD_ORB), irandom(DEAD_ORB), irandom(VOID_ORB), irandom(VOID_ORB)));
        spawn_orbs(false, room_width/2.5, 0, 0, get_orb_pattern(1, irandom(MASTER_ORB), irandom(MASTER_ORB)));
        break;
}

// Save Layout
var index = 0;
with (o_orb) {
    global.orb_layout[index, 0] = x;
    global.orb_layout[index, 1] = y;
    global.orb_layout[index, 2] = type;
    global.orb_layout[index, 3] = fixed;
    global.orb_layout[index, 4] = fixed_orbit;
    global.orb_layout[index, 5] = fixed_orbit_speed;
    global.orb_layout[index, 6] = fixed_orbit_radius;
    index++;
}
global.num_orb = index;
