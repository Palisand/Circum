/// Generic script for both debug and regular orbs

var orb_obj = argument0;

//bounce off the wall
edge_bounce_circle(orbit_radius);

//bounce off other orbs

with (orb_obj) {
    if (self.id != other.id) { orb_hit_orb(other); }
}

// Fade alpha depending on captured status
if (captured) {
    fill_alpha = lerp(fill_alpha, 1, 0.1);
}
else {
    fill_alpha = lerp(fill_alpha, 0, 0.1);
}
