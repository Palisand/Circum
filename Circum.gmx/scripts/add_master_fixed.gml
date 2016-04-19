///add_master_fixed(pattern_template, type_count, threshold, num_orbs)

var pattern_template = argument0;
var type_count = argument1;
var threshold = argument2;

//number of orbs EXCEPT for those at the "head" of a pattern
//e.g. "3xDEFAULT, 3xVOID, 2xVOID, 2xLOCKED" has a DEFAULT head
//there are 3+2+2 = 7 "relevant" orbs (ones that we'll check the type of)
var num_relevant = argument3;

var num_void = type_count[VOID_ORB];
var num_locked = type_count[CAPTURED_ORB];

if (num_void + num_locked > threshold) {
    
    //unlucky case: everything locked -> make the head orb master
    if (num_locked == num_relevant) { pattern_template[@0] = MASTER_ORB; }
    
    //unlucky case: everything void -> make the second orb master
    //not first orb because then you'd win automatically
    else if (num_void == num_relevant) { pattern_template[@1] = MASTER_ORB; }
    
    //unlucky case: everything but first orb is either locked or void
    else if (num_void + num_locked == num_relevant) { pattern_template[@0] = MASTER_ORB; }
    
    //so-so case
    else {
        //Change a dead or default orb into master
        //But not the first because we want at least one default per ring
        for (var i = 1; i < array_length_1d(pattern_template); i++) {
            if (pattern_template[i] < VOID_ORB){
                pattern_template[@i] = MASTER_ORB;
                break;
            }
        }
    }
}

