// conf_nuts_screws.scad
// Released under Attribution 3.0 Unported (CC BY 3.0) 
// http://creativecommons.org/licenses/by/3.0/
// Stephanie Shaltes
// This holds all of the dimensions for the nuts, screws, and washers
// also holds all of the access functions
// tolerance is now included, so special screws can include tolerance. also makes the hole functions easier to use.
// use the screw_set_tolerance function to adjust a screw to your specific printers needs, or edit tolerances.scad

include <inch_metric.scad>
include <tolerances.scad>

// Nut unit conversion function	
function Inch_nut_to_Metric(type) = 
	[nut_dia(type) * 24.5,
	nut_flat(type) * 24.5,
	nut_thickness(type) * 24.5,
	nut_tolerance_diameter(type),
	nut_tolerance_thickness(type),
	nut_name(type)];

function set_nut_tolerance(type, diameter_tolerance=-1, thickness_tolerance=-1) = 
	[nut_dia(type),
	nut_flat(type),
	nut_thickness(type),
	((diameter_tolerance==-1) ? nut_tolerance_diameter(type) : diameter_tolerance),
	((thickness_tolerance==-1) ? nut_tolerance_thickness(type) : thickness_tolerance),
	nut_name(type)];

//************* nut hole tolerance function *************
// Tolerance is set to zero after this call is made.
function v_nut_hole(type) = 
	[nut_dia(type),
	(nut_flat(type) + nut_tolerance_diameter(type)),
	(nut_thickness(type)+ nut_tolerance_thickness(type)),
	0,
	0,
	nut_name(type)];

//************* nut access functions *************
function nut_dia(type)  = type[0];
function nut_flat(type)  = type[1];
function nut_outer_dia(type)  = (nut_flat(type)/cos(30));
function nut_thickness(type)  = type[2];
function nut_tolerance_diameter(type) = type[3];
function nut_tolerance_thickness(type) = type[4];
function nut_name(type)  = type[5];

//************* Generic Metric nuts *************
// inner diameter = 0
// flat size = 1
// thickness = 2
// name = 3
nut_M2p5 = [ METRIC_M2p5,   5,   2, nut_tolerance_diameter, nut_tolerance_thickness, "(Generic) Metric M2.5 Nut"];
nut_M3 =   [   METRIC_M3, 5.5, 2.4, nut_tolerance_diameter, nut_tolerance_thickness, "(Generic) Metric M3 Nut"];
nut_M4 =   [   METRIC_M4,   7, 3.2, nut_tolerance_diameter, nut_tolerance_thickness, "(Generic) Metric M4 Nut"];
nut_M5 =   [   METRIC_M5,   8,   4, nut_tolerance_diameter, nut_tolerance_thickness, "(Generic) Metric M5 Nut"];
nut_M6 =   [   METRIC_M6,  10,   5, nut_tolerance_diameter, nut_tolerance_thickness, "(Generic) Metric M6 Nut"];
nut_M8 =   [   METRIC_M8,  13, 6.5, nut_tolerance_diameter, nut_tolerance_thickness, "(Generic) Metric M8 Nut"];
nut_M10 =  [  METRIC_M10,  16,   8, nut_tolerance_diameter, nut_tolerance_thickness, "(Generic) Metric M10 Nut"];

// Jam nuts, also known as half height nuts
nut_jam_M2p5 = [ METRIC_M2p5,   5, 1.6, nut_tolerance_diameter, nut_tolerance_thickness, "(Generic) Metric M2.5 Jam (half height) Nut"];
nut_jam_M3 =   [   METRIC_M3, 5.5, 1.8, nut_tolerance_diameter, nut_tolerance_thickness, "(Generic) Metric M3 Jam (half height) Nut"];
nut_jam_M4 =   [   METRIC_M4,   7, 2.2, nut_tolerance_diameter, nut_tolerance_thickness, "(Generic) Metric M4 Jam (half height) Nut"];
nut_jam_M5 =   [   METRIC_M5,   8, 2.7, nut_tolerance_diameter, nut_tolerance_thickness, "(Generic) Metric M5 Jam (half height) Nut"];
nut_jam_M6 =   [   METRIC_M6,  10, 3.2, nut_tolerance_diameter, nut_tolerance_thickness, "(Generic) Metric M6 Jam (half height) Nut"];
nut_jam_M8 =   [   METRIC_M8,  13,   4, nut_tolerance_diameter, nut_tolerance_thickness, "(Generic) Metric M8 Jam (half height) Nut"];
nut_jam_M10 =  [  METRIC_M10,  16,   5, nut_tolerance_diameter, nut_tolerance_thickness, "(Generic) Metric M10 Jam (half height) Nut"];

