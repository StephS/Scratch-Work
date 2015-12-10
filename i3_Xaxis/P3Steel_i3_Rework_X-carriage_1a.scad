//-- Prusa i3 Rework X carriage imported and added
//-- 30mm space Wade's extruder M3 holes
//-- by AndrewBCN - Barcelona, Spain - December 2014
//-- Remix from X-CARRIAGE.stl from Thingiverse # 119616
//-- by eMotion-Tech
//-- GNU-GPL

//-- import test

$fn=32;

disth=23; // distance Wade's extruder mount holes
pos=-11.5; // position of holes relative to centerline

module xcar() {
rotate([0,0,0]) 
  //difference() {
    
    translate([0,0,0]) import("P3Steel_i3_Rework_X-carriage_1a.stl");
    translate([0,0,6])
    cube([56,68,12],center=true);
    // Wade's extruder M3 mount holes and nut traps
    translate([+disth/2,pos,-1])cylinder(r=4.3/2, h=30, $fn=32);
    translate([-disth/2,pos,-1])cylinder(r=4.3/2, h=30, $fn=32);
    //}
}

xcar();