/// get_orb_pattern(repetitions, orb_type1, orb_type2, etc.);
/// get_orb_pattern(repetitions, [orb_type1, orb_type2, etc.]);

//returns an array of orb types in the order they are passed in
//the orb pattern repeats R times, where R is argument0

var orb_pattern;
var index = 0;
repeat (argument[0]) {
    if (is_array(argument[1])) {
        var pattern = argument[1];
        for (var i = 0; i < array_length_1d(pattern); i++) {
            orb_pattern[index++] = pattern[i];
        }   
    }
    else {
        for (var i = 1; i < argument_count; i++) {
            orb_pattern[index++] = argument[i];
        }
    }
}

return orb_pattern;
