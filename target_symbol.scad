use <2D/target_symbol_2D.scad>

// draws a target symbol
// parameters:
// size - size of the symbol
// height - height of the symbol (Z axis)
// centerX - if true, center horizontally
// centerY - if true, center vertically
// center - if true, center both horizontally and vertically
// $line_width - width of the drawing line
module target_symbol(size=10, height = 1, center=false, centerX=false, centerY=false) {
      
    translate([center||centerX ? 0 : size/2 , center || centerY ? 0 : size/2, height/2]) {
      linear_extrude(height=height)  
        target_symbol_2D(size);
   }
}

target_symbol(center=true);