///count_type(pattern_instr0, pattern_instr1,...)

//a pattern instr tells you how to make a pattern: (Repetitions, type0, type1, type2...)

var ans;
for(var i = 0; i <= CAPTURED_ORB; i++){
    ans[i] = 0;
}

for (var p = 0; p < argument_count; p++) {
    var pattern_instr = argument[p];
    for(var i = 1; i < array_length_1d(pattern_instr); i++){
        var orb_type = pattern_instr[i];
        ans[orb_type] += pattern_instr[0];
    }

}
return ans;
