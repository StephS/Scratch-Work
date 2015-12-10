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
mountscrew_obj = screw_obj(screw=screw_M3_socket_head, nut=nut_M3, height=7, head_drop=3, hole_support=true);

/*
translate([-41/2,0,0])
cube_fillet(size=[41,41,3], radius=-1, vertical=[4,4,4,4], top=[0,0,0,0], bottom=[0,0,0,0], center=false, $fn=0, vertical_fn=[12,12,12,12], top_fn=[0,0,0,0], bottom_fn=[0,0,0,0]);
*/
fan_dia=38;
top_dim_x=19;
top_dim_y=20+5;
top_offset=17-10;
myoffset=1.4;

hole_separation=32;

// 42 - 

mountscrewloc=40.5;

head_dia=screw_obj_screw_head_top_dia(myscrew_obj);

difference() {
    union(){
        difference() {
hull() {
translate([-top_dim_x/2,top_offset,34.5])
cube_fillet(size=[top_dim_x,top_dim_y,2], radius=-1, vertical=[4,4,4,4], top=[0,0,0,0], bottom=[0,0,0,0], center=false, vertical_fn=[12,12,12,12], top_fn=[0,0,0,0], bottom_fn=[0,0,0,0]);
translate([0,41/2,0])
    difference() {
cylinder(d=41, h=4, $fn=100);
translate([-41/2,41/2-7+myoffset,0])
        cube([41,6,4]);
    }
}
render() translate([0,(41)/2,0]) {
        translate([hole_separation/2,-hole_separation/2,0])
        cylinder(d=head_dia+1, h=14, $fn=18);
        translate([-hole_separation/2,-hole_separation/2,0])
        cylinder(d=head_dia+1, h=14, $fn=18);
        translate([hole_separation/2,hole_separation/2,0])
        cylinder(d=head_dia+1, h=14, $fn=18);
        translate([-hole_separation/2,hole_separation/2,0])
        cylinder(d=head_dia+1, h=14, $fn=18);
}
}
translate([-41/2,0,0])
cube_fillet(size=[41,41,3], radius=-1, vertical=[4,4,4,4], top=[0,0,0,0], bottom=[0,0,0,0], center=false, $fn=0, vertical_fn=[12,12,12,12], top_fn=[0,0,0,0], bottom_fn=[0,0,0,0]);
    translate([-13/2,35,0])
    cube([13, 11, 7]);
}
difference() {
render() hull() {
translate([-(top_dim_x-myoffset)/2,top_offset+myoffset/2,34.5])
cube_fillet(size=[top_dim_x-myoffset,top_dim_y-myoffset,2], radius=-1, vertical=[4,4,4,4], top=[0,0,0,0], bottom=[0,0,0,0], center=false, vertical_fn=[12,12,12,12], top_fn=[0,0,0,0], bottom_fn=[0,0,0,0]);
translate([0,(41)/2,0])
    render() difference() {
        cylinder(d=41-myoffset*2, h=4-myoffset, $fn=100);
        translate([-41/2,41/2-6,0])
        cube([41,6,4]);
    }
    
}
render() translate([0,(41)/2,0]) {
        translate([hole_separation/2,-hole_separation/2,0])
        cylinder(d=head_dia+1+myoffset*2, h=14, $fn=18);
        translate([-hole_separation/2,-hole_separation/2,0])
        cylinder(d=head_dia+1+myoffset*2, h=14, $fn=18);
        translate([hole_separation/2,hole_separation/2,0])
        cylinder(d=head_dia+1+myoffset*2, h=14, $fn=18);
        translate([-hole_separation/2,hole_separation/2,0])
        cylinder(d=head_dia+1+myoffset*2, h=14, $fn=18);
}
}
translate([0,top_offset-3,36.5])
rotate([-90,0,0])
cylinder(d=17, h=top_dim_y+6, $fn=100);

translate([hole_separation/2,4.5,0])
screw_obj_hole(myscrew_obj);
translate([-hole_separation/2,4.5,0])
screw_obj_hole(myscrew_obj);
translate([hole_separation/2,4.5+hole_separation,0])
screw_obj_hole(myscrew_obj);
translate([-hole_separation/2,4.5+hole_separation,0])
screw_obj_hole(myscrew_obj);

// mounting screw
translate([0,mountscrewloc,0])
screw_obj_hole(mountscrew_obj);
}
