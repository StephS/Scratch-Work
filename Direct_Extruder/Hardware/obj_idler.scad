// Stored assemblies for standard bearing idlers
// It's no longer just a bearing, it's an idler for belts.

include <../inc/functions.scad>
include <hdw_bearings.scad>
include <obj_screw.scad>
include <hdw_belts.scad>

// washer is the washers used per side (1 per side)
// ********** <START> accessor functions **********
function idler_obj_bearing(type) = type[0];
function idler_obj_screw_obj(type) = type[1];
function idler_obj_washer(type) = type[2];
function idler_obj_belt(type) = type[3];
function idler_obj_hole_fn(type) = type[4];
function idler_obj_name(type) = type[5];

//idler_obj_bearing_width(type) = bearing_width(idler_obj_bearing(type));
//hole_fit(dia=idler_obj_outer_dia(type) + idler_obj_diameter_tolerance(type), fn=idler_obj_hole_fn(type))

function idler_obj(bearing=bearing_608, screw_object=-1, washer=-1, belt=-1, hole_fn=-1, name=-1) =
    [bearing,
    screw_object,
    washer,
    belt,
    (hole_fn==-1) ? poly_sides(_idler_obj_outer_dia(bearing, washer, belt) + bearing_tolerance_dia(bearing)) : hole_fn,
    (name==-1) ? ((bearing==-1) ? "No Name" : bearing_name(bearing)) : name];

function idler_obj_tolerance(idler_object) =
    [v_bearing_hole(idler_obj_bearing(idler_object), idler_obj_hole_fn(idler_object)),
    screw_obj_tolerance(idler_obj_screw_obj(idler_object)),
    (idler_obj_washer(idler_object) != -1) ? v_washer_hole(idler_obj_washer(idler_object), idler_obj_hole_fn(idler_object)) : -1,
    idler_obj_belt(idler_object),
    idler_obj_hole_fn(idler_object),
    idler_obj_name(idler_object)];

// get the diameter of the bearing + belt (helper function for cleaner code)
function idler_obj_bearing_belt_dia(idler_object) = bearing_out_dia(idler_obj_bearing(idler_object)) + idler_obj_bearing_belt_height(idler_object)*2;
// returns the height of the belt
function idler_obj_bearing_belt_height(idler_object) = (idler_obj_belt(idler_object) == -1) ? 0 : belt_height(idler_obj_belt(idler_object));
// returns the washer diameter
function idler_obj_washer_dia(idler_object) = (idler_obj_washer(idler_object) == -1) ? 0 : washer_outer_dia(idler_obj_washer(idler_object));
// returns the thickness of the washer
function idler_obj_washer_thickness(idler_object) = (idler_obj_washer(idler_object) == -1) ? 0 : washer_thickness(idler_obj_washer(idler_object));
// returns the outer diameter of the bearing
function idler_obj_bearing_dia(idler_object) = bearing_out_dia(idler_obj_bearing(idler_object));
// returns the width of the bearing
function idler_obj_bearing_width(idler_object) = bearing_width(idler_obj_bearing(idler_object));

// return the complete outer diameter, including the diameter of the flange, belt, fender washers. useful if fender washer used as guide is larger than the bearing size.
function idler_obj_outer_dia(idler_object) =
    ( idler_obj_bearing_belt_dia(idler_object) > bearing_total_out_dia(idler_obj_bearing(idler_object))) ?
        ((idler_obj_bearing_belt_dia(idler_object) > idler_obj_washer_dia(idler_object)) ? // if washer dia is greater than belt dia
            idler_obj_bearing_belt_dia(idler_object) :
            idler_obj_washer_dia(idler_object))
        :
        ((bearing_total_out_dia(idler_obj_bearing(idler_object)) > idler_obj_washer_dia(idler_object)) ? // if washer dia is greater than bearing dia
            bearing_total_out_dia(idler_obj_bearing(idler_object)) :
            idler_obj_washer_dia(idler_object));

function _belt_height(belt) = ((belt == -1) ? 0 : belt_height(belt));
function _washer_outer_dia(washer) = ((washer == -1) ? 0 : washer_outer_dia(washer));

// helper function
function _idler_obj_outer_dia(bearing, washer=-1, belt=-1) =
    ( (bearing_out_dia(bearing) + _belt_height(belt)*2) > bearing_total_out_dia(bearing)) ?
        (bearing_out_dia(bearing) + _belt_height(belt)*2 > _washer_outer_dia(washer)) ? // if washer dia is greater than belt dia
            bearing_out_dia(bearing) + _belt_height(belt)*2 :
            _washer_outer_dia(washer)
        :
        (bearing_total_out_dia(bearing) > _washer_outer_dia(washer)) ? // if washer dia is greater than bearing dia
            bearing_total_out_dia(bearing) :
            _washer_outer_dia(washer);

/*
function _idler_obj_outer_dia(bearing, washer=-1, belt=-1) =
    ( (bearing_out_dia(bearing) + belt_height(belt)*2) > bearing_total_out_dia(bearing)) ?
        (((bearing_out_dia(bearing) + belt_height(belt)*2) > (washer == -1) ? 0 : washer_outer_dia(washer)) ? // if washer dia is greater than belt dia
            (bearing_out_dia(bearing) + belt_height(belt)*2) :
            (washer == -1) ? 0 : washer_outer_dia(washer))
        :
        ((bearing_total_out_dia(bearing) > (washer == -1) ? 0 : washer_outer_dia(washer)) ? // if washer dia is greater than bearing dia
            bearing_total_out_dia(bearing) :
            (washer == -1) ? 0 : washer_outer_dia(washer));
*/
// function to get the total width (thickness) of the bearing assembly, including 1 washer per side.
// this does not include flange thickness
function idler_obj_width(idler_object) = idler_obj_bearing_width(idler_object) + idler_obj_washer_thickness(idler_object)*2;

