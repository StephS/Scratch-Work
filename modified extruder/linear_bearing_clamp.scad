// Tests to check the linear bearing functions
include <print_config.scad>
include <hardware\assy_screw.scad>
include <hardware\func_nuts_screws_washers.scad>
include <hardware\func_linear_bearing.scad>


mounting_screw = screw_obj(screw=screw_M3_socket_head, washer=washer_M3, nut=nut_M3, height=20, head_drop=0, hole_fn=8, hole_support=false, horizontal=true);

screw_hole_separation=30;

my_lb_object = lb_obj(lb=lb_lm8uu, fn=-1, name=-1);

clamp_outer_dia=lb_obj_out_dia(my_lb_object)+single_wall_width*6*2;
clamp_length=lb_obj_length(my_lb_object);

// the offset of the base from the diameter
// p3steel is 13.4
clamp_diameter_offset=13.4-0.3;
clamp_base_offset=clamp_diameter_offset-lb_obj_out_dia(my_lb_object)/2;

// the width of the base (calculated)
clamp_width=clamp_outer_dia + 26;
// the thickness of the base
clamp_base_thickness=4;


echo ("clamp outer dia", clamp_outer_dia);

translate([0,0,clamp_length/2])
difference() {
    //translate([5,5,0])
    hull() {
        cylinder_poly(r=clamp_outer_dia/2, h=clamp_length, center=true);
        translate([-clamp_base_offset-(clamp_base_offset+clamp_base_thickness)/2, screw_hole_separation/2, 0]) {
            rotate([0,90,0])
            cylinder_poly(r=11/2, h=clamp_base_offset+clamp_base_thickness, center=false);
        }
        translate([-clamp_base_offset-(clamp_base_offset+clamp_base_thickness)/2, -screw_hole_separation/2, 0]) {
            rotate([0,90,0])
            //cylinder_poly(r=11/2, h=clamp_base_thickness, center=false);
            cylinder_poly(r=11/2, h=clamp_base_offset+clamp_base_thickness, center=false);
        }
//        cube([clamp_base_thickness, clamp_width, clamp_length]);
    }
    translate([-30-clamp_base_offset, -clamp_width/2, -clamp_length/2])
    cube([30, clamp_width, clamp_length]);
    linear_bearing_negative(my_lb_object, rod_length = 100, center=true);
    translate([-clamp_base_offset,screw_hole_separation/2,0])
    rotate([0,90,0])
    {
        rotate([0,0, 180])
        screw_obj_hole(mounting_screw);
        translate([0,0,clamp_base_thickness-1])
        rotate([0,0, 180/6])
        nut_obj_hole(mounting_screw, thickness=7);
    }
    translate([-clamp_base_offset,-screw_hole_separation/2,0])
    rotate([0,90,0])
    {
        rotate([0,0, 180])
        screw_obj_hole(mounting_screw);
        translate([0,0,clamp_base_thickness-1])
        rotate([0,0, 180/6])
        nut_obj_hole(mounting_screw, thickness=7);
    }
}

//linear_bearing_negative(my_lb_object, rod_length = 100, center=true);

//linear_bearing(my_lb_object, center=true);