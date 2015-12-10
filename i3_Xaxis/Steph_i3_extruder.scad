// Greg's Wade Extruder. 
// It is licensed under the Creative Commons - GNU GPL license. 
//  2010 by GregFrost
// Extruder based on prusa git repo.
// http://www.thingiverse.com/thing:6713

include <inc/functions.scad>;
include <Hardware/func_nuts_screws_washers.scad>;
include <Hardware/func_idler.scad>;
include <Hardware/func_motors.scad>;

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
hobb_depth=1.25;
// Hobbed Bolt
hobbed_bolt_obj=screw_obj(screw=screw_M8_hex_head, washer=washer_M8, nut=nut_M8, height=60);
// Bearing for hobbed bolt
hobbed_bolt_bearing_obj = idler_obj(bearing=bearing_608, screw_object=-1, washer=-1, name=-1);
hobbed_bolt_bearing_hole_obj=idler_obj_tolerance(hobbed_bolt_bearing_obj);

hobbed_bolt_x=idler_obj_outer_dia(hobbed_bolt_bearing_obj)/2 - 0.5;

// filament diameter
filament_dia=3;

// width of the hotend mount
e3d_mount_width=16;
// width of the grooved area
e3d_groove_width=12;
// array starts from top (entrance) to bottom, with the thickness of the tip, groove, and bottom. Add these together for the total cutout height.
e3d_mount_height_array=[3.7,6];
e3d_hotend_height=62;

// width of the hotend mount
jhead_mount_width=15.9;
// width of the grooved area
jhead_groove_width=12;
jhead_mount_height_array=[4.76, 4.64];
hotend_mount_tolerance=0.1;

// don't use washers on the idler to save on part count
filament_idler_obj = idler_obj(bearing=set_bearing_tolerance(bearing_608, tolerance_dia=1), screw_object=-1, washer=-1, name=-1);
filament_idler_hole_obj = idler_obj_tolerance(filament_idler_obj);

idler_spring_nut_slot=2;
idler_spring_nut_to_top=2;
idler_spring_screw_obj = screw_obj(screw=screw_M4_socket_head, washer=washer_M4, nut=nut_M4, height=50, slot_length=idler_spring_nut_slot, horizontal=true);

//main_body_size
// body height must be at minimum be the thickness of 2 of the hobbed bolt bearings, + idler bearing + washer thickness between them.
// calculate the height based on this. use 3mm between each bearing
// main_body_size=[24, 60, 28];
// this does not include the tolerance for washers, for a tight fit.

main_body_height=idler_obj_width(filament_idler_hole_obj)+idler_obj_width(hobbed_bolt_bearing_hole_obj)*2+6;
echo("Main Body Height", main_body_height);

// extra length for the main body

hobb_bolt_bearing_to_idler_spring_nut_gap=1;




main_body_extra_length=hobb_bolt_bearing_to_idler_spring_nut_gap+idler_spring_nut_slot+idler_spring_nut_to_top;


main_body_size=[24, jhead_mount_height_array[0]+jhead_mount_height_array[1]+idler_obj_outer_dia(hobbed_bolt_bearing_hole_obj)+screw_obj_nut_dia(idler_spring_screw_obj)+main_body_extra_length+2, main_body_height];

// screws used for the groovemount clamp
groove_clamp_screw_obj = screw_obj(screw=screw_M3_socket_head, washer=washer_M3, nut=nut_M3, height=main_body_size[Z_AXIS]);
groove_clamp_screw_hole_obj=screw_obj_tolerance(groove_clamp_screw_obj);
groove_clamp_hole_separation=jhead_mount_width+screw_obj_screw_dia(groove_clamp_screw_hole_obj)+0.8;
groove_clamp_width=groove_clamp_hole_separation+screw_obj_screw_head_top_dia(groove_clamp_screw_hole_obj)+2;
groove_clamp_length=jhead_mount_height_array[0]+jhead_mount_height_array[1];
groove_clamp_tolerance=0.2;

