// Greg's Wade Extruder. 
// It is licensed under the Creative Commons - GNU GPL license. 
//  2010 by GregFrost
// Extruder based on prusa git repo.
// http://www.thingiverse.com/thing:6713

include <inc/functions.scad>;
include <Hardware/func_nuts_screws_washers.scad>;
include <Hardware/func_idler.scad>;
include <Hardware/func_motors.scad>;

fan_screw_length=8;

fan_screw_obj = screw_obj(screw=screw_M3_socket_head, nut=nut_M3, height=fan_screw_length);
mount_screw_obj = screw_obj(screw=screw_M3_socket_head, nut=nut_M3, washer=washer_M3, height=18, head_drop=0, hole_support=true, slot_length=2, slot_offset=-1);

duct_wall_width=1;
base_duct_height=5;
// 3.85588-2.1/2
// 8.13317-6.46633/2
// 10.20429-6.40859/2


tab_width=7;
tab_diameter=12;
tab_thickness=3;

fan_duct_dia=38;
fan_hole_separation=32;
fan_z_offset=10;

duct_z_angle_h=4;
duct_length=34;
duct_height=10;

duct_nozzle_height=38+10;

duct_width=10;

mount_screw_head_dia=screw_obj_screw_head_top_dia(mount_screw_obj);
head_dia=screw_obj_screw_head_top_dia(fan_screw_obj);
module cooling_fan() {

