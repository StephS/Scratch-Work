// Greg's Wade Extruder. 
// It is licensed under the Creative Commons - GNU GPL license. 
//  2010 by GregFrost
// Extruder based on prusa git repo.
// http://www.thingiverse.com/thing:6713

include <inc/functions.scad>;
include <Hardware/func_nuts_screws_washers.scad>;
include <Hardware/func_idler.scad>;
include <Hardware/func_motors.scad>;

fan_screw_obj = screw_obj(screw=screw_M3_socket_head, nut=nut_M3, height=7);
mount_screw_obj = screw_obj(screw=screw_M3_socket_head, nut=nut_M3, washer=washer_M3, height=18, head_drop=0, hole_support=true, slot_length=0);

duct_wall_width=1;
base_duct_height=5;
// 3.85588-2.1/2
// 8.13317-6.46633/2
// 10.20429-6.40859/2


tab_width=7;
tab_diameter=10;
tab_thickness=2;

fan_duct_dia=38;
fan_hole_separation=32;
fan_z_offset=10;

mount_screw_head_dia=screw_obj_screw_head_top_dia(mount_screw_obj);
head_dia=screw_obj_screw_head_top_dia(fan_screw_obj);
module cooling_fan() {
    difference() {
        union() {
            translate([0,sin(45)*3+tab_diameter/2,fan_z_offset]){
                rotate([45,0,0])
                fan_mount(center=[true,false,false], h=3);
            }
            translate([0,0,tab_diameter/2])
            mount_tabs();
        }
    }
}

module fan_mount(center=[false,false,false], h=3) {
    translate([((center[0]) ? -41/2 : 0),((center[1]) ? -41/2 : 0),((center[2]) ? -h/2 : 0)])
    difference() {
        cube_fillet(size=[41,41,h], radius=-1, vertical=[4,4,4,4], top=[0,0,0,0], bottom=[0,0,0,0], center=false, $fn=0, vertical_fn=[12,12,12,12], top_fn=[0,0,0,0], bottom_fn=[0,0,0,0]);
        translate([4.5,4.5,0])
        screw_obj_hole(fan_screw_obj);
        translate([4.5,4.5+fan_hole_separation,0])
        screw_obj_hole(fan_screw_obj);
        translate([4.5+fan_hole_separation,4.5,0])
        screw_obj_hole(fan_screw_obj);
        translate([4.5+fan_hole_separation,4.5+fan_hole_separation,0])
        screw_obj_hole(fan_screw_obj);
    }
}

module mount_tabs() {
    thickness=tab_width+tab_thickness*2;
    rotate([0,90,0])
    difference() {
        union() {
            cylinder(d=tab_diameter, h=thickness, center=true, $fn=32);
            translate([0,(tab_diameter/2+0.1)/2,0])
            cube([tab_diameter,tab_diameter/2+0.1, thickness], center=true);
        }
        cylinder(d=tab_diameter*2, h=tab_width, center=true, $fn=32);
        translate([0,0,-18/2])
        screw_obj_hole(mount_screw_obj);
    }
        
        //cube([34,9,10]);
}

cooling_fan();