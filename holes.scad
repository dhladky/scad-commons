// common variables
// $line_width = height/depth of the picture engraving (default 0.5 mm)

// holes specific variables
// $holes_bottom_part_top - bottom part of the box - top part - must be defined
// $holes_bottom_thickness - thickness of bottom (default 2 mm)
// $holes_bottom_top_overlap - the holes in the bottom part will overlap the bottom part by this value (default 1 mm)
// $holes_finger_hole_radius - finger hole radius (default 5 mm)
// $holes_finger_hole_extend - the length of the finger hole on each side of the hole (default 5 mm)
// $holes_finger_additional_depth - bury the finger hole by this value more (default 0 mm)

// A single hole in the organizer
// parameters:
// position : X,Y position of the hole in X,Y axis
// size - size of the hole (X, Y axis)
// depth - optional depth - if used, the hole will have this depth. 
//    bottom_thickness argument will be ignored if depth is used
// bottom_thickness - if depth is not used, the depth of the hole will be calculated for the bottom be this thick
// centerX - if true, center horizontally
// centerY - if true, center vertically
// center - if true, center both horizontally and vertically

module simple_hole(position=[0,0], size, depth=-1, center=false, centerX=false, centerY=false) {

    include <holes_default_parameters.scad>
    
    assert(depth < $holes_bottom_part_top, "depth must be smaller then $holes_bottom_part_top");  
    assert(depth==-1 || depth>0, "depth must be positive or not defined");
    assert(len(size)==2, "size should be defined as [sizeX, sizeY]");
    
    hole_bottom = (depth==-1) ? $holes_bottom_thickness : $holes_bottom_part_top - depth;

    cornerX = min([size[0]/3, 15]); // 5 mm or eight of the hole
    cornerY = min([size[1]/3, 15]); // 5 mm or eight of the hole
    cornerZ = hole_bottom+min([($holes_bottom_part_top-hole_bottom)/8, 5]); // 5 mm or eight of the hole
 
    points=[
       // bottom
       [cornerX, 0, hole_bottom], // 0
       [size[0]-cornerX, 0, hole_bottom], // 1
       [size[0], cornerY, hole_bottom], // 2
       [size[0], size[1]-cornerY, hole_bottom], // 3 
       [size[0]-cornerX, size[1], hole_bottom], // 4 
       [cornerX, size[1], hole_bottom], // 5
       [0, size[1]-cornerY, hole_bottom], // 6
       [0, cornerY, hole_bottom], // 7
       // corner layer 
       [0, 0, cornerZ], // 8
       [size[0], 0, cornerZ], // 9
       [size[0], size[1], cornerZ], // 10    
       [0, size[1], cornerZ], // 11   
       // top
       [0, 0, $holes_bottom_part_top+$holes_bottom_top_overlap], // 12
       [size[0], 0, $holes_bottom_part_top+$holes_bottom_top_overlap], // 13
       [size[0], size[1], $holes_bottom_part_top+$holes_bottom_top_overlap], // 14    
       [0, size[1], $holes_bottom_part_top+$holes_bottom_top_overlap] // 15   
    ];
    
    
    translate([center||centerX ? -size[0]/2+position[0] : position[0], center||centerY?position[1]-size[1]/2:position[1], 0])
      polyhedron(points=points, 
       faces=[
           [0,1,2,3,4,5,6,7], // bottom
           [0, 7, 8], [1,9,2], [3,10,4], [5,11,6], // side triangles
           // sides
           [0, 8, 12, 13, 9, 1],
           [2, 9, 13, 14, 10, 3],
           [5, 4, 10, 14, 15, 11],
           [15, 12, 8, 7, 6, 11],
           // top
           [12, 15, 14, 13]
          ]
      );
}



// A rectangular hole in the organizer with a picture and adjusted bottom. A centered 2D
// object(s) may be enclosed in the call so it will become 
// rendered on the bottom of the hole. Based on bury parameter 
// the picture will be buried in the box (true) or go up in the hole by $line_width.
//
// 
// parameters:
// position : X,Y position of the hole in X,Y axis
// size - size of the hole (X, Y axis)
// depth - optional depth - if used, the hole will have this depth. 
//    $holes_bottom_thickness variable will be ignored if depth is used
// bury - true by default. If false, the picture will be rendered upwards
// $holes_bottom_top_overlap - extend the hole above the 'top' so that diffs work properly by this value
// centerX - if true, center horizontally
// centerY - if true, center vertically
// center - if true, center both horizontally and vertically

