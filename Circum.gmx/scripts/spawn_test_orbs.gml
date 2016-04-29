///spawn_test_orbs()

switch(irandom(1)) {
    case 0:
        spawn_orbs(true, 200, 1, 0, 3, 600, 0, 0.5);
        spawn_orbs(true, 200, 1, 0, 3, 600, 180, 0.5);
        spawn_orbs(true, 600, 0.5, 0, 2, 0, 0, 0);
        break;
    case 1:
        spawn_orbs(true, 300, 1, 0, 5, 600, 0, 0);
        spawn_orbs(true, 300, -1, 0, 5, 600, 90, 0);
        spawn_orbs(true, 300, 1, 0, 5, 600, 180, 0);
        spawn_orbs(true, 300, -1, 0, 5, 600, 270, 0);
        break;
}
