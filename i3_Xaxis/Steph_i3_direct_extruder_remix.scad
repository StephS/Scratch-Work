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
//specifically for the e3d v6
e3d_collet_array=[8, 2.6];
// array starts from top (entrance) to bottom, with the thickness of the tip, groove, and bottom. Add these together for the total cutout height.
e3d_hotend_height=62;

// width of the hotend mount
//[[top_dia, top_thickness], [bottom_dia, bottom_thickness]]
jhead_mount_array=[[15.9,4.76], [12,4.64]];

hotend_mount_tolerance=0.1;
hotend_mount_array=e3d_mount_array;
hotend_use_e3d=true;

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

echo("Motor Mounting screw length=", (motor_plate_size[2] +4));



// diameter of the hobbed gear
// MK8 is 9mm with 1mm deep hobb
hobb_gear_diameter=9;
hobb_gear_hobb_depth=1;

// tolerance for the idler and drive gear (added to diameter, halve for radius)
idler_tolerance=2;

// bearing
filament_idler_bearing=bearing_624ZZ;
filament_idler_screw_head_height=screw_head_height(screw_M4_button_head);
filament_idler_screw=screw_obj(screw=screw_M4_button_head, height=motor_plate_size[2], hole_support=false);
filament_idler_screw_head_diameter=screw_obj_screw_head_top_dia(filament_idler_screw);

// idler object with 2mm diameter tolerance
filament_idler_obj = idler_obj(bearing=set_bearing_tolerance(filament_idler_bearing, tolerance_dia=idler_tolerance), screw_object=-1, washer=washer_M4_printed_0p5, name=-1);
//filament_idler_obj = idler_obj(bearing=set_bearing_tolerance(filament_idler_bearing, tolerance_dia=idler_tolerance), screw_object=-1, name=-1);

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
filament_real_dia=1.75;

// filament z location (center)
filament_z_loc=hotend_mount_array[0][0]/2+body_base_thickness;
filament_x_loc=hobb_gear_diameter/2-hobb_gear_hobb_depth+filament_real_dia/2;
echo("filament x",filament_x_loc);
echo("filament z",filament_z_loc);
// additional thickness for filiment guide support (-x)
// set to 2 if not using ptfe on e3d
filament_guide_thickness=3;

// center of idler location
idler_x_loc=filament_x_loc+filament_real_dia/2+idler_outer_dia/2-0.1;
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
//idler_spring_separation=(filament_z_loc-screw_obj_nut_flat(idler_spring_screw_obj)/2+2);
idler_spring_separation=filament_dia+filament_guide_thickness*2+screw_obj_screw_dia(screw_obj_tolerance(idler_spring_screw_obj));
idler_spring_z_center=filament_z_loc;
// distance between the top (+y) of the extruder and the center of the screw
// gap is set for 2mm of material
idler_spring_y_offset=(-idler_spring_nut_slot-screw_obj_screw_dia(idler_spring_screw_obj)/2)-2;
// x offset for nut placement
idler_spring_nut_x_offset=screw_obj_nut_thickness(idler_spring_screw_obj);
// additional offset for idler spring screw hole
idler_spring_x_offset=idler_spring_nut_x_offset+5;

// idler hinge screw (screws into motor)
idler_hinge_screw_obj=screw_obj(screw=screw_M3_socket_head, height=motor_plate_size[2], head_drop=washer_thickness(v_washer_hole(washer_M3))-0.05, washer=washer_M3);

idler_hinge_radius=motor_screw_to_edge-1;
idler_hinge_hole_radius=idler_hinge_radius+1;
// thickness of the idler hinge support (on both sides of the flange)
idler_hinge_support_thickness=4;
idler_hinge_tab_thickness=motor_plate_size[2]-idler_hinge_support_thickness*2;

fan_screw=screw_obj(screw=screw_M3_socket_head, height=20);
fan_mount_width=6;
fan_flange_radius=hotend_mount_thickness/2;

