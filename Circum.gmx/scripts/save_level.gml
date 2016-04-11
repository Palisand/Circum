var index = 0;
with (o_orb) {
    global.orb_layout[index, ORB.x] = x;
    global.orb_layout[index, ORB.y] = y;
    global.orb_layout[index, ORB.type] = type;
    global.orb_layout[index, ORB.fixed] = fixed;
    global.orb_layout[index, ORB.fixed_orbit] = fixed_orbit;
    global.orb_layout[index, ORB.fixed_orbit_speed] = fixed_orbit_speed;
    global.orb_layout[index, ORB.fixed_orbit_radius] = fixed_orbit_radius;
    global.orb_layout[index, ORB.captured] = captured;
    index++;
}
global.num_orb = index;
