///count_type(pattern0, pattern1,...)
var ans;
for(var i = 0; i <= CAPTURED_ORB; i++){
    ans[i] = 0;
}

for (var p = 0; p < argument_count; p++) {
    var pattern = argument[p];
    for(var i = 0; i < array_length_1d(pattern); i++){
        var orb_type = pattern[i];
        ans[orb_type]++;
    }

}
return ans;
