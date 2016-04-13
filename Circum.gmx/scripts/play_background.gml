if (irandom(50) == 1) {
    var s_engine = audio_play_sound(snd_orb_hit_orb, 1, 0);
    audio_sound_pitch(s_engine, 0.15 * global.scale[irandom(7)]);
}
