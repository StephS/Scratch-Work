// Greg's Wade Extruder. 
// It is licensed under the Creative Commons - GNU GPL license. 
//  2010 by GregFrost
// Extruder based on prusa git repo.
// http://www.thingiverse.com/thing:6713

include <inc/functions.scad>;
include <Hardware/func_nuts_screws_washers.scad>;
include <Hardware/func_idler.scad>;
include <Hardware/func_motors.scad>;
use <jhead.scad>
use <cooling_fan_40.scad>

//translate([-0,-57.565,0])

mount_block_Y = 9.8;
mount_block_X = 34;
mount_block_Z = 21.3;
main_height = 28;
filament_dia=3.4;

module main_block (){
difference() {
    union() {
difference() {
    union() {
        import("i3R_Compact_Jhead_Extruder_1.75mm_03.STL", convexity=8);
        //translate([20,0,0])
        //import("i3R_Compact_Guidler_3mm_01.STL", convexity=8);
    }


translate([0.002,100,14.065])
rotate([90,0,0])
cylinder(d=filament_dia, h=100, $fn=100);
    translate([-17,-0.6,0])
    cube([34,10.4,22]);
    translate([-30,-2,8])
    cube([13,8,12]);

translate([25.30,57,0])
cylinder(d=30, h=20, $fn=100);    
}
difference() {
union() {       
translate([0,-2,0])
            intersection() {
                import("i3R_Compact_Jhead_Extruder_1.75mm_03.STL", convexity=8);
                translate([-29.4223,0,0]) {
                cube([46.4223,10,22]);
                }
            }
        translate([-17,7.8,0])
        cube([34,2.2,28]);
        }
        translate([0.002,100,14.065])
rotate([90,0,0])
cylinder(d=filament_dia, h=100, $fn=100);
    }
}
translate([-29.822299-1.6,-2,0])
    cube([14,20,7.6]);
}
}

main_block();

/*
difference() {
resize([0,0,7.690017])
minkowski() {
difference() {
resize([0,0,7.690017])
minkowski() {
resize([0,0,7.690017]) {
translate([0,0,-7.690017 ])
intersection() {
    difference() {
    main_block();
        translate([-29.822299-1.6,-2,0])
    cube([14,20,7.690017]);
    }
translate([-29.822299-3,-2,0])
    cube([14,20,7.690017+2]);
}
}
cylinder(d=1, h=2, $fn=8);
}
resize([0,0,7.690017+1]) {
translate([0,0,-7.690017 ])
intersection() {
    difference() {
    main_block();
        translate([-29.822299-1.6,-2,0])
    cube([14,20,7.690017]);
    }
translate([-29.822299-3,-2,0])
    cube([14,20,7.690017+2]);
}
}
}
//cylinder(d=0.3, h=1, $fn=8);
}
        translate([-29.822299-1.6+12.5,-2,7.690017-0.2])
    cube([1.5,20,1]);
}
*/
intersection() {
union() {
translate([-29.822299-0.9,11.1-2,0])
    cube([0.4,4,7.690017-0.2]);

translate([-29.822299,-2,0])
    cube([0.4,17.75,7.690017-0.2]);

translate([-29.822299+2,-2,0])
    cube([0.4,19.75,7.690017-0.2]);

translate([-29.822299+4,-2,0])
    cube([0.4,20.5,7.690017-0.2]);

translate([-29.822299+6,-2,0])
    cube([0.4,20.5,7.690017-0.2]);

translate([-29.822299+8,-2,0])
    cube([0.4,20,7.690017-0.2]);

translate([-29.822299+10,-2,0])
    cube([0.4,18.5,7.690017-0.2]);

translate([-29.822299+12,-2,0])
    cube([0.4,15.5,7.690017-0.2]);
hull() {
translate([-29.822299,-2,7.690017-0.6])
    cube([12,15.5,0.401]);

translate([-29.822299+6-0.25,11.1,7.690017-0.6])
    cylinder(d=12+1.3, h=0.401, $fn=32);
}
hull() {
translate([-29.822299,-2,0])
    cube([12,14.5,0.4]);

translate([-29.822299+6-0.25,11.1,0])
    cylinder(d=12+1.3, h=0.4, $fn=32);
}
}
hull() {
translate([-29.822299,-2,0])
    cube([12.4,14.5,7.690017-0.199]);

translate([-29.822299+6-0.25,11.1,0])
    cylinder(d=12+1.3, h=7.690017-0.199, $fn=32);
}
}
//96.19
// 8.25
// 53.44
// 57.565

//22.68
//16.25
//16.66

//13.02
// 12.37

// clamp hole to hole =25

// center of filament to furthest edge of hobb = 8.11

// hobb = 8.25d

//cylinder(d=8, h=30, $fn=100);
//cube([5,5,20.5]);

//main body size
//base to hobbed bolt
//idler fulcrum offset

//hotend type (need to get dimensions and create object)
//fan (need to create fan objects)
//big gear diameter
//small gear diameter
//x carriage height
//mounting screw size
//idler hinge screw size
// the groove should be rounded/beveled slightly to account for printing accuracy (there are no perfect 90 degree corners)

translate([0.002,-2+9.4,14.065])
rotate([90,0,0])

hotend_jhead();
//translate([0.002,-2+9.8+3,27.998+6])
//rotate([90+90,0,0])
//rotate([-45,0,0])
translate([0,(13-3),-10])
cooling_fan();
