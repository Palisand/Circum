// Play ricochet sound
//play_ricochet(ricochet_streak, scale)
var ricochet_streak = argument0;
var scale = argument1;

var s_engine = audio_play_sound(snd_ricochet, 1, 0);
audio_sound_pitch(s_engine, scale[irandom(7)]);
