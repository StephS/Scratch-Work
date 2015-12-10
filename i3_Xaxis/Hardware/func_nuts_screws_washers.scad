// Nuts_screws.scad
// Released under Attribution 3.0 Unported (CC BY 3.0) 
// http://creativecommons.org/licenses/by/3.0/
// Stephanie Shaltes
// Description: This file holds all of the functions to utilize the the screw assemblies.

include <../inc/functions.scad>
include <obj_screw.scad>
include <../print_config.scad>

// modules
module screw_from_object(screw_object){
    //makes screw with head

    screw_type=screw_obj_screw(screw_object);
    washer_type=screw_obj_washer(screw_object);

    washer_height=((washer_type==-1) ? 0 : washer_thickness(washer_type));
    
    head_bottom_dia = screw_head_bottom_dia(screw_type);
    head_top_dia = screw_head_top_dia(screw_type);

    head_height = screw_head_height(screw_type);
    
    head_drop = screw_obj_head_drop(screw_object);
    screw_height = screw_obj_height(screw_object);
    
    // making the quality twice that of the hole (more accurate representation of fit)
    hole_fn = screw_obj_hole_fn(screw_object)*2;
    head_fn = (screw_hex(screw_type) ? 6 : screw_obj_head_fn(screw_object)*2);
    
    union() {
        translate([0, 0, head_drop - washer_height]) {
        // create the screw body/threads
            translate([0, 0, -0.001]) {
                cylinder(h=screw_height+0.001, r=screw_dia(screw_type)/2, $fn=hole_fn);
                // create the screw head and washer
                if (screw_head_height(screw_type) > 0)
                    translate([0, 0, -head_height+screw_head_offset(screw_type)]) {
                        if (washer_type != -1) translate([0, 0, head_height]) washer(type=washer_type, fn=head_fn);
                        translate([0, 0, -0.001])
                            cylinder(h=head_height+0.002, d2=head_bottom_dia, d1=head_top_dia, $fn=head_fn);
                }
            }
        }
    }
}

// this is an experimental feature to adjust the tolerance based on the angle of the screw.
function tolerance_adjust(angle, vertical_tolerance, horizontal_tolerance) = ((abs(calc_z_angle(angle))*horizontal_tolerance)+(1-abs(calc_z_angle(angle)))*vertical_tolerance);

// length is used to create a slotted hole
// head_drop drops the head that number of units, allowing inset screw holes.
module screw_obj_hole(screw_object){
    //makes screw hole
    
    screw_hole_object=screw_obj_tolerance(screw_object);
    screw_type=screw_obj_screw(screw_hole_object);
    washer_type=screw_obj_washer(screw_hole_object);
    
    hole_fn = screw_obj_hole_fn(screw_hole_object);
    head_fn = (screw_hex(screw_type) ? 6 : screw_obj_head_fn(screw_hole_object));
 
    head_bottom_dia= ((washer_type==-1) ?
                         screw_head_bottom_dia(screw_type) :
                         ((washer_outer_dia(washer_type)>screw_head_bottom_dia(screw_type)) ? 
                             washer_outer_dia(washer_type) :
                             screw_head_bottom_dia(screw_type)));
    head_top_dia= ((washer_type==-1) ?
                      screw_head_top_dia(screw_type) :
                          ((washer_outer_dia(washer_type) > screw_head_top_dia(screw_type)) ? 
                              washer_outer_dia(washer_type) :
                              screw_head_top_dia(screw_type)));
    
    // get the head height
    // if it's countersunk, this function will return the head height, otherwise returns 0
    head_height = screw_head_offset(screw_type);
    slot_length = screw_obj_slot_length(screw_hole_object);
    slot_offset = screw_obj_slot_offset(screw_hole_object);
    if (slot_length+slot_offset < 0) echo("Error: Screw location is no longer in slot. Slot offset > Slot length.");
    screw_height = screw_obj_height(screw_hole_object) - ((washer_type==-1) ? 0 : washer_thickness(washer_type));

    hole_support = screw_obj_hole_support(screw_hole_object);
    head_drop = screw_obj_head_drop(screw_hole_object);
    
    translate([slot_offset, 0, 0])
    translate([0, 0, -0.001])
    difference() {
        union() {
            // the screw threads/body
            translate([0, 0, head_drop]) {
                cylinder_slot(h=screw_height+0.002, r=screw_dia(screw_type)/2, length=slot_length, fn=hole_fn);
                // add in the head if it's a countersunk screw

                if (head_height>0)
                    cylinder_slot(h=head_height, r2=head_bottom_dia/2, r1=head_top_dia/2, length=slot_length, fn=head_fn);
    
            }
            // if there is a head drop, add it
            if (head_drop>0)
                cylinder_slot(h=head_drop+0.001, r=head_top_dia/2, length=slot_length, fn=head_fn);
        }
        // hole support for the head if the screw is upside down (allows bridging)
        render(convexity = 6)
            translate([0, 0, head_drop+head_height])
                if (hole_support) {
                    cylinder_slot(h=layer_height+0.002, r=head_bottom_dia/2+0.001, length=slot_length, fn=head_fn);
                }
    }
}

module rod_hole(d=0, h=0, allowance=-1, length=0, $fn=0, center=false, horizontal=false){
	//makes a rod hole
	dia = v_rod_hole(d=d, allowance=allowance, $fn=$fn, horizontal=horizontal);
	cylinder_slot(h=h, r=dia/2, length=length, $fn=$fn, center=center);
}

