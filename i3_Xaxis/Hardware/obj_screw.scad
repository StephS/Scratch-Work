// Stored objects for standard screws
// The idea is that you create the object with the settings, then pass the object to the appropriate function.

include <hdw_screws.scad>
include <hdw_nuts.scad>
include <hdw_washers.scad>
include <../inc/functions.scad>

// accessor functions
function screw_obj_screw(type) = type[0];
function screw_obj_washer(type) = type[1];
function screw_obj_nut(type) = type[2];
function screw_obj_height(type) = type[3];
function screw_obj_head_drop(type) = type[4];
function screw_obj_slot_length(type) = type[5];
function screw_obj_slot_offset(type) = type[6];
function screw_obj_hole_support(type) = type[7];
function screw_obj_horizontal(type) = type[8];
function screw_obj_hole_fn(type) = type[9];
function screw_obj_head_fn(type) = type[10];
function screw_obj_name(type) = type[11];
function screw_obj_screw_dia(type) = screw_dia(screw_obj_screw(type));
function screw_obj_screw_head_bottom_dia(type) = ((screw_obj_washer(type)==-1) ?
                         screw_head_bottom_dia(screw_obj_screw(type)) :
                         ((washer_outer_dia(screw_obj_washer(type))>screw_head_bottom_dia(screw_obj_screw(type))) ? 
                             washer_outer_dia(screw_obj_washer(type)) :
                             screw_head_bottom_dia(screw_obj_screw(type))));
function screw_obj_screw_head_top_dia(type) = ((screw_obj_washer(type)==-1) ?
                         screw_head_top_dia(screw_obj_screw(type)) :
                         ((washer_outer_dia(screw_obj_washer(type))>screw_head_top_dia(screw_obj_screw(type))) ? 
                             washer_outer_dia(screw_obj_washer(type)) :
                             screw_head_top_dia(screw_obj_screw(type))));

function screw_obj_nut_dia(type) = nut_outer_dia(screw_obj_nut(type));
function screw_obj_nut_flat(type) = nut_flat(screw_obj_nut(type));

function screw_obj_nut_thickness(type) = nut_thickness(screw_obj_nut(type));

// creates the screw object
// if FN is not given, calculate FN based on polysides.
function screw_obj(screw=-1, washer=-1, nut=-1, height=-1, head_drop=0, slot_length=0, slot_offset=0, hole_support=false, horizontal=false, hole_fn=-1, head_fn=-1, name=-1) =
	[screw,
	washer,
	nut,
	height,
	head_drop,
	slot_length,
	slot_offset,
	hole_support,
	horizontal,
	(hole_fn==-1) ? poly_sides(screw_dia(screw)) : hole_fn,
	(head_fn==-1) ? 
	    ((washer == -1) ? 
	        poly_sides(screw_head_bottom_dia(screw))
	        : poly_sides(washer_outer_dia(washer)))
	    : head_fn,
	(name==-1) ? ((screw==-1) ? "No Name" : screw_name(screw)) : name];

// returns the screw object with tolerances (used for holes)
// washer uses the head_fn
// adds the washer thickness (assumes that some people might forget the washer, or not add it
function screw_obj_tolerance(screw_object) =
	[v_screw_hole(screw_obj_screw(screw_object), screw_obj_hole_fn(screw_object), screw_obj_head_fn(screw_object)),
	((screw_obj_washer(screw_object)==-1) ? -1 : v_washer_hole(screw_obj_washer(screw_object), screw_obj_head_fn(screw_object))),
	((screw_obj_nut(screw_object)==-1) ? -1 : v_nut_hole(screw_obj_nut(screw_object))),
	screw_obj_height(screw_object) + ((screw_obj_washer(screw_object)==-1) ? 0 : washer_thickness(v_washer_hole(screw_obj_washer(screw_object), screw_obj_head_fn(screw_object)))),
	screw_obj_head_drop(screw_object),
	screw_obj_slot_length(screw_object),
	screw_obj_slot_offset(screw_object),
	screw_obj_hole_support(screw_object),
	screw_obj_horizontal(screw_object),
	screw_obj_hole_fn(screw_object),
	screw_obj_head_fn(screw_object),
	screw_obj_name(screw_object)];