// screws used for the groovemount clamp
groove_clamp_screw_obj = screw_obj(screw=screw_M3_socket_head, washer=washer_M3, nut=nut_M3, height=motor_plate_size[2]);
// distance between the screw holes
groove_clamp_hole_separation=16+screw_obj_screw_dia(groove_clamp_screw_obj)+2;

// offset of clamp from the motor plate
groove_body_offset_y=3;
// length of the groove mount body
groove_body_y_size=hotend_mount_thickness+groove_body_offset_y;
// width of the clamp
groove_body_x_size=groove_clamp_hole_separation+screw_obj_screw_head_top_dia(groove_clamp_screw_obj)+1;
// height of the groovemount body part
groove_body_z_size=filament_z_loc+fan_mount_width/2;

groove_clamp_z_size=filament_z_loc-fan_mount_width/2;
groove_clamp_y_size=hotend_mount_thickness;

// the screw object for the mounting plate (TODO: change to m3 after new carriage is designed)
mounting_screw_obj = screw_obj(screw=screw_M4_socket_head, washer=washer_M4, nut=nut_M4, height=20, horizontal=true);
// locations of the mounting holes for the I3 Rework
mounting_hole_locations=[[11.5, 11.5], [-11.5, 11.5], [11.5, -11.5], [-11.5, -11.5]];
// gap offset from the mounting plate
mounting_gap=1;

// the size of the mounting plate (oriented with the rest of the extruder)
carriage_plate_size=[10,34,34];
// the screw object for the mounting plate (TODO: change to m3 after new carriage is designed)
carriage_screw_obj = screw_obj(screw=screw_M4_socket_head, washer=washer_M4, nut=nut_M4, height=11, horizontal=true);
// locations of the mounting holes for the I3 Rework
carriage_hole_locations=[[11.5, 11.5], [-11.5, 11.5], [11.5, -11.5], [-11.5, -11.5]];
carriage_motor_gap=1;
carriage_mount_offset=18;

// additional stuff for e3d hotend ptfe tubing
// set length=motor_plate_size[1]/2+groove_body_offset_y+0.02 if you only want ptfe on the bottom
e3d_ptfe_dia=hole_fit( dia=4, fn=16);
e3d_ptfe_length=motor_plate_size[1]+groove_body_offset_y+0.02;

hinge_corner_thing=motor_plate_size[0]/2-(groove_body_x_size/2+filament_x_loc);

module extruder_body() {
        union() {
            
            // *** motor support cylinders ***
            translate([motor_screw_xy[0], motor_screw_xy[1], 0])
                //rotate([0,0,90])
                cylinder_poly(r=motor_screw_to_edge, h=motor_plate_size[2]);
            //translate([-motor_screw_xy[0], motor_screw_xy[1], 0])
            //    cylinder_poly(r=motor_screw_to_edge ,h=motor_plate_size[2]);
            translate([motor_screw_xy[0], -motor_screw_xy[1], 0]) {
                    cylinder_poly(r=motor_screw_to_edge ,h=motor_plate_size[2]);
                    translate([0,-motor_screw_to_edge,0])
                    _cube([motor_screw_to_edge,motor_screw_to_edge,motor_plate_size[2]]);
                }
            translate([-motor_screw_xy[0], -motor_screw_xy[1], 0]) 
            hull() {
                rotate([0,0,90])
                    cylinder_poly(r=motor_screw_to_edge ,h=motor_plate_size[2]);
                    translate([-motor_screw_to_edge+hinge_corner_thing,-motor_screw_to_edge-groove_body_offset_y,0])
                    _cube([motor_screw_to_edge,motor_screw_to_edge,motor_plate_size[2]]);
            }
            // *** END: motor support cylinders ***
            
