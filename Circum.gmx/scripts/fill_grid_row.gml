/// fill_grid_row(grid, row, entry0, entry1, etc.)

var grid = argument[0];
var row = argument[1];

for(var i = 0; i < argument_count-2; i++){
    ds_grid_set(grid, row, i, argument[2+i]);
}
