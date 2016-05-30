/// load()
ini_open("circum_save.ini");

var default_color = base64_encode(string(c_lime));
var saved_color = ini_read_string("save","color",default_color);
var read_color = base64_decode(saved_color);
global.player_color = floor(real(read_color));

var default_arrow = base64_encode("true");
var saved_arrow = ini_read_string("save","arrow",default_arrow);
var read_arrow = base64_decode(saved_arrow);
global.draw_guide_arrow = true;
if (read_arrow == "false") { global.draw_guide_arrow = false; }

var default_level = base64_encode("0");
var saved_level = ini_read_string("save","level",default_level);
var read_level = base64_decode(saved_level);
global.max_level_unlocked = floor(real(read_level));

//somebody tampered with the save file, resulting in invalid parameters
if (!appears(global.player_color,c_lime,c_yellow,c_fuchsia,c_aqua)) {
    global.player_color = c_lime;
}
if (global.max_level_unlocked < 0 || global.max_level_unlocked > global.max_level) {
    global.max_level_unlocked = 0;
}

ini_close();
