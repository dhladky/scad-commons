include <common_defaults.scad>

// check common asserts
assert(!is_undef($holes_bottom_part_top), "$holes_bottom_part_top parameter is not defined!");
assert(len(position)==2, "position should be defined as [x,y]");

// set default values
$holes_bottom_thickness=is_undef($holes_bottom_thickness)?2:$holes_bottom_thickness;
$holes_bottom_top_overlap=is_undef($holes_bottom_top_overlap)?1:$holes_bottom_top_overlap;
$holes_finger_hole_radius=is_undef($holes_finger_hole_radius)?5:$holes_finger_hole_radius;
$holes_finger_hole_extend=is_undef($holes_finger_hole_extend)?5:$holes_finger_hole_extend;