// the screw for the idler hinge. Screw length should be body height
idler_hinge_screw_obj = screw_obj(screw=screw_M3_socket_head, washer=washer_M3, nut=nut_M3, height=main_body_size[Z_AXIS]);
// 3mm per side on the idler screw
// the screw or rod that the idler going on, and is pressed into the idler body.
filament_idler_screw_obj = screw_obj(screw=rod_M8, washer=-1, nut=-1, height=main_body_size[Z_AXIS]-6);
// the bearing for the idler

// idler fulcrum diameter. 2mm thick walls
idler_fulcrum_diameter = screw_obj_screw_head_bottom_dia(idler_hinge_screw_obj)+4;
// the point of the idler fulcrum, offset from the center of the hobbed bolt
idler_fulcrum_offset = idler_obj_outer_dia(filament_idler_hole_obj)/2+idler_fulcrum_diameter/2;
// idler hinge thickness. 6mm cutout thickness on each side
idler_hinge_thickness = main_body_size[Z_AXIS]-12;

// calculate based on the hinge
groove_clamp_height=(main_body_size[Z_AXIS]-idler_hinge_thickness)/2;
echo("groove clamp height", groove_clamp_height);

// the vertical height of the carriage, as assembled
// Note: carriage is 12mm thick
x_carriage_height=60;
x_carriage_width=56;

// gap between the top of the groovemount and the hobbed bolt bearing
groove_to_idler_gap=2;

// location of the hobbed bolt from the base
// calculate it
//hobbed_bolt_y=38;
hobbed_bolt_y=groove_clamp_length+idler_obj_outer_dia(filament_idler_hole_obj)/2+groove_to_idler_gap;

// idler screw positions
idler_spring_nut_y=hobbed_bolt_y+screw_obj_nut_dia(idler_spring_screw_obj)/2+hobb_bolt_bearing_to_idler_spring_nut_gap+idler_obj_outer_dia(hobbed_bolt_bearing_obj)/2;
idler_spring_nut_x=hobbed_bolt_x+1;
idler_spring_separation=(main_body_size[Z_AXIS]-screw_obj_nut_dia(idler_spring_screw_obj)-2)/2;

echo("filament idler dia", idler_obj_outer_dia(filament_idler_obj));
echo("filament idler hole dia", idler_obj_outer_dia(filament_idler_hole_obj));
echo("hobb bolt idler hole dia", idler_obj_outer_dia(hobbed_bolt_bearing_hole_obj));

// the size of the mounting plate (oriented with the rest of the extruder)
mounting_plate_size=[10,34,34];
// the screw object for the mounting plate (TODO: change to m3 after new carriage is designed)
mounting_screw_obj = screw_obj(screw=screw_M4_socket_head, washer=washer_M4, nut=nut_M4, height=20);
// locations of the mounting holes for the I3 Rework
mounting_hole_locations=[[11.5, 11.5], [-11.5, 11.5], [11.5, -11.5], [-11.5, -11.5]];

filament_center_location=hobbed_bolt_x-screw_obj_screw_dia(hobbed_bolt_obj)/2+hobb_depth-filament_dia/2;

// idler gap
filament_idler_gap=(main_body_size[Z_AXIS]-idler_obj_width(hobbed_bolt_bearing_hole_obj)*2-idler_obj_width(filament_idler_hole_obj))/2+idler_obj_width(hobbed_bolt_bearing_hole_obj);

