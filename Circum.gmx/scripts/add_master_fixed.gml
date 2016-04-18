///add_master_fixed(pattern_template, type_count, void_threshold, locked_threshold, num_orbs)

var pattern_template = argument0;
var type_count = argument1;
var void_threshold = argument2;
var locked_threshold = argument3;
var num_orbs = argument4;

if (type_count[CAPTURED_ORB] > locked_threshold) {
    if (type_count[CAPTURED_ORB] == num_orbs) { pattern_template[@0] = MASTER_ORB; }
    else {
        for (var i = 1; i < array_length_1d(pattern_template); i++) {
            if (pattern_template[i] != CAPTURED_ORB){
                pattern_template[@i] = MASTER_ORB;
                break;
            }
        }
    }
}
else if (type_count[VOID_ORB] > void_threshold) {
    if (type_count[VOID_ORB] == num_orbs) { pattern_template[@1] = MASTER_ORB; }
    else {
        for (var i = 1; i < array_length_1d(pattern_template); i++) {
            if (pattern_template[i] != VOID_ORB) {
                pattern_template[@i] = MASTER_ORB;
                break;
            }
        }
    }
}
