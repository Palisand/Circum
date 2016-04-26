// play_win()

var snd_win_chosen;

do {
    snd_win_chosen = choose(snd_win, snd_win_2, snd_win_3);
} until (global.prev_snd_win != snd_win_chosen);

global.prev_snd_win = snd_win_chosen;
audio_play_sound(snd_win_chosen, 0, 0);
