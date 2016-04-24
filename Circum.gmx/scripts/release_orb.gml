var orb = argument0;
var orad = argument1;
var to_orb_dir = argument2;

ricochet_off_orb(orb,orad);
collision_hit_burst(
    x, y, to_orb_dir - 180 - 90, to_orb_dir - 180 + 90,
    orb.color, 300, 60, orb.p_emitter, orb.p_type
);
capture_streak = 0;  // reset capture streak

// Visuals
room_speed = 30;
with (instance_create(orb.x, orb.y, o_release_effect)) {
    color = orb.color;
    orb_follow = orb.id;
}
instance_create(x, y, o_shockwave);

// Reset orb
if (orb.capturer == self.id) { num_orb_captured--; }
orb.captured = false;
orb.capturer = -1;
orb.color = c_white;
audio_sound_pitch(audio_play_sound(snd_release, 0, 0), 2/3);