module extruder_body() {
    difference() {
        union() {
            cube(main_body_size);
            // groove clamp
            translate([-groove_clamp_width/2+filament_center_location-groove_clamp_tolerance/2, 0, 0])
            cube([groove_clamp_width+groove_clamp_tolerance, groove_clamp_length, main_body_size[Z_AXIS]-groove_clamp_height]);
            translate([-groove_clamp_width/2+filament_center_location-groove_clamp_tolerance/2, groove_clamp_length, 0])
            cube([groove_clamp_width+groove_clamp_tolerance, groove_to_idler_gap, main_body_size[Z_AXIS]]);
        }
        
        translate([0,idler_spring_nut_y, main_body_size[Z_AXIS]/2-idler_spring_separation])
            rotate([0,-90,0])
                translate([0,0,-main_body_size[X_AXIS]])
                rotate([0,0,90])
                screw_obj_hole(idler_spring_screw_obj);
        translate([0,idler_spring_nut_y, main_body_size[Z_AXIS]/2-idler_spring_separation])
            rotate([0,90,0])        
                translate([0,0,idler_spring_nut_x])
                rotate([0,0,90])
                #nut_obj_hole(idler_spring_screw_obj, nut_slot=20);        
        
        translate([filament_center_location, 0, main_body_size[Z_AXIS]/2])
        rotate([-90, 0,0]) {
            // filament hole
            rotate([0,0, 180/12]) polyhole(d=hole_fit(filament_dia,12), h=main_body_size[Y_AXIS]+0.01, center=false, $fn=12);
            // groove mount clamp cutout
            rotate([0,0,-90])
            hotend_mount_hole(jhead_mount_height_array, jhead_mount_width, jhead_groove_width, slot_length=main_body_size[Z_AXIS]/2, fn=64);
        }
        translate([hobbed_bolt_x, hobbed_bolt_y, 0]) {
            // hobbed bolt hole
            screw_obj_hole(hobbed_bolt_obj);
            // bottom bearing
            idler_obj_hole(hobbed_bolt_bearing_obj, center = false);
            // top bearing
            translate([0, 0,  main_body_size[Z_AXIS]-idler_obj_width(hobbed_bolt_bearing_hole_obj)]) {
                // relief for bearing
                translate([0,0,-0.2])
                polyhole(d=idler_obj_outer_dia(hobbed_bolt_bearing_obj)-2, h=0.2+0.01, center=false);
                // idler hole
                idler_obj_hole(hobbed_bolt_bearing_obj, center = false);
            }
            // the idler cutout. designed so the idler can fully close against the hobbed bolt ( may change if needed )
            // cut through to the top for access to clean the bolt
            translate([-idler_obj_outer_dia(filament_idler_hole_obj)/2-screw_obj_screw_dia(hobbed_bolt_obj)/2, 0,  filament_idler_gap])
                idler_obj_hole(filament_idler_obj, width= filament_idler_gap+idler_obj_width(filament_idler_hole_obj)+0.01,center = false);
        }
        
        // holes for groove mount clamp
        translate([filament_center_location-groove_clamp_hole_separation/2,groove_clamp_length/2,0]) {
            screw_obj_hole(groove_clamp_screw_obj);
            nut_obj_hole(groove_clamp_screw_obj);
        }
        translate([filament_center_location+groove_clamp_hole_separation/2,groove_clamp_length/2,0]) {
            screw_obj_hole(groove_clamp_screw_obj);
            nut_obj_hole(groove_clamp_screw_obj);
        }
        // cutout for the clamp
        translate([-groove_clamp_width/2+filament_center_location-groove_clamp_tolerance/2, 0, main_body_size[Z_AXIS]-groove_clamp_height])
            cube([groove_clamp_width+groove_clamp_tolerance, groove_clamp_length, groove_clamp_height +0.01]);
    }
}

module hotend_mount_hole(hotend_height_array, mount_width, groove_width, slot_length=0, fn=64) {
    translate([0,0,hotend_height_array[1]])
    cylinder_slot(r=hole_fit(mount_width+hotend_mount_tolerance,fn)/2, h=hotend_height_array[0], length=slot_length, center=false, $fn=fn);
    translate([0,0,-0.01])
    cylinder_slot(r=hole_fit(groove_width+hotend_mount_tolerance,fn)/2, h=hotend_height_array[1]+0.02, length=slot_length, center=false, $fn=fn);
}

extruder_body();