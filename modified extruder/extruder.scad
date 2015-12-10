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




// location of hobb relative to the head of the bolt. 25 to 30mm
hobb_height=30;
// depth of the hobb (include real depth, how deep the teeth go into the filament)
hobb_depth=1.5;
// Hobbed Bolt
hobbed_bolt_obj=screw_obj(screw=screw_M8_hex_head, washer=washer_M8, nut=nut_M8, height=60);
// Bearing for hobbed bolt
hobbed_bolt_bearing_obj = idler_obj(bearing=bearing_608, screw_object=-1, washer=-1, diameter_tolerance = 0.1, name=-1);
// location of the hobbed bolt from the base
hobbed_bolt_y=38;
hobbed_bolt_x=idler_obj_outer_dia(hobbed_bolt_bearing_obj)/2 - 0.5;

// filament diameter
filament_dia=3;

// width of the hotend mount
e3d_mount_width=16;
// width of the grooved area
e3d_groove_width=12;
// array starts from top (entrance) to bottom, with the thickness of the tip, groove, and bottom. Add these together for the total cutout height.
e3d_mount_height_array=[3.7,6,3];
e3d_hotend_height=62;

// width of the hotend mount
jhead_mount_width=15.9;
// width of the grooved area
jhead_groove_width=12;
jhead_mount_height_array=[4.76, 4.64, 3];

jhead_mount_width=16.25;
jhead_groove_width=12.25;
custom_mount_height_array=[5.25, 4.55, 3];



// don't use washers on the idler to save on part count
filament_idler_obj = idler_obj(bearing=bearing_608, screw_object=-1, washer=-1, name=-1);

//main_body_size
// body height must be at minimum be the thickness of 2 of the hobbed bolt bearings, + idler bearing + washer thickness between them.
// calculate the height based on this. use 3mm between each bearing
// main_body_size=[24, 60, 28];
// this does not include the tolerance for washers, for a tight fit.
main_body_height=idler_obj_width(filament_idler_obj)+idler_obj_width(hobbed_bolt_bearing_obj)*2+6;
echo("Main Body Height", main_body_height);
main_body_size=[24, 60, main_body_height];

// screws used for the groovemount clamp
groove_clamp_screw_obj = screw_obj(screw=screw_M3_socket_head, washer=washer_M3, nut=nut_M3, height=main_body_size[Z_AXIS]);

// the screw for the idler hinge. Screw length should be body height
idler_hinge_screw_obj = screw_obj(screw=screw_M3_socket_head, washer=washer_M3, nut=nut_M3, height=main_body_size[Z_AXIS]);
// 3mm per side on the idler screw
// the screw or rod that the idler going on, and is pressed into the idler body.
filament_idler_screw_obj = screw_obj(screw=rod_M8, washer=-1, nut=-1, height=main_body_size[Z_AXIS-6]);
// the bearing for the idler

// idler fulcrum diameter. 2mm thick walls
idler_fulcrum_diameter = screw_obj_screw_head_bottom_dia(idler_hinge_screw_obj)+4;
// the point of the idler fulcrum, offset from the center of the hobbed bolt
idler_fulcrum_offset = idler_obj_outer_dia(filament_idler_obj)/2+idler_fulcrum_diameter/2;
// idler hinge thickness. 6mm cutout thickness on each side
idler_hinge_thickness = main_body_size[Z_AXIS]-12;

// the vertical height of the carriage, as assembled
// Note: carriage is 12mm thick
x_carriage_height=60;
x_carriage_width=56;

// the size of the mounting plate (oriented with the rest of the extruder)
mounting_plate_size=[10,34,34];
// the screw object for the mounting plate (TODO: change to m3 after new carriage is designed)
mounting_screw_obj = screw_obj(screw=screw_M4_socket_head, washer=washer_M4, nut=nut_M4, height=20);
// locations of the mounting holes for the I3 Rework
mounting_hole_locations=[[11.5, 11.5], [-11.5, 11.5], [11.5, -11.5], [-11.5, -11.5]];

module extruder_body() {
    difference() {
        cube(main_body_size);
        translate([hobbed_bolt_x-screw_obj_screw_dia(hobbed_bolt_obj)/2+hobb_depth-filament_dia/2, 0, main_body_size[Z_AXIS]/2])
        rotate([-90, 0,0]) {
            rotate([0,0, 180/12]) polyhole(d=hole_fit(filament_dia,12), h=main_body_size[Y_AXIS], center=false, $fn=12);
            hotend_mount_hole(jhead_mount_height_array, jhead_mount_width, jhead_groove_width, fn=64);
        }
        translate([hobbed_bolt_x, hobbed_bolt_y, 0]) {
            // hobbed bolt hole
            screw_obj_hole(hobbed_bolt_obj);
            // bottom bearing
            idler_obj_hole(hobbed_bolt_bearing_obj, center = false);
            // top bearing
            translate([0, 0,  main_body_size[Z_AXIS]-idler_obj_width(hobbed_bolt_bearing_obj)])
                idler_obj_hole(hobbed_bolt_bearing_obj, center = false);
            // the idler cutout. designed so the idler can fully close against the hobbed bolt ( may change if needed )
            translate([-idler_obj_outer_dia(filament_idler_obj)/2-screw_obj_screw_dia(hobbed_bolt_obj)/2, 0,  main_body_size[Z_AXIS]/2])
                idler_obj_hole(hobbed_bolt_bearing_obj, center = true);
        }
    }
}

module hotend_mount_hole(hotend_height_array, mount_width, groove_width, fn=64) {
    translate([0,0,hotend_height_array[2]+hotend_height_array[1]])
    polyhole(d=hole_fit(mount_width,fn), h=hotend_height_array[0]+0.01, center=false, $fn=fn);
    translate([0,0,hotend_height_array[2]])
    polyhole(d=hole_fit(groove_width,fn), h=hotend_height_array[1]+0.01, center=false, $fn=fn);
    translate([0,0,-0.01])
    polyhole(d=hole_fit(mount_width,fn), h=hotend_height_array[2]+0.02, center=false, $fn=fn);
}

//extruder_body();