module nut_obj(screw_object=-1, thickness=0){
	//makes a nut
	nut_type = screw_obj_nut(screw_object);
	if (screw_object != -1 && screw_obj_nut(screw_object) != -1) {
		color([150/255, 150/255, 150/255, 0.7]) 
		cylinder(h=((thickness>0) ? thickness : nut_thickness(nut_type)), r=nut_outer_dia(nut_type)/2, $fn=6);
	} else {
		echo("Error Module nut(): Please specify a screw object with a nut.");
	}
}

//makes a nut hole
module nut_obj_hole(screw_object=-1, thickness=0, nut_slot=0){
	if (screw_object != -1 && screw_obj_nut(screw_object) != -1) {
		nut_type = screw_obj_nut(screw_obj_tolerance(screw_object));
		
		// horizontal determines of the corner cutouts are used. 
		horizontal=screw_obj_horizontal(screw_object);
		
		// determine to use the nut thickness, or thickness specified. useful for long holes (don't use for nut slots)
		nut_thickness=((thickness>0) ? (thickness+0.001) : (nut_thickness(nut_type)+0.001));
		
		// if there is a nut slot, don't do the corner cutouts on the side with the slot
		start=((nut_slot>0) ? 2 : 1);
		stop=((nut_slot>0) ? 4 : 6);
		corner_cutout_fn = 12;
		corner_cutout_dia = 1.5;
		
		render() union() {
			hull() {
		 		cylinder(h=nut_thickness, r=nut_outer_dia(nut_type)/2, $fn=6);
				if (nut_slot>0) translate([0, -(nut_flat(nut_type))/2, 0]) cube([nut_slot+0.001, (nut_flat(nut_type)), nut_thickness]);
		    }
			if (!horizontal) for(i = [start:stop])
				rotate([0,0,60*i]) translate([nut_outer_dia(nut_type)/2-corner_cutout_dia/2,0,0]) rotate([0,0, 180/(corner_cutout_fn/2)]) cylinder(r=corner_cutout_dia/2, h=nut_thickness, $fn=corner_cutout_fn);
		}
	} else {
		echo("Error Module nut_hole(): Please specify a screw object with a nut.");
	}
}

module washer(type=washer_M3, center=false){
	//makes a washer
	color([150/255, 150/255, 150/255, 0.7])
	render(convexity = 4) translate([0,0,(center) ? -washer_thickness(type)/2 : 0]) 
	    difference() {
	        cylinder(h=washer_thickness(type), d=washer_outer_dia(type));
	        cylinder(h=washer_thickness(type)+1, d=washer_dia(type));
	    }
}

module washer_hole(type=washer_M3, fn=0, horizontal=false){
	//makes a washer hole
	washer_h=v_washer_hole(type=type, $fn=$fn, horizontal=horizontal);
	cylinder_poly(h=washer_thickness(washer_h)+0.001, r=washer_outer_dia(washer_h)/2, fn=fn);
}

// Use this for screw clamps
// Length will be l + outer_radius_add*2
module screw_trap(l=20, screw=screw_M3_socket_head, nut=nut_M3, add_inner_support=0.5, outer_radius_add=2, fn=8, horizontal=false){
	inner_r = (
		(screw_head_top_dia(v_screw_hole(screw,$fn=$fn, horizontal=horizontal)) > nut_outer_dia(v_nut_hole(nut, horizontal=horizontal)))
		? screw_head_top_dia(v_screw_hole(screw,$fn=$fn, horizontal=horizontal)) : nut_outer_dia(v_nut_hole(nut, horizontal=horizontal))
		)/2 + add_inner_support;
	intersection() {
		rotate([0,0,180/$fn])
		union() {
			translate([0, 0, l/2])
				cylinder(r2=inner_r, r1=inner_r + outer_radius_add, h=outer_radius_add, $fn=fn);
			
			translate([0, 0, -l/2-outer_radius_add])
				cylinder(r1=inner_r, r2=inner_r + outer_radius_add, h=outer_radius_add, $fn=fn);
			
			translate([0, 0, 0])
				cylinder(r=inner_r + outer_radius_add, h=l+0.002, $fn=$fn, center=true);
		}
		
		translate([(inner_r)+outer_radius_add/2-sagitta_radius( inner_r-outer_radius_add/2,
			(inner_r + outer_radius_add)), 0, 0])
			cylinder_poly(r=
			sagitta_radius( inner_r-outer_radius_add/2,
			(inner_r + outer_radius_add)),
			h=l+outer_radius_add*2+1,
			center=true);
			
	}
}

module screw_nut_negative(l=20, screw=screw_M3_socket_head, nut=nut_M3, nut_slot=0, nut_drop=0, nut_thickness=0, head_drop=0, washer_type, $fn=0, center=false, horizontal=false){
	translate([0,0,((center) ? -(l)/2 : 0)]) {
		// nut trap
		translate([0,0,l-nut_drop])
			nut_hole(type=nut_M3, nut_slot=nut_slot, horizontal=horizontal, thickness=nut_thickness);
	
		// screw head hole
		screw_hole(type=screw, h=l-head_drop+0.001, head_drop=head_drop, washer_type=washer_type, $fn=$fn, horizontal=horizontal);
	}
}