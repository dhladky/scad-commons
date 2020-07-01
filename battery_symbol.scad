use <2D/battery_symbol_2D.scad>

// draws a battery symbol
// parameters:
// size - size of the battery
// height - height of the symbol (Z axis)
// centerX - if true, center horizontally
// centerY - if true, center vertically
// center - if true, center both horizontally and vertically
// $line_width - width of the drawing line
 module battery_symbol(size=10, height = 1, center=false, centerX=false, centerY=false) {
     translate([centerX || center ? 0: size/2, center || centerY ? 0 : size/2]) 
      linear_extrude(height=height)
        battery_symbol_2D(size=size);  
 }