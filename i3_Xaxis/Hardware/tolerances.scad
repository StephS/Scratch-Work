// tolerances.scad
// Released under Attribution 3.0 Unported (CC BY 3.0) 
// http://creativecommons.org/licenses/by/3.0/
// Stephanie Shaltes
// Tolerance variables. Overwrite as necessary. Tolerances are used when making holes.
// also holds all of the access functions

// Screw Tolerances
screw_tolerance_hole  = 0.2;
screw_tolerance_head  = 0.2;
screw_tolerance_hex_head  = 0.1;

// rod Tolerances
rod_tolerance_hole  = 0.1;

// Washer Tolerances
// Washer thickness tolerance should be tight for a good fit.
washer_tolerance_diameter  = 0.2;
washer_tolerance_thickness = 0.05;

// Nut tolerances
nut_tolerance_diameter  = 0.1;
nut_tolerance_thickness = 0.2;

// linear bearing tolerance
lb_tolerance_diameter = 0.05;
lb_tolerance_length = 0.2;

// bearing tolerance
bearing_tolerance_diameter = 0.05;
bearing_tolerance_inner_diameter = 0.05;
bearing_tolerance_width = 0.1;