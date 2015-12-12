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
use <cooling_fan_40_v4.scad>

//translate([-0,-57.565,0])

// screw_offset
screw_offset_y=4.900005;
screw_offset_z=28+7;


mount_block_Y = 9.8;
mount_block_X = 34;
mount_block_Z = 21.3;
main_height = 28;
filament_dia=3.4;
module extruder4() {
    import("i3R_Compact_Jhead_Extruder_1.75mm_04.STL", convexity=8);
    import("i3R_Compact_Jhead_Clamp_04.stl", convexity=8);
}

extruder4();

translate([0.002,9.4,14.065])
rotate([90,0,0])

hotend_jhead();
//translate([0.002,-2+9.8+3,27.998+6])
//rotate([90+90,0,0])
//rotate([-45,0,0])
translate([0,screw_offset_y,screw_offset_z])
rotate([180-45,0,0])
translate([0,0,-12/2])
cooling_fan();
