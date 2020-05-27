// draws a dice symbol
// parameters:
// size - size of the dice (same in X and Y coordinates)
// line_width - thickness of the line to be drawn
// height - height of the picture
// center - if true, center the symbol around the origin (z axis ignored)
// centerX - if true, center the symbol around Y axis
// centerY - if true, center the symbol around X axis
module dice_symbol(size=10, line_width=0.2 ,height = 1, center=false, centerX=false, centerY=false) {
    s=4*size/(4+sqrt(2));
    w=size;
    half_line_width = line_width/2;

    y=2*line_width/sqrt(2);
    z = line_width / tan(67.5);
    
    points = [
              // front outer 0-3 
              [0,0],[0,s],[s,s],[s,0], 
              // top outer 4-5
              [w-s, w], [w,w], 
              // side bottom 6
              [w, w-s],
              // front inner 7-10
              [line_width,line_width],[line_width,s-half_line_width],[s-half_line_width,s-half_line_width],[s-half_line_width,line_width],  
              // top inner 11-14
              [half_line_width+y,s+half_line_width], [w-s+z, w-line_width], [w-y,w-line_width], [s-z,s+half_line_width],
              // side inner 15-18
              [s+half_line_width, half_line_width+y],[s+half_line_width, s-z],[w-line_width, w-y-half_line_width],[w-line_width, w-s+z] 
    
    
    ];
    
    translate([(center || centerX) ? -size/2 : 0, (center || centerY) ? -size/2 : 0, 0])
      linear_extrude(height=height)         
         polygon(points=points, paths=[[0, 1, 4, 5, 6, 3], [7, 8, 9, 10], [11, 12, 13,14],[15,16,17,18]]);
    
    
}
