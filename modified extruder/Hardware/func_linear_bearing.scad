// NOTE: This file is grossly out of date. Attribution is incorrect (the code needs to be completely rewritten from scratch)
// PRUSA iteration3
// Bushing/bearing housings
// GNU GPL v3
// Josef Pr?ša <josefprusa@me.com>
// Václav 'ax' H?la <axtheb@gmail.com>
// http://www.reprap.org/wiki/Prusa_Mendel
// http://github.com/prusajr/PrusaMendel
include <obj_linear_bearing.scad>
include <tolerances.scad>
include <..\print_config.scad>
include <..\inc\functions.scad>


// ensure that the part length is at least the length of bushing barrel plus add
function adjust_bushing_len(lb, h, add=layer_height*2) = ((lb_length(lb)+add) > h) ? lb_length(lb)+add : h;

//distance from the flat side of bushing holder to rod center
function bushing_foot_len(lb, h=10.5, add=lb_tolerance_diameter/2) = ((lb_out_dia(lb)/2+add) > h) ? lb_out_dia(lb)/2+add : h;

function bushing_clamp_outer_radius(lb) = lb_out_dia(lb)/2 + lb_tolerance_diameter/2;

module linear_bearing_negative(lb_object, rod_length = -1, center){
    // return simple negative stretched all along and a smooth rod
    echo ("dia1", lb_obj_out_dia(lb_object));
    lb_hole_object = lb_obj_tolerance(lb_object);
    
    echo ("dia2", lb_obj_out_dia(lb_hole_object));
    
    length = (rod_length == -1) ? lb_obj_length(lb_object)+2 : rod_length;
    
    translate([0, 0, (center) ? 0 : lb_obj_length(lb_hole_object)/2]) {
        rotate([0,0, 180/lb_obj_fn(lb_hole_object)]) cylinder_poly(r=lb_obj_rod_dia(lb_hole_object)/2, h=length, fn=lb_obj_fn(lb_hole_object), center=true);
        rotate([0,0, 180/lb_obj_fn(lb_hole_object)]) cylinder_poly(r=lb_obj_out_dia(lb_hole_object)/2, h=lb_obj_length(lb_hole_object), fn=lb_obj_fn(lb_object), center=true);
    }
}

module linear_bearing(lb_object, center){
    // return simple negative stretched all along and a smooth rod
    
    translate([0, 0, (center) ? 0 : lb_obj_length(lb_object)/2]) {
        difference () {
            rotate([0,0, 180/lb_obj_fn(lb_object)]) cylinder_poly(r=lb_obj_out_dia(lb_object)/2, h=lb_obj_length(lb_object), fn=lb_obj_fn(lb_object), center=true);
            rotate([0,0, 180/lb_obj_fn(lb_object)]) cylinder_poly(r=lb_obj_rod_dia(lb_object)/2, h=lb_obj_length(lb_object), fn=lb_obj_fn(lb_object)+0.02, center=true);
        }
    }
}