module hole(position=[0,0], size, depth=-1,  bury=true, center=false, centerX=false, centerY=false) {
    
    include <holes_default_parameters.scad>
        
    hole_bottom = (depth==-1) ? $holes_bottom_thickness : $holes_bottom_part_top - depth;

    if(bury) {
      simple_hole(position, size, depth,  center, centerX, centerY);
    
      translate([center||centerX ? position[0] : size[0]/2+position[0], center||centerY?position[1]:position[1]+size[1]/2, hole_bottom-$line_width])  
         linear_extrude(height=$line_width+0.01)  
            children();
    } else {
        difference() {
          simple_hole(position, size, depth, center, centerX, centerY);
            
          translate([center||centerX ? position[0] : size[0]/2+position[0], center||centerY?position[1]:position[1]+size[1]/2, hole_bottom-0.01])
                linear_extrude(height=$line_width+0.01)  
                    children();
        }
    }
    
}


// A cubic hole in the organizer with a picture. Unlike "hole" it is pure cube with flat bottom. A centered 2D
// object(s) may be enclosed in the call so it will become 
// rendered on the bottom of the hole. Based on bury parameter 
// the picture will be buried in the box (true) or go up in the hole by $line_width.
//
// 
// parameters:
// position : X,Y position of the hole in X,Y axis
// size - size of the hole (X, Y axis)
// depth - optional depth - if used, the hole will have this depth. 
//    $holes_bottom_thickness variable will be ignored if depth is used
// bury - true by default. If false, the picture will be rendered upwards
// $holes_bottom_top_overlap - extend the hole above the 'top' so that diffs work properly by this value
// centerX - if true, center horizontally
// centerY - if true, center vertically
// center - if true, center both horizontally and vertically

module cubic_hole(position=[0,0], size, depth=-1,  bury=true, center=false, centerX=false, centerY=false) {
    
    include <holes_default_parameters.scad>
        
    hole_bottom = (depth==-1) ? $holes_bottom_thickness : $holes_bottom_part_top - depth;

    if(bury) {      
    translate([center || centerX ? position[0]-size[0]/2:position[0], center || centerY ? position[1]-size[1]/2:position[1], hole_bottom])    
      cube([size[0], size[1], $holes_bottom_part_top-hole_bottom+$holes_bottom_top_overlap]);
        
          
      translate([center||centerX ? position[0] : size[0]/2+position[0], center||centerY?position[1]:position[1]+size[1]/2, hole_bottom-$line_width])  
         linear_extrude(height=$line_width+0.01)  
            children();
    } else {
        difference() {
            translate([center || centerX ? position[0]-size[0]/2:position[0], center || centerY ? position[1]-size[1]/2:position[1], hole_bottom])    
                  cube([size[0], size[1], $holes_bottom_part_top-hole_bottom+$holes_bottom_top_overlap]);            
          translate([center||centerX ? position[0] : size[0]/2+position[0], center||centerY?position[1]:position[1]+size[1]/2, hole_bottom-0.01])
                linear_extrude(height=$line_width+0.01)  
                    children();
        }
    }
    
}


// A cubic hole in the organizer with a picture and space to put finers when drawing tokens. A centered 2D
// object(s) may be enclosed in the call so it will become 
// rendered on the bottom of the hole. Based on bury parameter 
// the picture will be buried in the box (true) or go up.
//
// 
// parameters:
// position : X,Y position of the hole in X,Y axis
// size - size of the hole (X, Y axis)
// fingers_align_x - the finger hole to be aligned with X axis (if false, with Y axis)
// depth - optional depth - if used, the hole will have this depth. 
//    $holes_bottom_thickness variable will be ignored if depth is used
// bury - true by default. If false, the picture will be rendered upwards
// centerX - if true, center horizontally
// centerY - if true, center vertically
// center - if true, center both horizontally and vertically
// $holes_bottom_part_top - top of the bottom part of the box
// $holes_finger_hole_radius - radius of the hole for fingers 
// $holes_finger_hole_extend - how far should the finger hole reach

module cubic_hole_with_finger_holes(position=[0,0], size, fingers_align_x=false, fingers_additional_depth=0, depth=-1, bury=true, center=false, centerX=false, centerY=false) {
    
    include <holes_default_parameters.scad>
    
    cubic_hole(position, size, depth, bury, center, centerX, centerY) {
        children();
    };
    
