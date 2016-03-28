// set_to_orbit(orb, to_orb_dir)

var orb = argument0;
// translate into orbit
orbit = argument1;
x = orb.x - cos(degtorad(orbit)) * orb.orbit_radius;
y = orb.y + sin(degtorad(orbit)) * orb.orbit_radius;
// set clockwise or counter-clockwise orbit depending on collision angle
orbit_speed = sign(angle_difference(orbit, direction)) * orbit_speed_set;
if (orbit_speed == 0) {
    orbit_speed = choose(orbit_speed_set, -orbit_speed_set);
}
// start orbiting
speed = 0;
orbiting = true;
current_orb = orb;
