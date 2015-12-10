// We're going to assume that bearings are made to very high tolerances.
// Select idler bearing size **************************************************
include <tolerances.scad>

function bearing_out_dia(type)  = type[0];
function bearing_width(type)  = type[1];
function bearing_inn_dia(type)  = type[2];
function bearing_flange_dia(type)  = type[3];
function bearing_flange_width(type)  = type[4];
function bearing_double_flange(type)  = type[5]; // set true if there is a flange on both sides of the bearing (belt guides)
function bearing_tolerance_dia(type)  = type[6];
function bearing_tolerance_inn_dia(type)  = type[7];
function bearing_tolerance_width(type)  = type[8];
function bearing_name(type)  = type[9];
// outer diameter including the flange diameter (whatever is larger)
function bearing_total_out_dia(type)  = (bearing_out_dia(type) > bearing_flange_dia(type)) ? bearing_out_dia(type) : bearing_flange_dia(type);

// flange width is width of the flange portion only. If the flange width is is negative then the flange
//   is inside the hub diameter. if it is positive then the flange is outside the hub diameter (useful for printed bearing guides).
// Bearings, all of them.
// [outer_diameter, width, inner_diameter, flange_diameter, flange_width, double_flange, tolerance_dia, tolerance_width, name]
bearing_608 =                  [    22,      7,    8,    0, 0, false, bearing_tolerance_diameter, bearing_tolerance_inner_diameter, bearing_tolerance_width,"608 Bearing"];
bearing_624 =                  [    16,      5,    4,    0, 0, false, bearing_tolerance_diameter, bearing_tolerance_inner_diameter, bearing_tolerance_width, "624 Bearing"];
bearing_624_double =           [    16,     10,    4,    0, 0, false, bearing_tolerance_diameter, bearing_tolerance_inner_diameter, bearing_tolerance_width, "two 624 Bearings"];
bearing_R4RS =                 [15.875, 4.9784, 6.35,    0, 0, false, bearing_tolerance_diameter, bearing_tolerance_inner_diameter, bearing_tolerance_width, "1/4 inch R4RS bearing"];
bearing_626RS =                [    19,      6,    6,    0, 0, false, bearing_tolerance_diameter, bearing_tolerance_inner_diameter, bearing_tolerance_width, "626RS Bearing"];
// Flanged Bearings
bearing_F623zz =               [    10,      4,    3, 11.5, -1, false, bearing_tolerance_diameter, bearing_tolerance_inner_diameter, bearing_tolerance_width, "608 Bearing"];
bearing_608_printrbot_guides = [    24,      7,    8,   32, 2,  true, bearing_tolerance_diameter, bearing_tolerance_inner_diameter, bearing_tolerance_width, "608 Bearing with belt guide from PrintrBot"];

function v_bearing_hole(type, hole_fn) =
	[ hole_fit(dia=bearing_out_dia(type) + bearing_tolerance_dia(type), fn=hole_fn),
	bearing_width(type)+bearing_tolerance_width(type),
	hole_fit(dia=bearing_inn_dia(type) + bearing_tolerance_inn_dia(type), fn=hole_fn),
	hole_fit(dia=bearing_flange_dia(type) + bearing_tolerance_dia(type), fn=hole_fn),
	bearing_flange_width(type),
	bearing_double_flange(type),
	0,
	0,
	0,
	bearing_name(type)];
	
function set_bearing_tolerance(type, tolerance_dia=-1, tolerance_inn_dia=-1, tolerance_width=-1) =
	[ bearing_out_dia(type),
	bearing_width(type),
	bearing_inn_dia(type),
	bearing_flange_dia(type),
	bearing_flange_width(type),
	bearing_double_flange(type),
	((tolerance_dia==-1) ? bearing_tolerance_dia(type) : tolerance_dia),
	((tolerance_inn_dia==-1) ? bearing_tolerance_inn_dia(type) : tolerance_inn_dia),
	((tolerance_width==-1) ? bearing_tolerance_width(type) : tolerance_width),
	bearing_name(type)];