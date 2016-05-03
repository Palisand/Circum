/// spawn_orbs_level()

/* 
    Progression:
    - Variety before difficulty
    - Generally increasing in density and proximity
*/

var offset = random(360);
switch (global.current_level) {
    case 0: // 3 in a circle [welcome, my friend]
        spawn_orbs(true, 600, 0, offset, 3, 0, 0, 0, 0);
        break;
    case 1: // 1 fixed-orbit [orbs can move; homing makes things easy]
        spawn_orbs(true, 900, 0.5, offset, 1, 0, 0, 0, 0);
        break;
    case 2: // 6 in a tight circle [sometimes tethering isn't necessary if you are patient with your launches]
        spawn_orbs(true, 300, 0, offset, 6, 0, 0, 0, 0);
        break;
    case 3: // 6 in a line [time your tethers to weave between orbs]
        spawn_orbs(true, 250, 0, offset, 2, 0, 0, 0, 0);
        spawn_orbs(true, 500, 0, offset, 2, 0, 0, 0, 0);
        spawn_orbs(true, 750, 0, offset, 2, 0, 0, 0, 0);
        break;
    case 4: // 7 stationary [orbs can vary in radii]
        spawn_orbs(true, 300, 0, offset, 3, 0, 0, 0, build_array(RAD_LARGE, RAD_SMALL, RAD_AVRG));
        spawn_orbs(true, 600, 0, offset - 180, 4, 0, 0, 0, build_array(RAD_LARGE, RAD_SMALL, RAD_SMALL, RAD_AVRG));
        break;
    case 5: // 7 total: 6 in a circle (5 large, 1 small), 1 opposite small [order can matter]
        spawn_orbs(true, 250, 0, offset, 6, 0, 0, 0, build_array(RAD_SMALL, RAD_LARGE, RAD_LARGE, RAD_LARGE, RAD_LARGE, RAD_LARGE, RAD_LARGE));
        spawn_orbs(true, 500, 0, offset - 180, 1, 0, 0, 0, 0);
        break;
    case 6: // 4 total [big start orb, orb motion returns to ease into next level (solar system sans moon)]
        start_orb_size = RAD_LARGE;
        spawn_orbs(true, 250, 1, random(360), 1, 0, 0, 0, 0);
        spawn_orbs(true, 370, 0.5, random(360), 1, 0, 0, 0, 0);
        spawn_orbs(true, 750, 0.2, offset, 1, 0, 0, 0, RAD_AVRG);
        break;
    case 7: // 8 in a spinning spiral [it's all in the finger, apply what you've learned]
        spawn_orbs(true, 200, 0.25, offset, 1, 0, 0, 0, 0);
        spawn_orbs(true, 300, 0.25, offset - 45, 1, 0, 0, 0, 0);
        spawn_orbs(true, 400, 0.25, offset - 90, 1, 0, 0, 0, 0);
        spawn_orbs(true, 500, 0.25, offset - 135, 1, 0, 0, 0, 0);
        spawn_orbs(true, 600, 0.25, offset - 180, 1, 0, 0, 0, 0);
        spawn_orbs(true, 700, 0.25, offset - 225, 1, 0, 0, 0, 0);
        spawn_orbs(true, 800, 0.25, offset - 270, 1, 0, 0, 0, 0);
        spawn_orbs(true, 900, 0.25, offset - 315, 1, 0, 0, 0, 0)
        break;
    case 8: // 5 total [orbs don't always revolve around the center (solar system w/ moon)]
        start_orb_size = RAD_LARGE;
        spawn_orbs(true, 250, 1, random(360), 1, 0, 0, 0, 0);
        spawn_orbs(true, 370, 0.5, random(360), 1, 0, 0, 0, 0);
        spawn_orbs(true, 750, 0.2, offset, 1, 0, 0, 0, RAD_AVRG);
        spawn_orbs(true, 180, 1.2, 0, 1, 750, offset - 180, 0.2, 0);
        break;
    case 9: // 4 random [orbs can move randomly]
        start_orb_fixed = false;
        spawn_orbs(false, 500, 0, random(360), 6, 0, 0, 0, 0);
        break;
    case 10: // 6 random, 3 stationary [use anchors wisely]
        start_orb_size = RAD_AVRG;
        spawn_orbs(true, 600, 0, offset, 3, 0, 0, 0, RAD_AVRG);
        spawn_orbs(false, 300, 0, offset, 6, 0, 0, 0, 0);
        break;
    case 11: // 8 orbs, 2 "trails"
        spawn_orbs(true, 375, 0.5, offset, 2, 0, 0, 0, 0);
        spawn_orbs(true, 750, 0.5, offset, 1, 0, 0, 0, RAD_LARGE);
        spawn_orbs(true, 750, 0.5, offset - 20, 1, 0, 0, 0, RAD_AVRG);
        spawn_orbs(true, 750, 0.5, offset - 40, 1, 0, 0, 0, 0);
        spawn_orbs(true, 750, 0.5, offset - 180, 1, 0, 0, 0, RAD_LARGE);
        spawn_orbs(true, 750, 0.5, offset - 20 - 180, 1, 0, 0, 0, RAD_AVRG);
        spawn_orbs(true, 750, 0.5, offset - 40 - 180, 1, 0, 0, 0, 0);
        break;
    case 12: // 6 fixed-orbit, 4 in a stationary circle (outside)
        spawn_orbs(true, 250, 0.25, offset, 6, 0, 0, 0, 0);
        spawn_orbs(true, 450, 0, offset, 4, 0, 0, 0, 0);
        break;
    case 13: // 14 total in 3 spinning rings
        spawn_orbs(true, 250, 0.75, offset, 2, 0, 0, 0, 0);
        spawn_orbs(true, 500, -0.5, offset, 4, 0, 0, 0, 0);
        spawn_orbs(true, 750, 0.25, offset, 8, 0, 0, 0, 0);
        break;
    case 14: // 12 random with varying sizes [it's a party and everyone's invited]
        start_orb_fixed = false;
        spawn_orbs(false, 250, 0, offset, 3, 0, 0, 0, build_array(RAD_SMALL, RAD_AVRG, RAD_LARGE));
        spawn_orbs(false, 500, 0, offset, 4, 0, 0, 0, build_array(RAD_LARGE, RAD_AVRG, RAD_SMALL));
        spawn_orbs(false, 750, 0, offset, 5, 0, 0, 0, build_array(RAD_SMALL, RAD_AVRG, RAD_LARGE));
        break;
    case 15: // 12 orbs three spiral trails (4 each)
        spawn_orbs(true, 200, 0.5, offset, 3, 0, 0, 0, 0);
        spawn_orbs(true, 400, 0.5, offset + 90, 3, 0, 0, 0, 0);
        spawn_orbs(true, 600, 0.5, offset + 75, 3, 0, 0, 0, 0);
        spawn_orbs(true, 800, 0.5, offset + 60, 3, 0, 0, 0, 0);
        break;
    case 16: // 10 orbs in two orbit clusters (5 each)
        spawn_orbs(true, 600, 0.25, offset, 2, 0, 0, 0, RAD_AVRG);
        spawn_orbs(true, 300, 1, 0, 3, 600, offset, 0.25, 0);
        spawn_orbs(true, 300, 1, 0, 3, 600, offset + 180, 0.25, 0);
        spawn_orbs(true, 150, 2, random(360), 1, 600, offset, 0.25, 0);
        spawn_orbs(true, 150, 2, random(360), 1, 600, offset + 180, 0.25, 0); 
        break;
    case 17: // 13 in tight spinning circles
        spawn_orbs(true, 315, -0.2, offset + 60, 3, 0, 0, 0, 0);
        spawn_orbs(true, 410, 0.5, offset + 30, 4, 0, 0, 0, 0);
        spawn_orbs(true, 512, 0.2, offset + 120, 2, 0, 0, 0, 0); 
        spawn_orbs(true, 610, -0.3, offset + 90, 4, 0, 0, 0, 0);
        break;
    case 18: // 24 in circles (alternating spin) with varying radii
        spawn_orbs(true, 200, 0.3, offset, 3, 0, 0, 0, 0);
        spawn_orbs(true, 330, 0, offset, 6, 0, 0, 0, RAD_AVRG);
        spawn_orbs(true, 460, 0.25, offset, 10, 0, 0, 0, 0);
        spawn_orbs(true, 620, 0, offset, 5, 0, 0, 0, RAD_LARGE);
        break;
    case 19: // 16 random [this party is exclusive]
        start_orb_fixed = false;
        spawn_orbs(false, 600, 0, 0, 16, 0, 0, 0, 0);
        break;
    case 20: // 6 orbs in separate orbit [the calm before the storm]
        spawn_orbs(true, 150, 0.5, random(360), 1, 0, 0, 0, 0);
        spawn_orbs(true, 300, -0.5, random(360), 1, 0, 0, 0, RAD_LARGE);
        spawn_orbs(true, 450, 0.5, random(360), 1, 0, 0, 0, 0);
        spawn_orbs(true, 600, -0.5, random(360), 1, 0, 0, 0, RAD_AVRG);
        spawn_orbs(true, 750, 0.25, random(360), 1, 0, 0, 0, RAD_LARGE);
        spawn_orbs(true, 850, -0.25, random(360), 1, 0, 0, 0, 0);
        break;
    case 21:
        spawn_orbs(true, room_width/9, 0.25, 0, 4, 0, 0, 0, 0);
        spawn_orbs(true, room_width/5.5, 0, 0, 12, 0, 0, 0, 0);
        spawn_orbs(true, room_width/4, 0, 0, 6, 0, 0, 0, 0);
        spawn_orbs(false, room_width/2.5, 0, 0, 4, 0, 0, 0, 0); 
        break;
    default: // random layouts

        var spawning_type = irandom (S_RANDOM);
        //spawning_type = S_FIXED_PREBUILT;
        switch (spawning_type) {
            case S_FIXED_PREBUILT:
                // Feel free to add prebuilt templates in here ?
                
                // Mixing Stationary and Randoms
                // 2 Rings of Stationary & Randoms outside (based on The Cage)
                spawn_orbs(true, room_width/9, 0, irandom(180), 4 + irandom (5), 0, 0, 0, 0);
                spawn_orbs(true, room_width/5, 0, irandom(180), 4 + irandom(5), 0, 0, 0, 0);
                spawn_orbs(false, room_width/3, 0, 0, 2 + irandom (7), 0, 0, 0, 0);
                
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
                        spawn_orbs(true, room_width/rad_div, speed_mod, 0, 3 + irandom (5) , 0, 0, 0, 0);
                        
                        if (rad_div > 5.75) {
                            spawn_orbs(true, room_width/ ( (rad_div / 2.0) - random(0.5)), speed_mod, irandom(180), 3 + irandom (6) , 0, 0, 0, 0);
                        }      
                        else {
                            spawn_orbs(true, room_width/ (rad_div * 1.5 ), -1 * speed_mod, irandom(180), 3 + irandom (6) , 0, 0, 0, 0);
                        }
                        
                        break;
                    case 1:
                        // So we want 3 rings?
                        
                        speed_mod = get_speed_mod();
                        spawn_orbs(true, room_width/7, speed_mod, irandom(180), 3 + irandom(6), 0, 0, 0, 0);
                        speed_mod = get_speed_mod();
                        spawn_orbs(true, room_width/4, speed_mod, irandom(180), 2 + irandom(6), 0, 0, 0, 0);
                        speed_mod = get_speed_mod();
                        spawn_orbs(true, room_width/2.5, speed_mod, irandom(180), 2 + irandom(6), 0, 0, 0, 0);
                               
                        break;
                }
                break;
            case S_RANDOM:
                // There will be a minimum of 6 orbs and a possible max of 20
                var max_orbs = 20;
                var min_orbs = 6;
                spawn_orbs(false, room_width/3, 0, 0, min_orbs, 0, 0, 0, 0);
                spawn_orbs(false, room_width/5, 0, 0, irandom ( max_orbs - min_orbs ), 0, 0, 0, 0);
                break;
        }
        break;
}

/*
    case ?: // too difficult? [gear-fest]
        spawn_orbs(true, 150, 0.75, -22, 4, 0, 0, 0, 0);
        spawn_orbs(true, 200, -0.5, 0, 6, 350, 45, 0, 0);
        spawn_orbs(true, 300, -0.375, 0, 8, 450, 190, 0, 0);
        spawn_orbs(true, 150, 0.75, 0, 4, 600, 15, 0, 0);
        break;
*/
