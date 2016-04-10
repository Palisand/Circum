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
