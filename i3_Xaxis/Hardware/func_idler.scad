include <../inc/functions.scad>
include <obj_idler.scad>
include <func_nuts_screws_washers.scad>

module idler_from_object(idler_object, center=false){
    //makes idler
    bearing=idler_obj_bearing(idler_object);
    bearing_flange_width = bearing_flange_width(bearing);
    bearing_width = bearing_width(bearing);
    washer=idler_obj_washer(idler_object);
    washer_thickness=(washer != -1) ? washer_thickness(washer) : 0;
    
    center_offset= bearing_width/2 + ((washer != -1 ) ? washer_thickness : 0);
    
    if (washer_thickness < bearing_flange_width) echo("Error, Require thicker washer for idler object that has flange.");
        
    echo("center_offset", center_offset);
    
    translate([0,0, (center) ? 0 : center_offset]) {
        if (washer != -1) {
            translate ([0,0, bearing_width/2 + washer_thickness/2])
                washer(washer, center=true);
            translate ([0,0, -bearing_width/2 - washer_thickness/2])
                washer(washer, center=true);
        }
    
        bearing(bearing, center=true);
    }
}

module idler_obj_hole(idler_object, width=-1, center = false) {
    idler_hole_object = idler_obj_tolerance(idler_object);
    
    //echo("idler fn", idler_obj_hole_fn(idler_object));
    //echo("idler dia", _idler_obj_outer_dia(idler_obj_bearing(idler_object), idler_obj_washer(idler_object), idler_obj_belt(idler_object)) + idler_obj_diameter_tolerance(idler_object));
    outer_dia = idler_obj_outer_dia(idler_hole_object);
    idler_width = (width > 0) ? width : idler_obj_width(idler_hole_object);
    _cylinder(h=idler_width, r=outer_dia/2, fn=idler_obj_hole_fn(idler_object), center=center);
}

module bearing(bearing, center=false){
    //makes a bearing
    bearing_dia = bearing_out_dia(bearing);
    bearing_flange_dia = bearing_flange_dia(bearing);
    bearing_double_flange = bearing_double_flange(bearing);
    bearing_flange_width = bearing_flange_width(bearing);
    bearing_inn_dia = bearing_inn_dia(bearing);
    bearing_width = bearing_width(bearing);
    
    center_offset= bearing_width/2 + ((bearing_flange_width > 0 ) ? bearing_flange_width : 0);
    
    translate([0,0, (center) ? 0 : center_offset]) {
        render() difference() {
            _cylinder(h = bearing_width, d=bearing_dia, center=true);
            _cylinder(h = bearing_width+1, d=bearing_inn_dia, center=true);
        }
        if (bearing_flange_dia > 0) {
            translate ([0,0,-bearing_width/2 - bearing_flange_width/2])
                render() difference() {
                    _cylinder(h = abs(bearing_flange_width), d = bearing_flange_dia, center=true);
                    _cylinder(h = abs(bearing_flange_width)+1, d = bearing_dia-2, center=true);
                }
            if (bearing_double_flange)
                translate ([0,0,bearing_width/2 + bearing_flange_width/2])
                render() difference() {
                    _cylinder(h = abs(bearing_flange_width), d = bearing_flange_dia, center=true);
                    _cylinder(h = abs(bearing_flange_width)+1, d = bearing_dia-2, center=true);
                }
        }
    }
}

//idler_from_object(idler_obj(bearing=bearing_608_printrbot_guides, screw_object=-1, washer=washer_M8_double, name=-1), center=true);
//myIdler = idler_obj(bearing=bearing_F623zz, screw_object=-1, washer=washer_M3, name=-1);


//bearing(bearing_F623zz, center=false);