    if(fingers_align_x) {
        translate([center || centerX ? position[0] : position[0]+size[0]/2, center || centerY ? position[1] : position[1] + size[1]/2, $holes_bottom_part_top-$holes_finger_additional_depth])
            rotate([0,90,0])
                cylinder(h=size[0]+$holes_finger_hole_extend*2, r=$holes_finger_hole_radius, center=true);
        
        if($holes_finger_additional_depth > 0) 
            translate([center || centerX ? position[0]-size[0]/2-$holes_finger_hole_extend : position[0]-$holes_finger_hole_radius, center || centerY ? position[1]-$holes_finger_hole_radius : position[1] + size[1]/2-$holes_finger_hole_radius, $holes_bottom_part_top-$holes_finger_additional_depth])
                cube([size[0]+$holes_finger_hole_extend*2, 2*$holes_finger_hole_radius, $holes_finger_additional_depth+1]);
    } else {
        translate([center || centerX ? position[0] : position[0]+size[0]/2, center || centerY ? position[1] : position[1] + size[1]/2, $holes_bottom_part_top-$holes_finger_additional_depth])
            rotate([90,0,0])
                cylinder(h=size[1]+$holes_finger_hole_extend*2, r=$holes_finger_hole_radius, center=true);
        
                if($holes_finger_additional_depth > 0) 
                    translate([center || centerX ? position[0] - $holes_finger_hole_radius : position[0]+size[0]/2-$holes_finger_hole_radius, center || centerY ? position[1]-size[1]/2 -$holes_finger_hole_extend: position[1]-$holes_finger_hole_extend, $holes_bottom_part_top-$holes_finger_additional_depth])
                        cube([2*$holes_finger_hole_radius, size[1]+$holes_finger_hole_extend*2, $holes_finger_additional_depth+1 ]);
                
        
    }
}


// A hole in the organizer with a picture and space to put finers when drawing tokens. A centered 2D
// object(s) may be enclosed in the call so it will become 
// rendered on the bottom of the hole. Based on bury parameter 
// the picture will be buried in the box (true) or go up.
//
// 
// parameters:
// position : X,Y position of the hole in X,Y axis
// size - size of the hole (X, Y axis)
// fingers_align_x - the finger hole to be aligned with X axis (if false, with Y axis)
// depth - optional depth - if used, the hole will have this depth. 
//    $holes_bottom_thickness variable will be ignored if depth is used
// bury - true by default. If false, the picture will be rendered upwards
// centerX - if true, center horizontally
// centerY - if true, center vertically
// center - if true, center both horizontally and vertically
// $holes_bottom_part_top - top of the bottom part of the box
// $holes_finger_hole_radius - radius of the hole for fingers 
// $holes_finger_hole_extend - how far should the finger hole reach

module hole_with_finger_holes(position=[0,0], size, fingers_align_x=false, depth=-1, bury=true, center=false, centerX=false, centerY=false) {
    
    include <holes_default_parameters.scad>
    
    hole(position, size, depth, bury, center, centerX, centerY) {
        children();
    };
    
    
    if(fingers_align_x) {
        translate([center || centerX ? position[0] : position[0]+size[0]/2, center || centerY ? position[1] : position[1] + size[1]/2, $holes_bottom_part_top-$holes_finger_additional_depth])
            rotate([0,90,0])
                cylinder(h=size[0]+$holes_finger_hole_extend*2, r=$holes_finger_hole_radius, center=true);
        
        
        if($holes_finger_additional_depth > 0) 
            translate([center || centerX ? position[0]-size[0]/2-$holes_finger_hole_extend : position[0]-$holes_finger_hole_radius, center || centerY ? position[1]-$holes_finger_hole_radius : position[1] + size[1]/2-$holes_finger_hole_radius, $holes_bottom_part_top-$holes_finger_additional_depth])
                cube([size[0]+$holes_finger_hole_extend*2, 2*$holes_finger_hole_radius, $holes_finger_additional_depth+1]);
        
    } else {
        translate([center || centerX ? position[0] : position[0]+size[0]/2, center || centerY ? position[1] : position[1] + size[1]/2, $holes_bottom_part_top-$holes_finger_additional_depth])
            rotate([90,0,0])
                cylinder(h=size[1]+$holes_finger_hole_extend*2, r=$holes_finger_hole_radius, center=true);

                if($holes_finger_additional_depth > 0) 
                    translate([center || centerX ? position[0] - $holes_finger_hole_radius : position[0]+size[0]/2-$holes_finger_hole_radius, center || centerY ? position[1]-size[1]/2 -$holes_finger_hole_extend: position[1]-$holes_finger_hole_extend, $holes_bottom_part_top-$holes_finger_additional_depth])
                        cube([2*$holes_finger_hole_radius, size[1]+$holes_finger_hole_extend*2, $holes_finger_additional_depth+1 ]);

    }   
    
}

