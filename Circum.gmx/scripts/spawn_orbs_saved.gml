/// spawn_orbs_saved()

// spawn orbs using global.orb_layout array
for (var i = 0; i < global.num_orb; i++) {
    var orb = instance_create(global.orb_layout[i, ORB.x], global.orb_layout[i, ORB.y], o_orb);
    if (global.orb_layout[i, ORB.captured]) {
        set_orb_type(orb, CAPTURED_ORB);
    }
    else {
        set_orb_type(orb, global.orb_layout[i, ORB.type]);
    }
    if (global.orb_layout[i, ORB.fixed]) {
        orb.fixed = true;
        orb.fixed_orbit = global.orb_layout[i, ORB.fixed_orbit];
        orb.fixed_orbit_speed = global.orb_layout[i, ORB.fixed_orbit_speed];
        orb.fixed_orbit_radius = global.orb_layout[i, ORB.fixed_orbit_radius];
    }
}
