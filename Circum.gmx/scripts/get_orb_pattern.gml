/// get_orb_pattern(repetitions, orb_types...);
    
var orb_pattern;
var index = 0;
repeat (argument[0]) {
    for (var i = 1; i < argument_count; i++) {
        orb_pattern[index++] = argument[i];
    }
}

return orb_pattern;
