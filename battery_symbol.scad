// draws a battery symbol
// parameters:
// size - size of the battery
// line_width - width of the drawing line
// height - height of the symbol (Z axis)
// centerX - if true, center horizontally
// centerY - if true, center vertically
// center - if true, center both horizontally and vertically
 module battery_symbol(size=10, line_width=0.5, height = 1, center=false, centerX=false, centerY=false) {
    
    sizeX = size*6/10; 
    translate([centerX || center ? -sizeX/2: (size-sizeX)/2, center || centerY ? -size/2 : 0,0]) { 
     
    
     difference() {
         cube([sizeX, size*9/10, height]);
         translate([line_width,line_width,-1])
            cube([sizeX-2*line_width, size*9/10-2*line_width, height+2]);
     }
     
     
     noseWidth = sizeX/5*1.5;
     
     translate([(sizeX-noseWidth)/2, size*9/10-line_width+0.001, 0])
     difference() {
         cube([noseWidth, size/10-0.001, height]);
         translate([line_width,line_width,-1])
            cube([noseWidth-2*line_width, size/10-2*line_width, height+2]);
     }
     
     // painting flash
     ySegment = size*9/10/4;
     xSegment = sizeX / 3;
     
     
     linear_extrude(height=height)
     polygon(points=[
        [1.5*xSegment, 3*ySegment], //0
        [xSegment-line_width/2, 2*ySegment-line_width/2], //1 
        [2*xSegment-line_width, 2*ySegment-line_width/2], // 2
        [sizeX-1.5*xSegment, ySegment],  // 3
        [2*xSegment+line_width/2, 2*ySegment+line_width/2], // 4
        [xSegment+line_width, 2*ySegment+line_width/2]]); // 5
     
 }
  
 }
 