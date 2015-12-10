//-- Direct Drive servo mount remix
//-- by AndrewBCN - Barcelona, Spain - November 2014
//-- GPLV3
//-- from an original design by Gumpwa Luong (Thingiverse #559745)

//-- this small piece is used to mount a servo for auto bed leveling

//-- import test

$fn=64;

// first we import the original part stl and then reverse-engineer
// an identical part

//translate([30,30,8]) import("wilson_servo.stl");
//translate([0,2,8]) import("wilson_servo.stl");

module servo_holder() {
  difference() {
    // base part
    translate([0,0,0]) cube([34.4,23.6,6],center=true);
    
    // carve out the servo and the small angles

    // small angles
    translate([34.4/2,23.6/2+1,0]) rotate ([0,0,-50]) cube([10,8,8],center=true);
    translate([-34.4/2,23.6/2+1,0]) rotate ([0,0,50]) cube([10,8,8],center=true);
    
    // servo
    translate([0,2,0]) cube([23,12.4,8],center=true);

    // servo screw holes
    translate([-23/2-2.5,2,0]) cylinder(r=0.6, h=20, center=true);
    translate([23/2+2.5,2,0]) cylinder(r=0.6, h=20, center=true);

    // hotend carvings
    //translate([0,9.8,9.5]) rotate([90,0,0]) cylinder(r=6, h=20, center=true);
    //translate([0,-10.1,10]) rotate([90,0,0]) cylinder(r=8, h=20, center=true);
    }   
  // vertical part
  difference() {
    union() {
      translate([-34.4/2,-23.6/2,0]) cube([34.4,5,28]);
      translate([-34.4/2,-23.6/2-16+5,28-5]) cube([34.4,16,5]);
      hull() {
        translate([-34.4/2,-23.6/2,-3]) cube([3,5,28]);
        translate([-34.4/2,-23.6/2-16+5,28-5]) cube([3,16,5]);
      }
      hull() {
        translate([34.4/2-3,-23.6/2,-3]) cube([3,5,28]);
        translate([34.4/2-3,-23.6/2-16+5,28-5]) cube([3,16,5]);
      }
      hull() {
        translate([-33/2,-23.6/2,20-3]) cube([33,5,2]);
        translate([-33/2,-23.6/2-16+5,28-5]) cube([33,16,5]);
      }
    }
    translate([-35.4/2,-23.6/2+6,28-4]) rotate([60,0,0]) cube([35.4,16,16]);
    translate([-35.4/2,-23.6/2+6,28-7.7]) rotate([30,0,0]) cube([35.4,16,16]);
    
    // screw holes and nut traps
    translate([-35.4/2+6.1,-23.6/2-5.6,26]) cylinder(r=1.7, h=10, center=true);
    translate([+35.4/2-6.1,-23.6/2-5.6,26]) cylinder(r=1.7, h=10, center=true);
    // nuts
    translate([-35.4/2+6.1,-23.6/2-5.6,20]) cylinder(r=3.4, h=6, $fn=6, center=true);
    translate([+35.4/2-6.1,-23.6/2-5.6,20]) cylinder(r=3.4, h=6, $fn=6, center=true);
  }
}

module extruder_attach() {

}


// print the part
// servo_holder
//translate([0,0,8/2]) rotate([-90,0,90]) clamp();
translate([0,0,6/2]) servo_holder();
// now attach the servo holder to the extruder - we use existing screws
extruder_attach();
// hinge
//translate([-11.5,0,9]) rotate([180,0,0]) hinge();
