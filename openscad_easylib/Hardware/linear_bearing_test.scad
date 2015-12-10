// Tests to check the linear bearing functions
include <..\print_config.scad>
include <assy_screw.scad>
include <func_nuts_screws_washers.scad>
include <func_linear_bearing.scad>


my_lb_object = lb_obj(lb=lb_lm8uu, fn=-1, name=-1);

difference() {
    translate([5,5,0])
    cube([10,10,40], center=true);
    #linear_bearing_negative(my_lb_object, rod_length = 100, center=true);
}

linear_bearing(my_lb_object, center=true);