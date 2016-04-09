///draw_trail(length,width,color,sprite,slim,alpha)
//Ex. draw_trail(32,32,c_white,-1,1,1)
var Length,Width,Color,Sprite,Slim,Alpha,AlphaT,Texture,Dir,Min,Height;
//Preparing variables
Length = argument0; //How many previous coordinates will use the trail
Width = argument1; //How wide will the trail be
Color = argument2; //Which color will be used to tint the trail
Sprite = argument3; //Which sprite's texture must be used for the trail. Must have "Used for 3D" marked. -1 for no sprite 
Slim = argument4; //Whether the trail will slim down at the end
Alpha = argument5; //The alpha to draw the trail with (0-1), optional

ArrayTrail[0,0] = x;
ArrayTrail[0,1] = y;
Height = array_height_2d(ArrayTrail);
//Getting distance between current and past coordinates
if (Height > 1) ArrayTrail[0,2] = point_distance(ArrayTrail[0,0],ArrayTrail[0,1],ArrayTrail[1,0],ArrayTrail[1,1]) + ArrayTrail[1,2];
else ArrayTrail[0,2] = 0;

AlphaT = 1;
Dir = 0;
Min = min(Height - 1,Length);

if (ricochet_time < trail_length) { ricochet_time++; }

//if the orb is moving on a fixed path, cannot rely on default code
if ((orbiting || tethered)
    && current_orb.fixed
    && current_orb.fixed_orbit_speed != 0
    ) {
    
    trail_id[0] = latch_time;
    
    //get relevant parameters of the orb and player
    var ox = current_orb.x;
    var oy = current_orb.y;    
    var orad = current_orb.orbit_radius;
    if (tethered) { orad = tether_radius; }
    
    //account for orb movement, for the points that have left the ricochet point
    var end_loop = min(Min,ricochet_time);
    for(var i = 0; i < end_loop; i++){
        var newX, newY;
        
        if (i > 0 && trail_id[i] != latch_time) {
            //the previous point pulls this one closer (scale down the distance)
            newX = ArrayTrail[i-1,0] + 0.7*(ArrayTrail[i,0] - ArrayTrail[i-1,0]);
            newY = ArrayTrail[i-1,1] + 0.7*(ArrayTrail[i,1] - ArrayTrail[i-1,1]);
            //check if orbit/tether radius has been reached
            if (point_distance(newX,newY,ox,oy) == orad) { trail_id[i] = latch_time; }
        }
        
        else {
            //calculate based on player's angular location
            var angle = orbit-i*orbit_speed;
            
            newX = ox - orad*dcos(angle);
            
            newY = oy + orad*dsin(angle);
            
        }
        
        ArrayTrail[i,0] = newX;
        ArrayTrail[i,1] = newY;
    }
}

else {
    trail_id[0] = -1;
}

//draw the player here
draw_circle(ArrayTrail[0,0],ArrayTrail[0,1], draw_radius, false);

//Setting the texture
if (Sprite >= 0) Texture = sprite_get_texture(Sprite,0);
else Texture = -1;
texture_set_repeat(1);

//draw the trail
draw_primitive_begin_texture(pr_trianglestrip,Texture);
for(var i = 0; i < Min; i++){
    if (ArrayTrail[i,0] != ArrayTrail[i+1,0] || ArrayTrail[i,1] != ArrayTrail[i+1,1])
      Dir = point_direction(ArrayTrail[i,0],ArrayTrail[i,1],ArrayTrail[i+1,0],ArrayTrail[i+1,1]);
    var Len = Width / 2 - ((i + 1) / Min * Width / 2) * Slim;
    var XX = lengthdir_x(Len,Dir + 90); 
    var YY = lengthdir_y(Len,Dir + 90);
    AlphaT = (Min - i) / (Min / 2) * Alpha;
    draw_vertex_texture_color(ArrayTrail[i,0] + XX,ArrayTrail[i,1] + YY,ArrayTrail[i,2] / Width,0,Color,AlphaT);
    draw_vertex_texture_color(ArrayTrail[i,0] - XX,ArrayTrail[i,1] - YY,ArrayTrail[i,2] / Width,1,Color,AlphaT);
}
draw_primitive_end();

//Replacing the coordinates positions within the array
Min = min(Height,Length);
for (var i = Min; i > 0; i--){
    ArrayTrail[i,0] = ArrayTrail[i - 1,0];
    ArrayTrail[i,1] = ArrayTrail[i - 1,1];
    ArrayTrail[i,2] = ArrayTrail[i - 1,2];
    trail_id[i] = trail_id[i-1];
}
