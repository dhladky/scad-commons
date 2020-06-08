// draws a target symbol
// parameters:
// size - size of the symbol
// line_width - width of the drawing line
// height - height of the symbol (Z axis)
// centerX - if true, center horizontally
// centerY - if true, center vertically
// center - if true, center both horizontally and vertically
module target_symbol(size=10, line_width=0.5 ,height = 1, center=false, centerX=false, centerY=false) {
    
    targetFraction = size / 12;
        
    translate([center||centerX ? 0 : size/2 , center || centerY ? 0 : size/2, height/2]) {
       cube([size, line_width, height], center=true);
       cube([line_width, size, height], center=true);

        cylinder(h=height, r=targetFraction, center=true);
    
        difference() {
           cylinder(h=height, r=targetFraction*3, center=true);
           translate([0,0,-2]) 
             cylinder(h=height+4, r=targetFraction*2, center=true);
        }   
        
        difference() {
           cylinder(h=height, r=targetFraction*5, center=true);
           translate([0,0,-2]) 
             cylinder(h=height+4, r=targetFraction*4, center=true);
        }
   }
}

target_symbol(center=true);