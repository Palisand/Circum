/// spawn_orbs_level()

/* 
    Difficulty progression as noted in the guide:
    1.  Stationary
    2.  Stationary and Fixed-Orbit Ring
    3.  Fixed-Orbit Ring
    4.  Stationary and Random
    5.  Random
    
    5 Levels for each difficulty tier increase?
*/
//global.current_level = 27;
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
    case 16:    // Introducing Randoms! (5)
        spawn_orbs (true, room_width/3, 0, 0, 2);
        spawn_orbs (false, room_width/7, 0, 0, 3);
        break;
    case 17:    // 3 stationary & Randoms (7)
        spawn_orbs (true, room_width/5, 0, 60, 1);
        spawn_orbs (true, room_width/4, 0, 180, 1);
        spawn_orbs (true, room_width/3, 0, 300, 1);
        spawn_orbs (false, room_width/2, 0, 0, 4);
        break;
    case 18:    // Final Fantasy, 13? (13)
        spawn_orbs (true, room_width/3, 0, 45, 4);
        spawn_orbs (true, room_width/6, 0, 0, 4);
        spawn_orbs (false, room_width/2, 0, 0, 5);
        break;
    case 19:    // Path of Stars (12)
        spawn_orbs (true, room_width/7, 0, 30, 2);
        spawn_orbs (true, room_width/5, 0, 60, 2);
        spawn_orbs (true, room_width/3, 0, 90, 2);
        spawn_orbs (true, room_width/2.25, 0, 120, 2);
        spawn_orbs (false, room_width/6, 0, 0, 4);
        break;
    case 20:    // Boss Battle!! (14)
        spawn_orbs (true, room_width/7, 0, 40, 2);
        spawn_orbs (true, room_width/5, 0, 80, 2);
        spawn_orbs (true, room_width/3, 0, 120, 4);
        spawn_orbs (true, room_width/2.25, 0, 160, 2);
        spawn_orbs (false, room_width/6, 0, 0, 4);
        break;
    // 5. Random Maps
    case 21:    // Introduce just randoms! (6)
        spawn_orbs (false, room_width/6, 0, 0, 6);
        break;
    case 22:    // More randoms ? (8)
        spawn_orbs (false, room_width/5, 0, 0, 8);
        break;
    case 23:    // More randoms ? (9)
        spawn_orbs (false, room_width/2.5, 0, 0, 10);
        break;
    case 24:    // Pre-Final Boss Battle! (24) 
        spawn_orbs (true, room_width/7, 0.3, 0, 4);
        spawn_orbs (true, room_width/4, 0, 45, 8);
        spawn_orbs (true, room_width/3, -0.3, 0, 4);
        spawn_orbs (true, room_width/2.5, 0, 45, 8);
        break;
    case 25:    // Final Boss Battle!! (24)
        spawn_orbs (true, room_width/9, 0.25, 0, 4);
        spawn_orbs (true, room_width/5.5, 0, 0, 8);
        spawn_orbs (true, room_width/4, 0, 25, 8);
        spawn_orbs (false, room_width/3, 0, 0, 4); 
        break;
    // 6. To infinitum, generate random maps with stationary, fixed-orbits, and random movements
    // Include any prebuilts that you want down below! (Just make a new case statement)
    default:
        // This will change to implement the function described in progression stage 6. "To infinitum"
        // For now, this will have to do... for now...

        var spawning_type = irandom (S_RANDOM);
        //spawning_type = S_FIXED_PREBUILT;
        switch (spawning_type) {
            case S_FIXED_PREBUILT:
                // Feel free to add prebuilt templates in here ?
                
                // Mixing Stationary and Randoms
                // 2 Rings of Stationary & Randoms outside (based on The Cage)
                spawn_orbs (true, room_width/9, 0, irandom(180), 4 + irandom (5));
                spawn_orbs (true, room_width/5, 0, irandom(180), 4 + irandom(5));
                spawn_orbs (false, room_width/3, 0, 0, 2 + irandom (7));
                
                break;
            case S_FIXED_RANDOM:
                // 2 or 3 rings
                var add_rings = irandom (1);
                //add_rings = 1;
                switch (add_rings) {
                    
                    case 0:
                        // So we want 2 rings?
                        
                        // First, make a speed; This should be in a function somewhere...
                        var speed_mod = irandom (40);
                        speed_mod = (speed_mod / 100) + 0.2;    
                        
                        // First Radius: 
                        var rad_div = 5.75 + random (6) - 3;
                        
                        // Generate the rings
                        spawn_orbs (true, room_width/rad_div, speed_mod, 0, 3 + irandom (5) );
                        
                        if (rad_div > 5.75) {
                            spawn_orbs (true, room_width/ ( (rad_div / 2.0) - random(0.5)), speed_mod, irandom(180), 3 + irandom (6) );
                        }      
                        else {
                            spawn_orbs (true, room_width/ (rad_div * 1.5 ), -1 * speed_mod, irandom(180), 3 + irandom (6) );
                        }
                        
                        break;
                    case 1:
                        // So we want 3 rings?
                        
                        // Tons of repeated code, please turn into a function for me ... thx!
                        var speed_mod = irandom (80) - 40;
                        speed_mod = (speed_mod / 100);
                        if (speed_mod > 0){
                            speed_mod += 0.2;
                        }
                        else {
                            speed_mod -= 0.2;
                        }
                        
                        spawn_orbs (true, room_width/7, speed_mod, irandom(180), 3 + irandom(6));
                        
                        speed_mod = irandom (80) - 40;
                        speed_mod = (speed_mod / 100);
                        if (speed_mod > 0){
                            speed_mod += 0.2;
                        }
                        else {
                            speed_mod -= 0.2;
                        }
                        
                        spawn_orbs (true, room_width/4, speed_mod, irandom(180), 2 + irandom(6));
                        
                        speed_mod = irandom (80) - 40;
                        speed_mod = (speed_mod / 100);
                        if (speed_mod > 0){
                            speed_mod += 0.2;
                        }
                        else {
                            speed_mod -= 0.2;
                        }
                        
                        spawn_orbs (true, room_width/2.5, speed_mod, irandom(180), 2 + irandom(6));
                               
                        break;
                }
                break;
            case S_RANDOM:
                // There will be a minimum of 6 orbs and a possible max of 20
                var max_orbs = 20;
                var min_orbs = 6;
                spawn_orbs (false, room_width/3, 0, 0, min_orbs);
                spawn_orbs (false, room_width/5, 0, 0, irandom ( max_orbs - min_orbs ));
                break;
        }
        break;
}