    //translate([0,0,-tab_diameter/2])
    difference() {
        union() {
            translate([0,tab_diameter/2,0]){
                //rotate([45,0,0])
                fan_mount(center=[true,false,false], h=3);
                hull() {
                // base part of the duct
                translate([-41/2,0,3])
                cube_fillet(size=[41,41,tab_diameter-3], radius=-1, vertical=[4,4,4,4], top=[0,0,0,0], bottom=[0,0,0,0], center=false, $fn=0, vertical_fn=[12,12,12,12], top_fn=[0,0,0,0], bottom_fn=[0,0,0,0]);
                // angled part of the duct
                translate([0,0,tab_diameter])
                rotate([45,0,0]) 
                translate([-41/2,0,-duct_z_angle_h])
                    cube_fillet(size=[41,duct_nozzle_height,duct_z_angle_h], radius=-1, vertical=[4,4,4,4], top=[0,4,0,4], bottom=[0,0,0,0], center=false, $fn=0, vertical_fn=[12,12,12,12], top_fn=[12,12,12,12], bottom_fn=[0,0,0,0]);
                }
                // end duct near the nozzle
                translate([0,0,tab_diameter])
                rotate([45,0,0])
                    translate([-41/2,duct_nozzle_height-duct_height,-duct_z_angle_h]) {
                        // duct extension
                        cube_fillet(size=[41,duct_height,10], radius=-1, vertical=[4,4,4,4], top=[2,0,0,0], bottom=[0,0,0,0], center=false, $fn=0, vertical_fn=[12,12,12,12], top_fn=[1,0,0,0], bottom_fn=[0,0,0,0]);
                        // x+ duct
                        cube_fillet(size=[duct_width,duct_height,duct_length], radius=-1, vertical=[2,4,4,4], top=[0,0,0,0], bottom=[0,0,0,0], center=false, $fn=0, vertical_fn=[1,12,12,12], top_fn=[0,0,0,0], bottom_fn=[0,0,0,0]);
                        // x- duct
                        translate([41-duct_width,0,0])
                            cube_fillet(size=[duct_width,duct_height,duct_length], radius=-1, vertical=[4,2,4,4], top=[0,0,0,0], bottom=[0,0,0,0], center=false, $fn=0, vertical_fn=[12,1,12,12], top_fn=[0,0,0,0], bottom_fn=[0,0,0,0]);
                    }
                
            }
            translate([0,0,tab_diameter/2])
            mount_tabs();
        }
        
        translate([-41/2,tab_diameter/2,0]) {
            fan_mount_holes();
            translate([0,0,3])
            fan_mount_nuts();
            base_cutout();
        }
        render() hull() {    
        // secondary cutout for hull
            translate([-41/2,tab_diameter/2,fan_screw_length])
            //#base_cutout(h=0.1);
                    translate([41/2,41/2,0])
        cylinder_poly(r=fan_duct_dia/2, h=0.1);
            translate([-(41-duct_wall_width*2)/2,tab_diameter/2+duct_wall_width,tab_diameter-0.1-sin(45)*duct_wall_width])
                cube_fillet(size=[41-duct_wall_width*2,41-duct_wall_width*2,0.1], radius=-1, vertical=[4,4,4,4], top=[0,0,0,0], bottom=[0,0,0,0], center=false, $fn=0, vertical_fn=[12,12,12,12], top_fn=[0,0,0,0], bottom_fn=[0,0,0,0]);
        }
        
        hull() {
        // middle cutout angled part
        translate([-(41-duct_wall_width*2)/2,tab_diameter/2+duct_wall_width,tab_diameter-0.1-sin(45)*duct_wall_width])
                cube_fillet(size=[41-duct_wall_width*2,41-duct_wall_width*2,0.1], radius=-1, vertical=[4,4,4,4], top=[0,0,0,0], bottom=[0,0,0,0], center=false, $fn=0, vertical_fn=[12,12,12,12], top_fn=[0,0,0,0], bottom_fn=[0,0,0,0]);
        // angled part top cutout
        //translate([0,tab_diameter/2+duct_wall_width,tab_diameter])
                translate([0,tab_diameter/2,tab_diameter])
                rotate([45,0,0])
                    translate([-41/2+duct_wall_width,duct_nozzle_height-duct_height+duct_wall_width,-duct_z_angle_h]) 
                        // duct extension
                        translate([0,0,0])
                        cube_fillet(size=[41-duct_wall_width*2,duct_height-duct_wall_width*2,duct_z_angle_h-sin(45)*duct_wall_width*2], radius=-1, vertical=[4,4,4,4], top=[0,4,0,4], bottom=[0,0,0,0], center=false, $fn=0, vertical_fn=[12,12,12,12], top_fn=[0,12,0,12], bottom_fn=[4,0,0,0]);
            /*
            rotate([45,0,0]) 
                translate([-41/2+duct_wall_width,0,-duct_z_angle_h])
                    cube_fillet(size=[41-duct_wall_width*2,38-duct_wall_width*2,duct_z_angle_h-sin(45)*duct_wall_width], radius=-1, vertical=[4,4,4,4], top=[0,4,0,4], bottom=[0,0,0,0], center=false, $fn=0, vertical_fn=[12,12,12,12], top_fn=[12,12,12,12], bottom_fn=[0,0,0,0]);
            */
        }
        
        
        
                translate([0,tab_diameter/2,tab_diameter])
                rotate([45,0,0])
                    translate([-41/2+duct_wall_width,duct_nozzle_height-duct_height+duct_wall_width,-duct_z_angle_h]) {
                        // duct extension
                        translate([0,0,0])
                        hull() {
                        cube_fillet(size=[41-duct_wall_width*2,duct_height-duct_wall_width*2,10-duct_wall_width], radius=-1, vertical=[4,4,4,4], top=[0,0,0,0], bottom=[1,0,0,0], center=false, $fn=0, vertical_fn=[12,12,12,12], top_fn=[1,0,0,0], bottom_fn=[4,0,0,0]);
                            cube_fillet(size=[41-duct_wall_width*2,duct_height-duct_wall_width*2,duct_z_angle_h-sin(45)*duct_wall_width*2], radius=-1, vertical=[4,4,4,4], top=[0,4,0,4], bottom=[0,0,0,0], center=false, $fn=0, vertical_fn=[12,12,12,12], top_fn=[0,12,0,12], bottom_fn=[4,0,0,0]);
                    }
                        // x+ duct
                        translate([0,0,0])
                        cube_fillet(size=[duct_width-duct_wall_width*2,duct_height-duct_wall_width*2,duct_length-duct_wall_width], radius=-1, vertical=[0,4,4,4], top=[0,0,0,0], bottom=[1,0,0,0], center=false, $fn=0, vertical_fn=[1,12,12,12], top_fn=[0,0,0,0], bottom_fn=[4,0,0,0]);
                        // x- duct
                        translate([41-duct_width,0,0])
                            cube_fillet(size=[duct_width-duct_wall_width*2,duct_height-duct_wall_width*2,duct_length-duct_wall_width], radius=-1, vertical=[4,0,4,4], top=[0,0,0,0], bottom=[1,0,0,0], center=false, $fn=0, vertical_fn=[12,1,12,12], top_fn=[0,0,0,0], bottom_fn=[4,0,0,0]);
                    }
                        translate([0,tab_diameter/2,tab_diameter])
                rotate([45,0,0])
                    translate([-41/2+duct_width-4,duct_nozzle_height-4,-duct_z_angle_h+10-4])
                    //cube([41,10,duct_length-(10-duct_wall_width)]);
                    cube_fillet(size=[41-duct_width*2+8,10,duct_length-(10)+8], radius=-1, vertical=[0,0,4,4], top=[0,0,0,0], bottom=[0,0,4,0], center=false, $fn=0, vertical_fn=[1,1,1,1], top_fn=[0,0,0,0], bottom_fn=[0,0,1,0]);
                    //cube([41-duct_width*2+4,10,duct_length-(10)+4]);
        
    }
}

