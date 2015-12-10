include <inc\hardware.scad>
include <inc\functions.scad>

joint_width=3;

module part1() {
    radi=sagitta_radius(s=5, l=30/2);
    intersection() {
      translate([-30/2,0,0])
      cube([30,20,15]);
      translate([0,radi,0])  
      cylinder(r=radi, h=15, $fn=200);
    }
    
    // joints
    
        difference() {
        joints3();
        translate([0,20+15/2,15/2])
            rotate([0,90,0])
        screw(screw=M3_SCREW_HOLE_DIAMETER, h=20, center=true);
        }
    
}

module joints3() {
    translate([0,20+15/2,15/2]) {
            translate([0,-15/2,0])
    cube([joint_width,15,15], center=true);
    rotate([0,90,0])
    cylinder(d=15, h=joint_width, center=true);
    }
    translate([joint_width*2,20+15/2,15/2]) {
    translate([0,-15/2,0])
    cube([joint_width,15,15], center=true);
    rotate([0,90,0])
    cylinder(d=15, h=joint_width, center=true);
    }
    translate([-joint_width*2,20+15/2,15/2]) {
    translate([0,-15/2,0])
    cube([joint_width,15,15], center=true);
    rotate([0,90,0])
    cylinder(d=15, h=joint_width, center=true);
    }
}

module part2() {
    intersection() {
    translate([-30/2,0,0])
    cube([30,20,15]);
    union() {
        rotate([0,0,10])
    cube([30,30,15]);
    mirror([1,0,0])
    rotate([0,0,10])
    cube([30,30,15]);
    }
    }
    translate([0,20+15/2,15/2]) {
        translate([0,-15/2,0])
    cube([3,15,15], center=true);
    rotate([0,90,0])
    cylinder(d=15, h=3, center=true);
    }
    translate([3+3,20+15/2,15/2]) {
    translate([0,-15/2,0])
    cube([3,15,15], center=true);
    rotate([0,90,0])
    cylinder(d=15, h=3, center=true);
    }
    translate([-3-3,20+15/2,15/2]) {
    translate([0,-15/2,0])
    cube([3,15,15], center=true);
    rotate([0,90,0])
    cylinder(d=15, h=3, center=true);
    }
}


part1();