// Stored assemblies for linear bearings

include <hdw_linear_bearings.scad>
include <hdw_screws.scad>

// accessor functions
function lb_obj_linear_bearing(type) = type[0];
function lb_obj_fn(type) = type[1];
function lb_obj_name(type) = type[2];

function lb_obj_rod_dia(type) = lb_rod_dia(lb_obj_linear_bearing(type));
function lb_obj_out_dia(type) = lb_out_dia(lb_obj_linear_bearing(type));
function lb_obj_length(type) = lb_length(lb_obj_linear_bearing(type));
function lb_obj_type(type) = lb_type(lb_obj_linear_bearing(type));

function lb_obj(lb=-1, fn=-1, name=-1) =
	[lb,
	(fn==-1) ? poly_sides(lb_out_dia(lb)) : fn,
	(name==-1) ? ((lb==-1) ? "No Name" : lb_name(lb)) : name];

function lb_obj_tolerance(lb_object) =
	[v_hole_lb(lb_obj_linear_bearing(lb_object), lb_obj_fn(lb_object)),
	lb_obj_fn(lb_object),
	lb_obj_name(lb_object)];

/*
// [rod, bearing, name]
lb_assy_igus8 =     [ rod_M8,      lb_igus8,      "igus J(V)FM 0810-10 or GFM 0810-10 Bearing Assembly"];
lb_assy_lm8uu =     [ rod_M8,      lb_lm8uu,                "lm8uu bearing (standard) Bearing Assembly"];
lb_assy_lm8luu =    [ rod_M8,     lb_lm8luu,          "lm8luu bearing (double length) Bearing Assembly"];
lb_assy_lme8uu =    [ rod_M8,     lb_lme8uu,                          "lme8uu bearing Bearing Assembly"];
lb_assy_bronze_8 =  [ rod_M8,   lb_bronze_8,       "bronze self-aligning bushing, 8mm Bearing Assembly"];
lb_assy_igus10 =    [ rod_M10,    lb_igus10,                     "igus J(V)FM 1012-10 Bearing Assembly"];
lb_assy_lm10uu =    [ rod_M10,    lb_lm10uu,        "lm10uu bearing (10mm smooth rod) Bearing Assembly"];
lb_assy_lm10luu =   [ rod_M10,   lb_lm10luu, "lm10luu bearing (10mm smooth rod, long) Bearing Assembly"];
lb_assy_bronze_10 = [ rod_M10, lb_bronze_10,      "bronze self-aligning bushing, 10mm Bearing Assembly"];
lb_assy_lm12uu =    [ rod_M12,    lb_lm12uu,        "lm12uu bearing (12mm smooth rod) Bearing Assembly"];
lb_assy_lm12luu =   [ rod_M12,   lb_lm12luu,   "lm12luu bearing (12mm, double length) Bearing Assembly"];
*/