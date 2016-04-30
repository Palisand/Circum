///spawn_test_orbs()

switch(irandom(3)) {
    case 0:
        spawn_orbs(true, 200, 1, 0, 3, 600, 0, 0.5, 0);
        spawn_orbs(true, 200, 1, 0, 3, 600, 180, 0.5, 0);
        spawn_orbs(true, 600, 0.5, 0, 2, 0, 0, 0, 0);
        break;
    case 1:
        spawn_orbs(true, 300, 1, 0, 5, 600, 0, 0, 0);
        spawn_orbs(true, 300, -1, 0, 5, 600, 90, 0, 0);
        spawn_orbs(true, 300, 1, 0, 5, 600, 180, 0, 0);
        spawn_orbs(true, 300, -1, 0, 5, 600, 270, 0, 0);
        break;
    case 2:
        spawn_orbs(true, 500, 0.2, 0, 6, 0, 0, 0, build_array(RAD_SMALL, RAD_AVRG, RAD_LARGE));
        break;
    case 3:
        spawn_orbs(false, 500, 0, 0, 9, 0, 0, 0, build_array(RAD_SMALL, RAD_AVRG, RAD_LARGE));
        break;
}
