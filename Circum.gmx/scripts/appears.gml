/// appears(val, candidate0, candidate1, candidate2...)
//returns whether the first argument appears in the remainder of the arguments

var v = argument[0];

for(var i = 1; i < argument_count; i++){
    if (v == argument[i]) { return true; }
}
