// Greg's Wade Extruder. 
// It is licensed under the Creative Commons - GNU GPL license. 
//  2010 by GregFrost
// Extruder based on prusa git repo.
// http://www.thingiverse.com/thing:6713

include <inc/functions.scad>;
include <Hardware/func_nuts_screws_washers.scad>;
include <Hardware/func_idler.scad>;
include <Hardware/func_motors.scad>;

// hotend mount dimensions
//[[top_dia, top_thickness], [bottom_dia, bottom_thickness]]
e3d_mount_array=[[16, 3.7], [12,6]];
// array starts from top (entrance) to bottom, with the thickness of the tip, groove, and bottom. Add these together for the total cutout height.
e3d_hotend_height=62;

// width of the hotend mount
//[[top_dia, top_thickness], [bottom_dia, bottom_thickness]]
jhead_mount_array=[[15.9,4.76], [12,4.64]];

hotend_mount_tolerance=0.1;
hotend_mount_array=e3d_mount_array;

hotend_mount_thickness=hotend_mount_array[0][1]+hotend_mount_array[1][1];

// Main dimensions
// offset determined by the motor flange height (2mm + clearance)
motor_z_offset=2+0.2;

// height of the hotend clamp
hotend_mount_clamp_thickness=motor_z_offset;

// thickness of the base (support below the hotend mount)
body_base_thickness=2;

// height of the main body
main_body_height=hotend_mount_array[0][0]+body_base_thickness+hotend_mount_clamp_thickness;

// diameter of the flange for the motor
motor_flange_diameter=22;
// size of the plate for the motor
motor_plate_size=[42,42,main_body_height];
// motor screw hole location (need all +/- combinations)
motor_screw_xy=[15.5, 15.5];
// motor screw to plate edge distance (useful for radius)
motor_screw_to_edge=motor_plate_size[0]/2-motor_screw_xy[0];

// the size of the mounting plate (oriented with the rest of the extruder)
motor_screws=screw_obj(screw=screw_M3_socket_head, height=motor_plate_size[2]);
my_motor=motor_obj(motor=motor_nema17, screw_objects=[motor_screws, -1, motor_screws, motor_screws], name="nema 17 motor");

// diameter of the hobbed gear
// MK8 is 9mm with 1mm deep hobb
hobb_gear_diameter=9;
hobb_gear_hobb_depth=1;

// tolerance for the idler and drive gear (added to diameter, halve for radius)
idler_tolerance=2;

// bearing
filament_idler_bearing=bearing_624ZZ;
filament_idler_screw=screw_obj(screw=screw_M4_button_head, height=motor_plate_size[2], head_drop=screw_head_height(screw_M4_button_head)+motor_z_offset, hole_support=false);

// idler object with 2mm diameter tolerance
filament_idler_obj = idler_obj(bearing=set_bearing_tolerance(filament_idler_bearing, tolerance_dia=idler_tolerance), screw_object=-1, washer=washer_M4, name=-1);

// set the tolerance for the hole object (bearing dia + tolerance dia)
filament_idler_hole_obj = idler_obj_tolerance(filament_idler_obj);

// outer diameter for idler
idler_hole_dia=idler_obj_outer_dia(filament_idler_hole_obj);
idler_outer_dia=idler_obj_outer_dia(filament_idler_obj);

// outer dimension for the hobbed gear hole
// use idler tolerance to be consistant
hobb_gear_hole_dia=hobb_gear_diameter+idler_tolerance;

// filament diameter
filament_dia=1.9;

// filament z location (center)
filament_z_loc=hotend_mount_array[0][0]/2+body_base_thickness;
filament_x_loc=hobb_gear_diameter/2-hobb_gear_hobb_depth+filament_dia/2;
// additional thickness for filiment guide support (-x)
filament_guide_thickness=3;

// center of idler location
idler_x_loc=filament_x_loc+idler_outer_dia/2;
idler_z_loc=filament_z_loc;
//distance from the center of the idler to the edge of the plate
idler_center_to_edge=motor_plate_size[0]/2-idler_x_loc;

// the screw for the idler hinge. Screw length should be body height
idler_hinge_screw_obj = screw_obj(screw=screw_M3_socket_head, washer=washer_M3, nut=nut_M3, height=motor_plate_size[2]);