            // *** top piece ***
            translate([ 0-filament_x_loc,motor_plate_size[1]/2-(motor_plate_size[1]-hobb_gear_hole_dia)/2, 0])
                _cube([motor_plate_size[1]/2-motor_screw_to_edge+filament_x_loc, (motor_plate_size[1]-hobb_gear_hole_dia)/2, motor_plate_size[2]]);
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

groove_mount_hole_y_offset=-groove_body_y_size-motor_plate_size[1]/2;

module extruder() {
    difference() {
        union() {
            extruder_body();
            translate([-filament_x_loc, -motor_plate_size[1]/2, 0])
            groove_mount_body();
            translate([motor_plate_size[0]/2+carriage_motor_gap, -carriage_plate_size[1]-carriage_mount_offset, 0])
            carriage_mount_body();
            translate([-filament_x_loc-groove_body_x_size/2-fan_flange_radius, groove_mount_hole_y_offset+hotend_mount_thickness/2, filament_z_loc])
                fan_flange();
        }
        translate([motor_plate_size[0]/2+carriage_motor_gap, -carriage_plate_size[1]-carriage_mount_offset, 0])
            carriage_mount_holes();
        
        hobb_and_motor_flange_hole();
        translate([-idler_x_loc,0,0])
            idler_hole();
        translate([-filament_x_loc, motor_plate_size[1]/2,filament_z_loc])
            filament_hole();
        translate([-motor_screw_xy[0], -motor_screw_xy[1], motor_plate_size[2]/2])
            idler_hinge_hole();
        
        // hole for tensioner springs
        translate([idler_spring_nut_x_offset,motor_plate_size[1]/2+idler_spring_y_offset,idler_spring_z_center])
            idler_spring_hole();
        // motor screw holes (x3)
        motor_screw_holes();
        
        translate([-filament_x_loc, groove_mount_hole_y_offset, filament_z_loc])
            groove_mount_hole();
        translate([-filament_x_loc, groove_mount_hole_y_offset+hotend_mount_thickness/2, 0])
            groove_mount_screw_holes();
    }
}

module bare_extruder() {
    difference() {
        union() {
            extruder_body();
            translate([-filament_x_loc, -motor_plate_size[1]/2, 0]) {
                // base
                translate([0, -groove_body_offset_y, 0])
                _cube([groove_body_x_size, groove_body_offset_y+0.01, motor_plate_size[2]], center=[true, false, false]);
            }
            //translate([motor_plate_size[0]/2+carriage_motor_gap, -carriage_plate_size[1]-carriage_mount_offset, 0])
            //carriage_mount_body();
            //translate([-filament_x_loc-groove_body_x_size/2-fan_flange_radius, groove_mount_hole_y_offset+hotend_mount_thickness/2, filament_z_loc])
                //fan_flange();
        }
        //translate([motor_plate_size[0]/2+carriage_motor_gap, -carriage_plate_size[1]-carriage_mount_offset, 0])
            //carriage_mount_holes();
        
        hobb_and_motor_flange_hole();
        translate([-idler_x_loc,0,0])
            idler_hole();
        translate([-filament_x_loc, motor_plate_size[1]/2, filament_z_loc])
            filament_hole();
        translate([-motor_screw_xy[0], -motor_screw_xy[1], motor_plate_size[2]/2])
            idler_hinge_hole();
        
        // hole for tensioner springs
        translate([idler_spring_nut_x_offset,motor_plate_size[1]/2+idler_spring_y_offset,idler_spring_z_center])
            idler_spring_hole();
        // motor screw holes (x3)
        motor_screw_holes();
        
        //translate([-filament_x_loc, groove_mount_hole_y_offset, filament_z_loc])
            //groove_mount_hole();
        //translate([-filament_x_loc, groove_mount_hole_y_offset+hotend_mount_thickness/2, 0])
            //groove_mount_screw_holes();
    }
}

idler_flange_offset = motor_plate_size[2]/2 - filament_z_loc;
idler_hinge_y_loc = -motor_screw_xy[1];
idler_hinge_x_loc = -idler_flange_offset;
idler_hinge_z_loc = idler_hinge_radius;
idler_bearing_z_loc = motor_screw_xy[0] -idler_x_loc + idler_hinge_radius;
idler_support_size_x=(filament_z_loc-filament_idler_screw_head_height-(motor_z_offset-0.2))*2;

module idler_body() {
    //idler_hinge_tab_thickness
    //idler_hinge_radius
    //filament_idler_screw_head_height
    //filament_idler_screw
    //filament_idler_screw_head_diameter
    //motor_z_offset-0.2
    