module fan_mount(center=[false,false,false], h=3) {
    translate([((center[0]) ? -41/2 : 0),((center[1]) ? -41/2 : 0),((center[2]) ? -h/2 : 0)])
    difference() {
        cube_fillet(size=[41,41,h], radius=-1, vertical=[4,4,4,4], top=[0,0,0,0], bottom=[0,0,0,0], center=false, $fn=0, vertical_fn=[12,12,12,12], top_fn=[0,0,0,0], bottom_fn=[0,0,0,0]);
    }
}

module fan_mount_holes() {
        translate([4.5,4.5,0])
        screw_obj_hole(fan_screw_obj);
        translate([4.5,4.5+fan_hole_separation,0])
        screw_obj_hole(fan_screw_obj);
        translate([4.5+fan_hole_separation,4.5,0])
        screw_obj_hole(fan_screw_obj);
        translate([4.5+fan_hole_separation,4.5+fan_hole_separation,0])
        screw_obj_hole(fan_screw_obj);
}

module fan_mount_nuts() {
        translate([4.5,4.5,0])
        rotate([0,0,180])
        nut_obj_hole(fan_screw_obj, nut_slot=5);
        translate([4.5,4.5+fan_hole_separation,0])
    rotate([0,0,180])    
    nut_obj_hole(fan_screw_obj, nut_slot=5);
        translate([4.5+fan_hole_separation,4.5,0])
        nut_obj_hole(fan_screw_obj, nut_slot=5);
        translate([4.5+fan_hole_separation,4.5+fan_hole_separation,0])
        nut_obj_hole(fan_screw_obj, nut_slot=5);
}

module base_cutout(h=fan_screw_length) {
    difference() {
        translate([41/2,41/2,0])
        cylinder_poly(r=fan_duct_dia/2, h=h);
        translate([4.5,4.5,0])
        cylinder_poly(r=5, h=tab_diameter);
        translate([4.5,4.5+fan_hole_separation,0])
        cylinder_poly(r=5, h=tab_diameter);
        translate([4.5+fan_hole_separation,4.5,0])
        cylinder_poly(r=5, h=tab_diameter);
        translate([4.5+fan_hole_separation,4.5+fan_hole_separation,0])
        cylinder_poly(r=5, h=tab_diameter);
    }
}

module mount_tabs() {
    thickness=tab_width+tab_thickness*2;
    rotate([-90,0,0])
    rotate([0,90,0])
    difference() {
        union() {
            cylinder(d=tab_diameter, h=thickness, center=true, $fn=32);
            translate([0,(tab_diameter/2+0.1)/2,0])
            cube([tab_diameter,tab_diameter/2+0.1, thickness], center=true);
        }
        cylinder(d=tab_diameter*2, h=tab_width, center=true, $fn=32);
        translate([0,0,-18/2])
        rotate([0,0,90])
        screw_obj_hole(mount_screw_obj);
    }
        
        //cube([34,9,10]);
}

//base_cutout();

//rotate([180-45,0,0])
//translate([0,0,-12/2])
difference() {
cooling_fan();
    //cube([100,100,100]);
}