//************* Generic(inch) nuts *************
// inner diameter = 0
// flat size = 1
// thickness = 2
// name = 3
nut_inch_2 =        Inch_nut_to_Metric([  INCH_n2,  3/16,  1/16, nut_tolerance_diameter, nut_tolerance_thickness, "(Generic) (inch) #2 Nut"]);
nut_inch_3 =        Inch_nut_to_Metric([  INCH_n3,  3/16,  1/16, nut_tolerance_diameter, nut_tolerance_thickness, "(Generic) (inch) #3 Nut"]);
nut_inch_4 =        Inch_nut_to_Metric([  INCH_n4,   1/4,  3/32, nut_tolerance_diameter, nut_tolerance_thickness, "(Generic) (inch) #4 Nut"]);
nut_inch_5 =        Inch_nut_to_Metric([  INCH_n5,  5/16,  7/64, nut_tolerance_diameter, nut_tolerance_thickness, "(Generic) (inch) #5 Nut"]);
nut_inch_6 =        Inch_nut_to_Metric([  INCH_n6,  5/16,  7/64, nut_tolerance_diameter, nut_tolerance_thickness, "(Generic) (inch) #6 Nut"]);
nut_inch_8 =        Inch_nut_to_Metric([  INCH_n8, 11/32,   1/8, nut_tolerance_diameter, nut_tolerance_thickness, "(Generic) (inch) #8 Nut"]);
nut_inch_10 =       Inch_nut_to_Metric([ INCH_n10,   3/8,   1/8, nut_tolerance_diameter, nut_tolerance_thickness, "(Generic) (inch) #10 Nut"]);
nut_inch_1_4 =      Inch_nut_to_Metric([ INCH_1_4,  7/16,  7/32, nut_tolerance_diameter, nut_tolerance_thickness, "(Generic) (inch) 1/4 Nut"]);
nut_inch_5_16 =     Inch_nut_to_Metric([INCH_5_16,   1/2, 17/64, nut_tolerance_diameter, nut_tolerance_thickness, "(Generic) (inch) 5/16 Nut"]);
nut_inch_3_8 =      Inch_nut_to_Metric([ INCH_3_8,  9/16, 21/64, nut_tolerance_diameter, nut_tolerance_thickness, "(Generic) (inch) 3/8 Nut"]);
nut_inch_1_2 =      Inch_nut_to_Metric([ INCH_1_2,   3/4,  7/16, nut_tolerance_diameter, nut_tolerance_thickness, "(Generic) (inch) 1/2 Nut"]);

// Jam nuts, also known as half height nuts
nut_jam_inch_1_4 =  Inch_nut_to_Metric([ INCH_1_4, 7/16, 5/32, nut_tolerance_diameter, nut_tolerance_thickness, "(Generic) (inch) 1/4 Jam (half height) Nut"]);
nut_jam_inch_5_16 = Inch_nut_to_Metric([INCH_5_16,  1/2, 3/16, nut_tolerance_diameter, nut_tolerance_thickness, "(Generic) (inch) 5/16 Jam (half height) Nut"]);
nut_jam_inch_3_8 =  Inch_nut_to_Metric([ INCH_3_8, 9/16, 7/32, nut_tolerance_diameter, nut_tolerance_thickness, "(Generic) (inch) 3/8 Jam (half height) Nut"]);
nut_jam_inch_1_2 =  Inch_nut_to_Metric([ INCH_1_2,  3/4, 5/16, nut_tolerance_diameter, nut_tolerance_thickness, "(Generic) (inch) 1/2 Jam (half height) Nut"]);