    echo("idler bearing screw length: ", idler_support_size_x);
    
    body_size_x = filament_z_loc*2;
    body_size_y = motor_plate_size[1]/2 - (idler_outer_dia/2);
    body_size_z = idler_hinge_radius + screw_obj_screw_dia(motor_screws)/2;
    
    idler_screw_x_loc=body_size_x/2-(motor_z_offset-0.2);
   
    body_y_offset = (idler_outer_dia/2);
    
    //idler hinge
    hull() {
        translate([idler_hinge_x_loc,idler_hinge_y_loc,idler_hinge_z_loc]) 
            rotate([0,90,0])
                cylinder_poly(r=idler_hinge_radius, h=idler_hinge_tab_thickness, center=true);
        translate([0,idler_hinge_y_loc,0])
            _cube([idler_support_size_x,motor_screw_xy[1]-body_y_offset+0.01,body_size_z], center=[true,false,false]);
        translate([idler_hinge_x_loc,idler_hinge_y_loc-idler_hinge_radius/2,0])
            _cube([idler_hinge_tab_thickness,idler_hinge_radius/2,body_size_z], center=[true,false,false]);
    }
    //idler spring support
    translate([0,body_y_offset,0]) 
        cube_fillet([body_size_x,body_size_y,body_size_z] ,vertical=[0,0,(body_size_x-idler_support_size_x)/2,(body_size_x-idler_support_size_x)/2], top=[body_size_z/2-0.5,0,0,0], center=[true,false,false]);
    
    //idler bearing support
    hull() {
        translate([0,0,idler_bearing_z_loc])
            rotate([0,90,0])
                cylinder_poly(r=idler_outer_dia/2-1, h=idler_support_size_x, center=true);
        _cube([idler_support_size_x,idler_outer_dia+0.002,body_size_z],center=[true,true,false]);
    }
    //idler finger flange thing
    translate([0,motor_plate_size[1]/2-0.01,0])
    cube_fillet([body_size_x,6.01,body_size_z/2], vertical=[6,6,0,0], top=[body_size_z/2-0.5,0,0,0], center=[true, false, false]);
}

module extruder_idler() {
    idler_total_width=idler_obj_bearing_width(filament_idler_obj) + idler_obj_washer_thickness(filament_idler_obj)*2;
    idler_bearing_screw_hole_dia=screw_obj_screw_dia(screw_obj_tolerance(filament_idler_screw));
    
