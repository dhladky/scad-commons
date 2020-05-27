// draws a magnifying glass
// parameters:
// text - one character as a string
// size - size of the symbol
// line_width - width of the drawing line
// height - height of the symbol (Z axis)
// centerX - if true, center horizontally
// centerY - if true, center vertically
// center - if true, center both horizontally and vertically
module magnifying_glass(text="X", size=10, line_width=0.5 ,height = 1, center=false, centerX=false, centerY=false) {
    
    r = size/(1+2*cos(45));
    x = cos(45)/2*(r+line_width) ;
    f = line_width*sin(45)/2;
    
    translate([(center || centerX) ? -size/2: 0, (center || centerY) ? -size/2:0,0]) {
        difference() {
           union() { 
              translate([r, size-r, 0]) 
                 cylinder(h=height, r= r);
                  
              translate([size-x-f, x+f,height/2])
                 rotate([0,0,45])
                     cube([line_width, r+line_width, height], center=true);
              
              
           };
           
           translate([r, size-r, -1]) 
              cylinder(h=height+2, r=(r-line_width)); 
        } // difference
        
        translate([r, size-r, 0])
        linear_extrude(height=height)
           text(text=text, halign="center", valign="center", size=r, font="Times New Roman"); 
  }
}

magnifying_glass();