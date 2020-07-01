use <2D/magnifying_glass_symbol_2D.scad>

// draws a magnifying glass
// parameters:
// text - one character as a string
// size - size of the symbol
// height - height of the symbol (Z axis)
// centerX - if true, center horizontally
// centerY - if true, center vertically
// center - if true, center both horizontally and vertically
// $line_width - width of the drawing line
module magnifying_glass(text="X", size=10 ,height = 1, center=false, centerX=false, centerY=false) {
    
    translate([(center || centerX) ? -size/2: 0, (center || centerY) ? -size/2:0,0]) {
      linear_extrude(height=height)
        magnifying_glass_symbol_2D(text, size);
          
  }
}