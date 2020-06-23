// draws a battery symbol (2D)
// parameters:
// size - size of the battery
// line_width - width of the drawing line
 module battery_symbol_2D(size=10, line_width=0.5) {
    
    sizeX = size*6/10; 
    translate([-sizeX/2, -size/2]) { 
     
    
     difference() {
         square([sizeX, size*9/10]);
         translate([line_width,line_width,-1])
            square([sizeX-2*line_width, size*9/10-2*line_width]);
     }
          
     noseWidth = sizeX/5*1.8;
     noseHeight = size/10;
          
     translate([(sizeX-noseWidth)/2, size*9/10])
     difference() {
         translate([0, 0.001])
            square([noseWidth, noseHeight+0.001]);

         translate([line_width,-line_width])
            square([noseWidth-2*line_width, noseHeight]);
     }
     
     // painting flash
     ySegment = size*9/10/4;
     xSegment = sizeX / 3;
     
     polygon(points=[
        [1.5*xSegment, 3*ySegment], //0
        [xSegment-line_width/2, 2*ySegment-line_width/2], //1 
        [2*xSegment-line_width, 2*ySegment-line_width/2], // 2
        [sizeX-1.5*xSegment, ySegment],  // 3
        [2*xSegment+line_width/2, 2*ySegment+line_width/2], // 4
        [xSegment+line_width, 2*ySegment+line_width/2]]); // 5
     
 }
  
 }

