// Play ricochet sound
//play_ricochet(ricochet_streak, scale)
var ricochet_streak = argument0;
var scale = argument1;

var s_engine = audio_play_sound(snd_ricochet, 0, 0);
// Modify the ricochet sound to reflect the value of ricochet_streak
if (ricochet_streak < 8) {
    audio_sound_pitch(s_engine, scale[ricochet_streak]);
}
else {
    // If ricochet_streak is > 8, return to the bottom of the scale
    audio_sound_pitch(s_engine, scale[ricochet_streak % 8]);
}
