include <func_idler.scad>

myIdler = idler_obj(bearing=bearing_608_printrbot_guides, screw_object=-1, washer=washer_M8_double, name=-1);
myIdler2 = idler_obj(bearing=bearing_608, screw_object=-1, washer=washer_M8, name=-1);
idler_from_object(myIdler2, center=true);
//translate([10,10,0])
difference() {
    translate([0,0,-25])
    cube([50,50,50]);
    render() idler_obj_hole(myIdler2, center = true);
}