// A hole in the shape of lying cylinder. 
// Parameters:
//   position - position of the hole [x,y]
//   radius - radius radius of the cylinder
//   diameter - diameter of the cylinder (either radius or diamter must be supplied)
//   length - length of the hole
//   align_x - if true, the hole will be oriented around the X axis. Otherwise Y axis
//   centerX - if true, center horizontally
//   centerY - if true, center vertically
//   center - if true, center both horizontally and vertically
module horizontal_round_hole(position=[0,0], radius, diameter, length, align_x=false, center=false, centerX=false, centerY=false) {
    include <holes_default_parameters.scad>

    assert(is_undef(radius)||is_undef(diameter), "Either radius or diameter must be defined, but not both!");
    assert(!(is_undef(radius)&&is_undef(diameter)), "Either radius or diameter must be defined!");
    
    r=is_undef(radius)?diameter/2:radius;
    
    if(align_x) {
        translate([ (center || centerX) ? position[0] : position[0] + length/2, (center || centerY) ? position[1] : position[1] + r, $holes_bottom_part_top])
           rotate([0,90 ,0])
              cylinder(h=length, r=r, center=true); 
    } else {
        translate([ (center || centerX) ? position[0] : position[0] + r, (center || centerY) ? position[1] : position[1] + length/2, $holes_bottom_part_top])
           rotate([90,0 ,0])
              cylinder(h=length, r=r, center=true); 
    }    
    
    
}

// A hole in the shape of standing cylinder. 
// Parameters:
//   position - position of the hole [x,y]
//   radius - radius radius of the cylinder
//   diameter - diameter of the cylinder (either radius or diamter must be supplied)
//   depth - how deep the hole shall be. If not used, the hole will go to bottom of the box. 
//   align_x - if true, the hole will be oriented around the X axis. Otherwise Y axis
//   centerX - if true, center horizontally
//   centerY - if true, center vertically
//   center - if true, center both horizontally and vertically
module vertical_round_hole(position=[0,0], radius, diameter, depth=-1, align_x=false, center=false, centerX=false, centerY=false) {
    include <holes_default_parameters.scad>

    assert(is_undef(radius)||is_undef(diameter), "Either radius or diameter must be defined, but not both!");
    assert(!(is_undef(radius)&&is_undef(diameter)), "Either radius or diameter must be defined!");
    r=is_undef(radius)?diameter/2:radius;
    
    translate([(center || centerX)?position[0]:position[0]+r, (center || centerY)?position[1]:position[1]+r, depth == -1 ? $holes_bottom_thickness : $holes_bottom_part_top-depth])  
       cylinder(h=($holes_bottom_top_overlap+(depth==-1 ? $holes_bottom_part_top-$holes_bottom_thickness: depth)), r=r);   
}

//$holes_bottom_part_top=30;
//$holes_finger_additional_depth = 15;
//hole_with_finger_holes(size=[21, 13], position=[20, 10], centerX=true, fingers_align_x=false);


//use <2D/battery_symbol_2D.scad>
////$holes_bottom_part_top=30;
//cubic_hole_with_finger_holes(size=[21, 13], position=[0, 0]) {
////    battery_symbol_2D($line_width=0.5);
//};


//use <2D/dice_symbol_2D.scad>
//use <2D/target_symbol_2D.scad>
//

//$holes_bottom_thickness=4;
//$holes_bottom_part_top=30;
////$holes_bottom_top_overlap=10;
////$holes_finger_hole_radius=30;
//
////$line_width=2;
////hole_with_finger_holes(size=[20, 40], fingers_align_x=true) {
////    battery_symbol_2D($line_width=0.5);
////};
//
//hole(size=[20, 40], position=[40, 0]) {
//    battery_symbol_2D($line_width=0.5);
//};
//
//simple_hole(size=[20, 40], position=[80, 0]);
//
//
//hole(size=[20, 40], position=[120, 0]) {
//    dice_symbol_2D($line_width=0.2);
//};
//
//hole(size=[20, 40], position=[160, 0]) {
//    target_symbol_2D();
//};
//
////vertical_round_hole(position=[0,0], depth=14, radius=10, center=true);
