///spawn_test_orbs

switch(irandom(3)){
    case 0:
        spawn_orbs(true, room_width/5, -0.25, 0, get_orb_pattern(4, DEFAULT_ORB));
        break;
    case 1:
        spawn_orbs(false, room_width/5, -0.25, 0, get_orb_pattern(4, DEFAULT_ORB));
        break;
    case 2:
        spawn_orbs(true, room_width/7, -0.25, 0, get_orb_pattern(4, DEFAULT_ORB));
        spawn_orbs(true, room_width/4, -0.25, 0, get_orb_pattern(4, DEFAULT_ORB));
        break;
    case 3:
        spawn_orbs(false, room_width/7, -0.25, 0, get_orb_pattern(4, DEFAULT_ORB));
        spawn_orbs(false, room_width/4, -0.25, 0, get_orb_pattern(4, DEFAULT_ORB));
        break;
}
