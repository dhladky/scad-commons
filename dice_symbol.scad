use <2D/dice_symbol_2D.scad>    

// draws a dice symbol
// parameters:
// size - size of the dice (same in X and Y coordinates)
// height - height of the picture
// center - if true, center the symbol around the origin (z axis ignored)
// centerX - if true, center the symbol around Y axis
// centerY - if true, center the symbol around X axis
// $line_width - thickness of the line to be drawn
module dice_symbol(size=10 ,height = 1, center=false, centerX=false, centerY=false) {
    translate([(center || centerX) ? -size/2 : 0, (center || centerY) ? -size/2 : 0, 0])
      linear_extrude(height=height)         
         dice_symbol_2D(size);
}