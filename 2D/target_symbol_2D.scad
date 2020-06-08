// draws a target symbol (2D)
// parameters:
// size - size of the symbol
// line_width - width of the drawing line

module target_symbol_2D(size=10, line_width=0.5 ) {
    
    targetFraction = size / 12;
        

   square([size, line_width], center=true);
   square([line_width, size], center=true);

   circle(r=targetFraction);

    difference() {
       circle(r=targetFraction*3);
       translate([0,0,-2]) 
         circle(r=targetFraction*2);
    }   
    
    difference() {
       circle(r=targetFraction*5);
       translate([0,0,-2]) 
         circle( r=targetFraction*4);
    }
   
}