    idler_bearing_washer_top_dia=idler_bearing_screw_hole_dia+2;
    idler_bearing_washer_bottom_dia=idler_bearing_washer_top_dia+1.2;
    idler_bearing_washer_thickness=0.6;
    
    
    difference() {
        union() {
            idler_body();
        }
        // cutout for bearing
        translate([0,0,idler_bearing_z_loc])
            rotate([0,90,0]) {
                difference() {
                    idler_obj_hole(filament_idler_obj, center = true);
                    translate([0,0,idler_obj_bearing_width(filament_idler_obj)/2])
                        cylinder_poly(r1=idler_bearing_washer_top_dia/2, r2=idler_bearing_washer_bottom_dia/2, h=idler_bearing_washer_thickness);
                    translate([0,0,-idler_obj_bearing_width(filament_idler_obj)/2-idler_bearing_washer_thickness])
                        cylinder_poly(r2=idler_bearing_washer_top_dia/2, r1=idler_bearing_washer_bottom_dia/2, h=idler_bearing_washer_thickness);
                }
                    translate([0,0,-idler_support_size_x/2])
                        screw_obj_hole(filament_idler_screw);
            }
        // screw hole    
        translate([idler_hinge_x_loc,idler_hinge_y_loc,idler_hinge_z_loc]) {
            rotate([0,90,0]) 
                translate([0,0,-idler_hinge_tab_thickness/2-0.01])
                screw_obj_hole(idler_hinge_screw_obj);
            translate([idler_hinge_tab_thickness/2-idler_hinge_x_loc-0.01,0,0])            
                rotate([0,-90,0]) 
                    screw_obj_hole(idler_hinge_screw_obj);
        }
        // lazily re-using the old function
        translate([0,motor_plate_size[1]/2+idler_spring_y_offset,-5])
            rotate([0,90,0])
                idler_spring_hole();
    }
}

module fan_flange() {
    difference() {
        union(){ 
            cylinder_poly(r=fan_flange_radius, h=fan_mount_width, center=true);
            _cube([fan_flange_radius, fan_flange_radius*2, fan_mount_width], center=[false,true,true]);
        }
        translate([0,0,-fan_mount_width/2+0.3])
        screw_obj_hole(fan_screw);
    }
}


module groove_mount_body() {
    translate([0, -groove_body_y_size, 0])
        _cube([groove_body_x_size, groove_body_y_size+0.01, groove_body_z_size], center=[true, false, false]);
    // support bracket
    translate([groove_body_x_size/2, -groove_body_y_size, 0])
        _cube([motor_plate_size[0]/2-(groove_body_x_size/2-filament_x_loc)+carriage_motor_gap+0.01, 4, groove_body_z_size], center=[false, false, false]);
    translate([0, -groove_body_offset_y, 0])
    _cube([groove_body_x_size, groove_body_offset_y+0.01, motor_plate_size[2]], center=[true, false, false]);
}

module groove_mount_clamp_body() {
    translate([0, 0, 0])
    _cube([groove_body_x_size, groove_clamp_y_size-0.1, groove_clamp_z_size-0.1], center=[true, false, false]);    
}

module print_groove_mount_clamp() {
    rotate([90,0,0])
    groove_mount_clamp();
}

module groove_mount_clamp() {
    difference() {
        union() {
            groove_mount_clamp_body();
            translate([0,fan_flange_radius,-fan_flange_radius])
                rotate([0,-90,0])
                    fan_flange();
        }
        translate([0,0,filament_z_loc])
            groove_mount_hole();
        
        translate([0,hotend_mount_thickness/2,0])
            groove_mount_clamp_screw_holes();
    }
}

module groove_mount_clamp_screw_holes() {
        union() {
            translate([-groove_clamp_hole_separation/2,0,0]) {
                screw_obj_hole(groove_clamp_screw_obj);
            }
            translate([groove_clamp_hole_separation/2,0,0]) {
                screw_obj_hole(groove_clamp_screw_obj);
            }
        }
}

module groove_mount_hole() {
    //e3d_collet_array=[8, 2];
    //e3d_ptfe_dia=hole_fit( dia=4, fn=16);
    mybevel=0.3;
    small_hole_fn=poly_sides((hotend_mount_array[1][0]/2+hotend_mount_tolerance)*2);
    // filament hole
    rotate([-90,0,0])
        translate([0,0,hotend_mount_thickness-0.01])
            if(hotend_use_e3d) {
                rotate([0,0,180/16])
                cylinder(d=e3d_ptfe_dia+0.1, h=e3d_ptfe_length+0.02, center=false, $fn=16);
                rotate([0,0,180/16])
                cylinder(d=hole_fit(e3d_collet_array[0],16), h=e3d_collet_array[1]+0.02, center=false, $fn=16);
                translate([0,-(hotend_mount_array[0][0]+hotend_mount_tolerance*2),0])
                    _cube([e3d_collet_array[0], hotend_mount_array[0][0]+hotend_mount_tolerance*2, e3d_collet_array[1]+0.02], center=[true, false, false]);
            } else {
                rotate([0,0,180/16])
                cylinder(d=hole_fit(filament_dia,16), h=groove_body_y_size+0.02, center=false, $fn=16);
            }
    // groove mount
    rotate([-90,0,0])
        translate([0,0,-0.1]) {
            translate([0,0,hotend_mount_array[1][1]-0.1]) {
                cylinder_poly(r=hotend_mount_array[0][0]/2+hotend_mount_tolerance, h=hotend_mount_array[0][1]+0.2);
                translate([0,-(hotend_mount_array[0][0]+hotend_mount_tolerance*2),0])
                    _cube([hotend_mount_array[0][0]+hotend_mount_tolerance*2, hotend_mount_array[0][0]+hotend_mount_tolerance*2, hotend_mount_array[0][1]+0.2], center=[true, false, false]);
            }
            // for rounding the corners for an easier fit
            cylinder_poly(r1=hotend_mount_array[1][0]/2+hotend_mount_tolerance+mybevel, r2=hotend_mount_array[1][0]/2+hotend_mount_tolerance, h=mybevel*2, fn=small_hole_fn);
            translate([0,0,hotend_mount_array[1][1]-mybevel*2])
            cylinder_poly(r2=hotend_mount_array[1][0]/2+hotend_mount_tolerance+mybevel, r1=hotend_mount_array[1][0]/2+hotend_mount_tolerance, h=mybevel*2, fn=small_hole_fn);
            // actual cut
            cylinder_poly(r=hotend_mount_array[1][0]/2+hotend_mount_tolerance, h=hotend_mount_array[1][1], fn=small_hole_fn);
            translate([0,-(hotend_mount_array[1][0]+hotend_mount_tolerance*2),0])
                    _cube([hotend_mount_array[1][0]+hotend_mount_tolerance*2, hotend_mount_array[1][0]+hotend_mount_tolerance*2, hotend_mount_array[1][1]+0.2], center=[true, false, false]);
        }
}

module groove_mount_screw_holes() {
    difference() {
        union() {
            translate([-groove_clamp_hole_separation/2,0,0]) {
                screw_obj_hole(groove_clamp_screw_obj);
                nut_obj_hole(screw_object=groove_clamp_screw_obj);
            }
            translate([groove_clamp_hole_separation/2,0,0]) {
                screw_obj_hole(groove_clamp_screw_obj);
                nut_obj_hole(screw_object=groove_clamp_screw_obj);
            }
        }
        translate([0,0,screw_obj_nut_thickness(groove_clamp_screw_obj)])
            _cube([groove_body_x_size, groove_body_y_size, 0.3], center=[true,true,false]);
    }
}

// filament entrance hole
module filament_support() {
    translate([0, -hobb_gear_hole_dia/2-0.01, 0])
        _cube([(filament_dia/2+filament_guide_thickness)*2+4, hobb_gear_hole_dia/2+0.01, filament_z_loc+filament_dia/2+filament_guide_thickness], center=[true, false, false]);
}

module motor_screw_holes() {
    translate([motor_screw_xy[0], motor_screw_xy[1], 0])
        screw_obj_hole(motor_screws);
    translate([motor_screw_xy[0], -motor_screw_xy[1], 0])
        screw_obj_hole(motor_screws);
    translate([-motor_screw_xy[0],-motor_screw_xy[1], 0])
    difference() {
            screw_obj_hole(motor_screws);
        translate([0,0,motor_plate_size[2]/2-(idler_hinge_tab_thickness+0.2)/2-0.3])
            cylinder(r=5, h=0.3);
        translate([0,0,motor_plate_size[2]/2+(idler_hinge_tab_thickness+0.2)/2])
            cylinder(r=5, h=0.3);
    }
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

// idler hinge
// set tolerance to define a hole
module idler_hinge_hole() {
    hinge_thickness=idler_hinge_tab_thickness+0.2;
    l=motor_plate_size[1]/2;
    //translate([-hinge_radius*3, -hinge_radius, 0])
    //cube_fillet([hinge_radius*4, hinge_radius*4, hinge_thickness] ,vertical=[0,0,0,(hinge_radius)], center=[false,false,true]);
    