// slot length
idler_spring_nut_slot=2;
// idler screws for springs
idler_spring_screw_obj = screw_obj(screw=screw_M3_socket_head, washer=washer_M3, nut=nut_M3, height=50, slot_length=idler_spring_nut_slot, horizontal=true);

// distance between the two spring screws
idler_spring_separation=(filament_z_loc-screw_obj_nut_flat(idler_spring_screw_obj)/2-1.5);
idler_spring_z_center=filament_z_loc;
// distance between the top (+y) of the extruder and the center of the screw
// gap is set for 2mm of material
idler_spring_y_offset=-(2+screw_obj_screw_dia(idler_spring_screw_obj));
// x offset for nut placement
idler_spring_nut_x_offset=screw_obj_nut_thickness(idler_spring_screw_obj);
// additional offset for idler spring screw hole
idler_spring_x_offset=idler_spring_nut_x_offset+5;

// idler hinge screw (screws into motor)
idler_hinge_screw_obj=screw_obj(screw=screw_M3_socket_head, height=motor_plate_size[2], head_drop=washer_thickness(v_washer_hole(washer_M3)), washer=washer_M3);

idler_hinge_diameter=motor_screw_to_edge-2;
idler_hinge_support_thickness=4;

// screws used for the groovemount clamp
groove_clamp_screw_obj = screw_obj(screw=screw_M3_socket_head, washer=washer_M3, nut=nut_M3, height=motor_plate_size[2]);
// distance between the screw holes
groove_clamp_hole_separation=16+screw_obj_screw_dia(groove_clamp_screw_obj)+2;

// offset of clamp from the motor plate
groove_body_offset_y=1;
// length of the groove mount body
groove_body_y_size=hotend_mount_thickness+groove_body_offset_y;
// width of the clamp
groove_body_x_size=groove_clamp_hole_separation+screw_obj_screw_head_top_dia(groove_clamp_screw_obj)+2;
// height of the groovemount body part
groove_body_z_size=filament_z_loc+2;

// length of the clamp (equal to hotend height)
groove_clamp_z_size=hotend_mount_thickness;
// width of the clamp
groove_clamp_x_size=body_base_thickness+hotend_mount_thickness+2-(groove_body_z_size);

//
groove_clamp_thickness=motor_plate_size[2]-hotend_mount_thickness-body_base_thickness;
// additional tolerance for the hole
groove_clamp_tolerance=0.1;

//


// the screw object for the mounting plate (TODO: change to m3 after new carriage is designed)
mounting_screw_obj = screw_obj(screw=screw_M4_socket_head, washer=washer_M4, nut=nut_M4, height=20, horizontal=true);
// locations of the mounting holes for the I3 Rework
mounting_hole_locations=[[11.5, 11.5], [-11.5, 11.5], [11.5, -11.5], [-11.5, -11.5]];
// gap offset from the mounting plate
mounting_gap=1;

// the size of the mounting plate (oriented with the rest of the extruder)
carriage_plate_size=[10,34,34];
// the screw object for the mounting plate (TODO: change to m3 after new carriage is designed)
carriage_screw_obj = screw_obj(screw=screw_M4_socket_head, washer=washer_M4, nut=nut_M4, height=20, horizontal=true);
// locations of the mounting holes for the I3 Rework
carriage_hole_locations=[[11.5, 11.5], [-11.5, 11.5], [11.5, -11.5], [-11.5, -11.5]];
carriage_motor_gap=1;


//groove_mount_clamp_x=mounting_plate_size[0]-filament_center_location*2;
//groove_mount_clamp_z=3;
//groove_mount_clamp_y=my_hotend_array[0]+my_hotend_array[1];

// motor flange z offset=2.2


fan_screw=screw_obj(screw=screw_M3_socket_head, height=20);
fan_mount_width=6;
//fan_mount_size=[groove_clamp_length,fan_mount_width,groove_clamp_length];

module extruder_body() {
        union() {
            
