// draws a battery symbol
// parameters:
// size - size of the battery
// line_width - width of the drawing line
// height - height of the symbol (Z axis)
// centerX - if true, center horizontally
// centerY - if true, center vertically
// center - if true, center both horizontally and vertically
 use <2D/battery_symbol_2D.scad>
 module battery_symbol(size=10, line_width=0.5, height = 1, center=false, centerX=false, centerY=false) {
 
    translate([centerX || center ? 0: size/2, center || centerY ? 0 : size/2]) 
      linear_extrude(height=height)
        battery_symbol_2D(size=size, line_width = line_width);  
 }

battery_symbol(centerX=true);