// Greg's Wade Extruder. 
// It is licensed under the Creative Commons - GNU GPL license. 
//  2010 by GregFrost
// Extruder based on prusa git repo.
// http://www.thingiverse.com/thing:6713

include <inc/functions.scad>;
include <Hardware/func_nuts_screws_washers.scad>;
include <Hardware/func_idler.scad>;
include <Hardware/func_motors.scad>;

//translate([-0,-57.565,0])

mount_block_Y = 9.8;
mount_block_X = 34;
mount_block_Z = 21.3;
main_height = 28;
filament_dia=3.4;

z_height=7.01;
x_width=12.75;
y_length=8.55;

myscrew_obj = screw_obj(screw=screw_M3_socket_head, nut=nut_M3, height=7);
mountscrew_obj = screw_obj(screw=screw_M3_socket_head, nut=nut_M3, washer=washer_M3, height=18, head_drop=0, hole_support=true, slot_length=2);

/*
translate([-41/2,0,0])
cube_fillet(size=[41,41,3], radius=-1, vertical=[4,4,4,4], top=[0,0,0,0], bottom=[0,0,0,0], center=false, $fn=0, vertical_fn=[12,12,12,12], top_fn=[0,0,0,0], bottom_fn=[0,0,0,0]);
*/
fan_dia=38;
top_dim_x=15;
top_dim_y=4;
top_offset=37;
myoffset=1.4;
//fan_height=34.5;
fan_height=17.5;
base_duct_height=5;

hole_separation=32;

// 42 - 

mountscrewloc=40.5;

mount_screw_head_dia=screw_obj_screw_head_top_dia(mountscrew_obj);
head_dia=screw_obj_screw_head_top_dia(myscrew_obj);
module cooling_fan() {
difference() {
    union(){
        difference() {
hull() {
translate([-top_dim_x/2,top_offset,fan_height])
rotate([-45,0,0])
cube_fillet(size=[top_dim_x,top_dim_y,2], radius=-1, vertical=[0,0,0,0], top=[0,0,0,0], bottom=[0,0,0,0], center=false, vertical_fn=[0,0,0,0], top_fn=[0,0,0,0], bottom_fn=[0,0,0,0]);
translate([0,41/2,0])
    // base duct
cylinder(d=41, h=base_duct_height, $fn=100);
}
render() translate([0,(41)/2,0]) {
        translate([hole_separation/2,-hole_separation/2,0])
        cylinder(d=head_dia+1, h=fan_height+5, $fn=18);
        translate([-hole_separation/2,-hole_separation/2,0])
        cylinder(d=head_dia+1, h=fan_height+5, $fn=18);
        translate([hole_separation/2,hole_separation/2,0])
        cylinder(d=head_dia+1, h=fan_height+5, $fn=18);
        translate([-hole_separation/2,hole_separation/2,0])
        cylinder(d=head_dia+1, h=fan_height+5, $fn=18);
}
}
translate([-41/2,0,0])
cube_fillet(size=[41,41,3], radius=-1, vertical=[4,4,4,4], top=[0,0,0,0], bottom=[0,0,0,0], center=false, $fn=0, vertical_fn=[12,12,12,12], top_fn=[0,0,0,0], bottom_fn=[0,0,0,0]);
// mounting tab    
translate([-16/2,-13+3,0])
cube_fillet(size=[16, 13, 10], radius=-1, vertical=[0,0,0,0], top=[4,0,4,0], bottom=[0,0,4,0], center=false, $fn=0, vertical_fn=[12,12,12,12], top_fn=[0,0,0,0], bottom_fn=[0,0,0,0]);
}
difference() {
render() hull() {
translate([-(top_dim_x-myoffset)/2,top_offset+myoffset/2,fan_height-0.2])
rotate([-45,0,0])
#cube_fillet(size=[top_dim_x-myoffset,top_dim_y-myoffset,2], radius=-1, vertical=[0,0,0,0], top=[0,0,0,0], bottom=[0,0,0,0], center=false, vertical_fn=[0,0,0,0], top_fn=[0,0,0,0], bottom_fn=[0,0,0,0]);
translate([0,(41)/2,0])
        cylinder(d=41-myoffset*2, h=base_duct_height-myoffset, $fn=100);
   
}
render() translate([0,(41)/2,0]) {
        translate([hole_separation/2,-hole_separation/2,0])
        cylinder(d=head_dia+1+myoffset*2, h=fan_height+5, $fn=18);
        translate([-hole_separation/2,-hole_separation/2,0])
        cylinder(d=head_dia+1+myoffset*2, h=fan_height+5, $fn=18);
        translate([hole_separation/2,hole_separation/2,0])
        cylinder(d=head_dia+1+myoffset*2, h=fan_height+5, $fn=18);
        translate([-hole_separation/2,hole_separation/2,0])
        cylinder(d=head_dia+1+myoffset*2, h=fan_height+5, $fn=18);
}
}
/*
translate([0,top_offset-3,fan_height+2])
rotate([-90,0,0])
cylinder(d=17, h=top_dim_y+6, $fn=100);
*/
// fan screws
translate([hole_separation/2,4.5,0])
screw_obj_hole(myscrew_obj);
translate([-hole_separation/2,4.5,0])
screw_obj_hole(myscrew_obj);
translate([hole_separation/2,4.5+hole_separation,0])
screw_obj_hole(myscrew_obj);
translate([-hole_separation/2,4.5+hole_separation,0])
screw_obj_hole(myscrew_obj);

// mounting screw
translate([-18/2,mount_screw_head_dia/2-13+3,10-mount_screw_head_dia/2])
rotate([0,90,0])
rotate([0,0,90])
screw_obj_hole(mountscrew_obj);
//mount cutout
translate([0,-6,11/2])
cube([11,10,11], center=true);
translate([0,-6,11/2])
rotate([-45,0,0])
cube([11,10,20], center=true);
}
}

cooling_fan();