            // *** motor support cylinders ***
            translate([motor_screw_xy[0], motor_screw_xy[1], 0])
                //rotate([0,0,90])
                cylinder_poly(r=motor_screw_to_edge ,h=motor_plate_size[2]);
            //translate([-motor_screw_xy[0], motor_screw_xy[1], 0])
            //    cylinder_poly(r=motor_screw_to_edge ,h=motor_plate_size[2]);
            translate([motor_screw_xy[0], -motor_screw_xy[1], 0])
                cylinder_poly(r=motor_screw_to_edge ,h=motor_plate_size[2]);
            translate([-motor_screw_xy[0], -motor_screw_xy[1], 0])
                rotate([0,0,90])
                cylinder_poly(r=motor_screw_to_edge ,h=motor_plate_size[2]);            
            // *** END: motor support cylinders ***
            
            // *** top piece ***
            translate([ 0,motor_plate_size[1]/2-(motor_plate_size[1]-hobb_gear_hole_dia)/2, 0])
                _cube([motor_plate_size[1]/2-motor_screw_to_edge, (motor_plate_size[1]-hobb_gear_hole_dia)/2, motor_plate_size[2]]);
            hull() {
                // top block for filament support
                translate([ -(filament_x_loc),motor_plate_size[1]/2-(motor_plate_size[1]-hobb_gear_hole_dia)/2, 0])
                    _cube([motor_plate_size[1]/2+filament_x_loc-motor_screw_to_edge, (motor_plate_size[1]-hobb_gear_hole_dia)/2, filament_z_loc+filament_dia/2+filament_guide_thickness]);
                // filament support
                translate([-filament_x_loc, motor_plate_size[1]/2-(motor_plate_size[1]-hobb_gear_hole_dia)/2, filament_z_loc])
                    rotate([-90,0,0])
                    cylinder(r=filament_dia/2+filament_guide_thickness, h=(motor_plate_size[1]-hobb_gear_hole_dia)/2, $fn=16);
            }
            // *** END: top piece ***
            
            // *** +x piece ***
            _cube([motor_plate_size[0]/2, motor_screw_xy[1]*2, motor_plate_size[2]], center=[false,true,false]);
            
            // *** bottom block ***
            translate([ 0,-motor_plate_size[1]/2, 0]) {
                _cube([motor_screw_xy[0]*2, motor_screw_to_edge*2, motor_plate_size[2]], center=[true,false,false]);
            }
            hull() {
            translate([ motor_screw_to_edge/2, -motor_plate_size[1]/2, 0])
                _cube([motor_screw_xy[0]*2-motor_screw_to_edge, (motor_plate_size[1])/2-hobb_gear_hole_dia/2, filament_z_loc+filament_dia/2+filament_guide_thickness], center=[true,false,false]);
            translate([-motor_screw_xy[0], -motor_screw_xy[1], 0])
                rotate([0,0,90])
                cylinder_poly(r=motor_screw_to_edge ,h=filament_z_loc+filament_dia/2+filament_guide_thickness);            
            }
            // bottom filament entrance hole
            translate([-filament_x_loc, 0, 0])
                filament_support();
        }
}

module groove_mount_body() {
    translate([0, -groove_body_y_size, 0])
    _cube([groove_body_x_size, groove_body_y_size+0.01, groove_body_z_size], center=[true, false, false]);
}

module extruder() {
    difference() {
        union() {
            extruder_body();
            translate([0, -motor_plate_size[1]/2, 0])
            groove_mount_body();
        }
        hobb_and_motor_flange_hole();
        translate([-idler_x_loc,0,0])
            idler_hole();
        translate([-filament_x_loc, motor_plate_size[1]/2,filament_z_loc])
            filament_hole();
    }
}

// filament entrance hole
module filament_support() {
    translate([0, -hobb_gear_hole_dia/2-0.01, 0])
        _cube([(filament_dia/2+filament_guide_thickness)*2, hobb_gear_hole_dia/2+0.01, filament_z_loc+filament_dia/2+filament_guide_thickness], center=[true, false, false]);
}


module hobb_and_motor_flange_hole() {
    rotate([0,0,90])
    cylinder_poly(r=hobb_gear_hole_dia/2, h=motor_plate_size[2]);
    translate([0,0,(filament_z_loc+filament_dia/2+filament_guide_thickness)])
        cylinder_poly(r=motor_flange_diameter/2, h=motor_plate_size[2]-(filament_z_loc+filament_dia/2+filament_guide_thickness)+0.01);
}

