// draws a magnifying glass 2D symbol
// parameters:
// text - one character as a string to be in the glass
// size - size of the symbol
// $line_width - width of the drawing line
module magnifying_glass_symbol_2D(text="X", size=10) {
    include <../common_defaults.scad>
    
    r = size/(1+2*cos(45));
    x = cos(45)/2*(r+$line_width) ;
    f = $line_width*sin(45)/2;
        
    difference() {
       union() { 
          translate([r, size-r]) 
             circle(r= r);
              
          translate([size-x-f, x+f])
             rotate([0,0,45])
                 square([$line_width, r+$line_width], center=true);
          
          
       };
       
       translate([r, size-r]) 
          circle(r=(r-$line_width)); 
    } // difference
    
    translate([r, size-r, 0])
       text(text=text, halign="center", valign="center", size=r, font="Times New Roman"); 
  
}
