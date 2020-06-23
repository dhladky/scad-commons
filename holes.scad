// A single hole in the organizer
// parameters:
// position : X,Y position of the hole in X,Y axis
// size - size of the hole (X, Y axis)
// top - top layer of the hole 
// depth - optional depth - if used, the hole will have this depth. 
//    bottom_thickness argument will be ignored if depth is used
// bottom_thickness - if depth is not used, the depth of the hole will be calculated for the bottom be this thick
// top_overlap - extend the hole above the 'top' so that diffs work properly by this value
// centerX - if true, center horizontally
// centerY - if true, center vertically
// center - if true, center both horizontally and vertically

module hole(position, size, top, depth=-1, bottom_thickness=2, top_overlap=1, center=false, centerX=false, centerY=false) {

    assert(top!=undef, "top value must be defined")
    assert(depth < top, "depth must be smaller then top");  
    assert(depth==-1 || depth>0, "depth must be positive or not defined");
    assert(len(position)==2, "position should be defined as [x,y]");
    assert(len(size)==2, "size should be defined as [sizeX, sizeY]");
    
    hole_bottom = (depth==-1) ? bottom_thickness : top - depth;
    echo(hole_bottom=hole_bottom);

    cornerX = min([size[0]/8, 5]); // 5 mm or eight of the hole
    cornerY = min([size[1]/8, 5]); // 5 mm or eight of the hole
    cornerZ = hole_bottom+min([(top-hole_bottom)/8, 3]); // 3 mm or eight of the hole
 
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
       [0, 0, top+top_overlap], // 12
       [size[0], 0, top+top_overlap], // 13
       [size[0], size[1], top+top_overlap], // 14    
       [0, size[1], top+top_overlap] // 15   
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



// A single hole in the organizer with a picture. A centered 2D
// object(s) needs to be enclosed in the call so it will become 
// rendered on the bottom of the hole. Based on bury parameter 
// the picture will be buried in the box (true) or go up.
//
// 
// parameters:
// position : X,Y position of the hole in X,Y axis
// size - size of the hole (X, Y axis)
// top - top layer of the hole 
// depth - optional depth - if used, the hole will have this depth. 
//    bottom_thickness argument will be ignored if depth is used
// bottom_thickness - if depth is not used, the depth of the hole will be calculated for the bottom be this thick
// line_width - how height/depth of the picture engraving
// bury - true by default. If false, the picture will be rendered upwards
// top_overlap - extend the hole above the 'top' so that diffs work properly by this value
// centerX - if true, center horizontally
// centerY - if true, center vertically
// center - if true, center both horizontally and vertically

module hole_with_picture(position, size, top, depth=-1, bottom_thickness=2, line_width=0.5, bury=true, top_overlap=1, center=false, centerX=false, centerY=false) {
        
    hole_bottom = (depth==-1) ? bottom_thickness : top - depth;

    if(bury) {
      hole(position, size, top, depth, bottom_thickness, top_overlap, center, centerX, centerY);
    
      translate([center||centerX ? position[0] : size[0]/2+position[0], center||centerY?position[1]:position[1]+size[1]/2, hole_bottom-line_width])  
         linear_extrude(height=line_width+0.01)  
            children();
    } else {
        difference() {
            hole(position, size, top, depth, bottom_thickness, top_overlap, center, centerX, centerY);
            
          translate([center||centerX ? position[0] : size[0]/2+position[0], center||centerY?position[1]:position[1]+size[1]/2, hole_bottom-0.01])
                linear_extrude(height=line_width+0.01)  
                    children();
        }
    }
    
}