module idler_hole() {
    cylinder_poly(r=(idler_hole_dia/2), h=motor_plate_size[2]);
    translate([-idler_center_to_edge, 0, 0])
    _cube([idler_center_to_edge, (idler_hole_dia/2)*2, motor_plate_size[2]], center=[false,true,false]);
}

module filament_hole() {
    rotate([90,0,0])
        rotate([0,0, 180/16])
            translate([0,0,-0.01])
            cylinder(d=hole_fit(filament_dia,16), h=motor_plate_size[1]+0.02, center=false, $fn=16);
}

module hubb_idler_shadow() {
    %cylinder_poly(r=(hobb_gear_diameter/2), h=motor_plate_size[2]);
    translate([-idler_x_loc,0,idler_z_loc])
        %idler_from_object(idler_object=filament_idler_obj ,center=true);
}

hubb_idler_shadow();


/*
module hobb_and_motor_flange_hole() {
    rotate([0,0,90])
    cylinder_poly(r=hobb_gear_hole_dia/2, h=motor_plate_size[2]);
    difference() {
    //translate([0,0,(filament_z_loc+filament_dia/2+filament_guide_thickness)])
        //cylinder_poly(r=motor_flange_diameter/2, h=motor_plate_size[2]-(filament_z_loc+filament_dia/2+filament_guide_thickness)+0.01);
        cylinder_poly(r=motor_flange_diameter/2, h=motor_plate_size[2]+0.01);
    translate([-filament_x_loc, -motor_plate_size[1]/2, filament_z_loc])
                    rotate([-90,0,0])
                    cylinder(r=filament_dia/2+filament_guide_thickness, h=motor_plate_size[1], $fn=16);    
        translate([-filament_x_loc,0,0])
        _cube([ filament_dia+filament_guide_thickness*2,motor_plate_size[1], filament_z_loc], center=[true,true,false]);
        
    }
}
*/

