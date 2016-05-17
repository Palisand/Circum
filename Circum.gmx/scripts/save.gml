/// save()
ini_open("circum_save.ini");

var saved_color = base64_encode(string(global.player_color));
ini_write_string("save","color",saved_color);

var arrow = "false";
if (global.draw_guide_arrow) { arrow="true"; }
ini_write_string("save","arrow",base64_encode(arrow));

var saved_level = base64_encode(string(global.max_level_unlocked));
ini_write_string("save","level",saved_level);

ini_close();