    hull() {
        cylinder_poly(r=idler_hinge_hole_radius, h=hinge_thickness, center=true);
        translate([-l+idler_hinge_hole_radius,0,0])
        _cube([l, l, hinge_thickness], center=[false,false,true]);
        translate([-l,-idler_hinge_hole_radius,0])
        _cube([l, l, hinge_thickness], center=[false,false,true]);
    }
    
}

module idler_spring_hole()
{
    translate([0,0,idler_spring_separation/2])
    rotate([0,-90,0])
    rotate([0,0,90]) {
        translate([0,0,-5])
        screw_obj_hole(idler_spring_screw_obj);
        nut_obj_hole(screw_object=idler_spring_screw_obj, thickness=0, nut_slot=10);
    }
    translate([0,0,-idler_spring_separation/2])
    rotate([0,-90,0])
    rotate([0,0,90]) {
        translate([0,0,-5])
        screw_obj_hole(idler_spring_screw_obj);
        nut_obj_hole(screw_object=idler_spring_screw_obj, thickness=0, nut_slot=10);
    }
}

module filament_hole() {
    rotate([90,0,0])
        rotate([0,0, 180/16])
            translate([0,0,-0.01])
            cylinder(d=hole_fit(filament_dia,16), h=motor_plate_size[1]+groove_body_offset_y+0.02, center=false, $fn=16);
}

module hubb_idler_shadow() {
    %cylinder_poly(r=(hobb_gear_diameter/2), h=motor_plate_size[2]);
    translate([-idler_x_loc,0,idler_z_loc])
        %idler_from_object(idler_object=filament_idler_obj ,center=true);
}

module carriage_mount_body() {
        union() {
            cube(carriage_plate_size);
            translate([0,carriage_plate_size[1],0])
                cube_fillet([carriage_plate_size[0],carriage_plate_size[0],motor_plate_size[2]] ,vertical=[carriage_plate_size[0],0,0,0], vertical_fn=[1,0,0,0]);
            translate([-carriage_motor_gap-0.01, carriage_plate_size[1]/2+carriage_mount_offset-carriage_plate_size[0]/2+1, 0])
                cube([carriage_motor_gap+0.02, motor_plate_size[1]/2+carriage_plate_size[0]-carriage_mount_offset, motor_plate_size[2]]);
        }
}
    
module carriage_mount_holes() {
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

// this is to show the complete assembly
module extruder_model() {
    hubb_idler_shadow();
    extruder();

    translate([-motor_screw_xy[0]-idler_hinge_radius,0,filament_z_loc])
        rotate([0,90,0])
            extruder_idler();

    translate([-filament_x_loc, groove_mount_hole_y_offset, filament_z_loc*2])
        rotate([180,0,180])
            groove_mount_clamp();

    translate([-filament_x_loc,groove_mount_hole_y_offset+hotend_mount_thickness,filament_z_loc])
        rotate([0,0,180])
            %import("E3D_v6_1p75.STL");
}

// printable version
module extruder_print() {
    extruder();
    translate([motor_plate_size[0]+5,-10,0])
    !extruder_idler();
    translate([0,-motor_plate_size[0]-hotend_mount_thickness,0])
    print_groove_mount_clamp();
}

extruder_print();
//bare_extruder();