/*
//rotate([0,0,-90])
//            hotend_mount_hole(jhead_mount_height_array, jhead_mount_width, jhead_groove_width, slot_length=main_body_size[Z_AXIS]/2, fn=64);
module idler_spring_holes() {
            
        rotate([0,-90,0])
        rotate([0,0,90]) {
            translate([0,0,-5])
        screw_obj_hole(idler_spring_screw_obj);
            //rotate([0,0,180])
            nut_obj_hole(screw_object=idler_spring_screw_obj, thickness=0, nut_slot=10);
        }
        echo(idler_spring_separation);
        translate([0,0,mounting_plate_size[2]-(2+nut_flat(screw_obj_nut(idler_spring_screw_obj))+2)])
        rotate([0,-90,0])
        rotate([0,0,90]) {
            translate([0,0,-5])
        screw_obj_hole(idler_spring_screw_obj);
            //rotate([0,0,180])
            nut_obj_hole(screw_object=idler_spring_screw_obj, thickness=0, nut_slot=10);
        }
}


module idler_spring_holes2() {
            
        rotate([0,-90,0])
        rotate([0,0,90]) {
            translate([0,0,0])
        screw_obj_hole(idler_spring_screw_obj);
            //rotate([0,0,180])
        }
        echo(idler_spring_separation);
        translate([0,0,mounting_plate_size[2]-(2+nut_flat(screw_obj_nut(idler_spring_screw_obj))+2)])
        rotate([0,-90,0])
        rotate([0,0,90]) {
            translate([0,0,0])
        screw_obj_hole(idler_spring_screw_obj);
            //rotate([0,0,180])
        }
}


module groove_mount_holes(filament_z_height=0, use_nuts=true)
{
    groove_mount_clamp_holes(hotend_height_array=my_hotend_array, hole_separation=groove_clamp_hole_separation,use_nuts=use_nuts);
    translate([0,0,filament_z_height])
    hotend_mount_hole(my_hotend_array, my_hotend_mount_width, my_hotend_groove_width, slot_length=20, fn=64);    
}

module groove_mount_clamp_holes(hotend_height_array, hole_separation, use_nuts=true) {
            // holes for groove mount clamp
   translate([0,-(hotend_height_array[0]+hotend_height_array[1])/2,0]) {
        translate([-hole_separation/2,0,0]) {

            if(use_nuts==true) {
                difference() {
                    union() {
                        nut_obj_hole(groove_clamp_screw_obj);
                        screw_obj_hole(groove_clamp_screw_obj);
                    }
                    translate([0,0,screw_obj_nut_thickness(screw_obj_tolerance(groove_clamp_screw_obj))])
                    cylinder(d=4, h=0.2);
                }
            }
            else {
                screw_obj_hole(groove_clamp_screw_obj);
            }
        }
        translate([hole_separation/2,0,0]) {
            
            if(use_nuts==true) {
                difference() {
                    union() {
                        nut_obj_hole(groove_clamp_screw_obj);
                        screw_obj_hole(groove_clamp_screw_obj);
                    }
                    translate([0,0,screw_obj_nut_thickness(screw_obj_tolerance(groove_clamp_screw_obj))])
                    cylinder(d=4, h=0.2);
                }
            }
            else {
                screw_obj_hole(groove_clamp_screw_obj);
            }
        }
    }
}



module carriage_mount() {
    difference () {
        union() {
            cube(carriage_plate_size);
            translate([-carriage_motor_gap-0.01, 0, 0])
            cube([carriage_motor_gap+0.02, carriage_plate_size[1], motor_plate_size[2]]);
        }
        translate([carriage_plate_size[0],carriage_plate_size[1]/2,carriage_plate_size[2]/2]){
            translate([0,carriage_hole_locations[0][0], carriage_hole_locations[0][1]])
                rotate([0,-90,0]) {
                    screw_obj_hole(carriage_screw_obj);
                    translate([0,0,3.5])
                    nut_obj_hole(carriage_screw_obj, nut_slot=20);
                }
            translate([0,carriage_hole_locations[1][0], carriage_hole_locations[1][1]])
                rotate([0,-90,0]) {
                    screw_obj_hole(carriage_screw_obj);
                    translate([0,0,3.5])
                    nut_obj_hole(carriage_screw_obj, nut_slot=20);
                }
            translate([0,carriage_hole_locations[2][0], carriage_hole_locations[2][1]])
                rotate([0,-90,0]) {
                    screw_obj_hole(carriage_screw_obj);
                    translate([0,0,3.5])
                    rotate([0,0,180])
                    nut_obj_hole(carriage_screw_obj, nut_slot=20);
                }
            translate([0,carriage_hole_locations[3][0], carriage_hole_locations[3][1]])
                rotate([0,-90,0]) {
                    screw_obj_hole(carriage_screw_obj);
                    translate([0,0,3.5])
                    rotate([0,0,180])
                    nut_obj_hole(carriage_screw_obj, nut_slot=20);
                }
        }
    }
}


module hotend_mount_hole(hotend_height_array, mount_width, groove_width, slot_length=0, z_offset=0, filament_hole_length=100, fn=64) {
    groove_hole_width=hole_fit(groove_width+hotend_mount_tolerance,fn);
    groove_mount_width=hole_fit(mount_width+hotend_mount_tolerance,fn);
    translate([0,0,z_offset])
    rotate([90,0,0])
    rotate([0,0,90]){
    rotate([180,0,0])
        rotate([0,0, 180/16]) cylinder(d=hole_fit(filament_dia,16), h=filament_hole_length, center=false, $fn=16);
    
    translate([0,0,hotend_height_array[0]-0.01])
    cylinder_slot(r=groove_hole_width/2, h=hotend_height_array[1]+0.02, center=false, $fn=fn);
    translate([0,0,hotend_height_array[0]-0.01])
        translate([slot_length/2,0,(hotend_height_array[1]+0.02)/2]) 
        cube([slot_length, groove_mount_width, hotend_height_array[1]+0.02], center=true);
    translate([0,0,0])
    cylinder_slot(r=groove_mount_width/2, h=(hotend_height_array[0]), center=false, $fn=fn);
    translate([slot_length/2,0,hotend_height_array[0]/2]) 
        cube([slot_length, groove_mount_width, hotend_height_array[0]], center=true);
    }
}



module idler() {
    difference() {
        union() {
            // main block
            //cube_fillet([somevar+idler_hinge_diameter/2,42-somevar+idler_hinge_diameter/2,mounting_plate_size[2]], vertical=[0,0,0,(idler_hinge_diameter)/2],center=false);
            hull() {
            translate([0,idler_hinge_diameter/2,0])
                cube_fillet([somevar+idler_hinge_diameter/2,42-somevar,mounting_plate_size[2]-0.1], vertical=[0,0,0,0],center=false);
                translate([hinge_screw_x, hinge_screw_y, 0])
                cylinder_poly(r=idler_hinge_diameter/2, h=mounting_plate_size[2]-0.1, center=false);
            }
            // thingy for opening idler
            translate([0, idler_hinge_diameter/2+(42-somevar)-0.01, 0])
                  cube_fillet([(somevar+idler_hinge_diameter/2)/2,somevar+idler_hinge_diameter/2+0.01,mounting_plate_size[2]-0.1], vertical=[(somevar+idler_hinge_diameter/2)/2-1,0,0,0],center=false);  
            // idler cylinder block
            translate([-filament_center_location-idler_outer_dia/2+42/2,hinge_screw_y-somevar+42/2,0])
            cylinder_poly(r=idler_outer_dia/2-1, h=mounting_plate_size[2]-0.1, center=false);
            
        }
        // cutout for hinge support
        cube([somevar+idler_hinge_diameter/2, idler_hinge_diameter+4.5, idler_hinge_support_thickness+0.1]);
        // hinge screw
        translate([hinge_screw_x, hinge_screw_y, 0]) {
            translate([0, 0, idler_hinge_support_thickness])
                screw_obj_hole(hinge_screw);
            translate([0, 0, mounting_plate_size[2]])
                rotate([180,0,0])
                screw_obj_hole(hinge_screw);
        }
        // idler bearing
        translate([-filament_center_location-idler_outer_dia/2+42/2,hinge_screw_y-somevar+42/2,0]) {
            translate([0,0,mounting_plate_size[2]/2])
            idler_obj_hole(idler_object=filament_idler_obj ,center=true);
            translate([0,0,motor_plate_size[2]+0.001])
            rotate([180,0,0])
            screw_obj_hole(idler_screw);
        }
        translate([somevar+idler_hinge_diameter/2,-spring_screw_y_offset+hinge_screw_y-somevar+42,2+nut_flat(screw_obj_nut(idler_spring_screw_obj))/2])
        idler_spring_holes2();
    }
    // shadow idler bearing
    %translate([-filament_center_location-idler_outer_dia/2+42/2,hinge_screw_y-somevar+42/2,mounting_plate_size[2]/2])
        idler_from_object(idler_object=filament_idler_obj ,center=true);
}

// clamp piece
module hotend_clamp() {
    difference() {
        union() {
            translate([0,clamp_size[1]/2,clamp_size[2]/2])
            cube(clamp_size, center=true);
            // grove mount part
            translate([0,clamp_size[1]+(groove_mount_clamp_z+my_hotend_mount_width/2-3.1)/2, clamp_size[2]/2]) {
            cube([my_hotend_mount_width-0.2,groove_mount_clamp_z+my_hotend_mount_width/2-3.1, clamp_size[2]], center=true);
            //cube([my_hotend_groove_width-0.2,groove_mount_clamp_z+my_hotend_mount_width/2-4, clamp_size[2]], center=true);
            
            }
            
            translate([0,-clamp_size[2]/2,clamp_size[2]/2])
            cube_fillet([fan_mount_width,clamp_size[2],clamp_size[2]], center=true, vertical=[0,0,0,0], top=[0,0,clamp_size[2]/2,0]);
        }
        translate([-fan_mount_width/2,-clamp_size[2]/2,clamp_size[2]/2])
        rotate([0,90,0])
        screw_obj_hole(fan_screw);
        translate([0,0.00,clamp_size[2]+0.1])
        rotate([-90,0,0])
        rotate([0,0,180])
        groove_mount_holes(filament_z_height=my_hotend_mount_width/2+3, use_nuts=false);
    }
}
*/

/*
translate([-filament_center_location, -1-clamp_size[2]-0.1, mounting_plate_size[2]])
rotate([-90,0,0])
hotend_clamp();
*/

//hotend_clamp();


extruder();

//translate([-42/2, somevar-idler_hinge_diameter/2, 0])
//idler();


// for printing
/*
rotate ([0,-90,0])
idler();
*/