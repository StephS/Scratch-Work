// conf_nuts_screws.scad
// Released under Attribution 3.0 Unported (CC BY 3.0) 
// http://creativecommons.org/licenses/by/3.0/
// Stephanie Shaltes
// This holds all of the dimensions for the nuts, screws, and washers
// also holds all of the access functions

include <inch_metric.scad>
include <tolerances.scad>

// Washer unit conversion function	
function Inch_washer_to_Metric(type) =
	[washer_dia(type) * 24.5,
	washer_outer_dia(type) * 24.5,
	washer_thickness(type) * 24.5,
	washer_tolerance_diameter(type),
	washer_tolerance_thickness(type),
	washer_name(type)];

function set_washer_tolerance(type, diameter_tolerance=-1, thickness_tolerance=-1) =
	[washer_dia(type),
	washer_outer_dia(type),
	washer_thickness(type),
	((diameter_tolerance==-1) ? washer_tolerance_diameter(type) : diameter_tolerance),
	((thickness_tolerance==-1) ? washer_tolerance_thickness(type) : thickness_tolerance),
	washer_name(type)];

//************* washer hole tolerance function *************
// Tolerance is set to zero after this call is made.
// Hole_fit takes tne FN and calculates the diameter of the hole, accounting for the number of faces in the hole.
function v_washer_hole(type, fn) =
	[washer_dia(type),
	hole_fit(washer_outer_dia(type), fn) + washer_tolerance_diameter(type),
	washer_thickness(type) + washer_tolerance_thickness(type),
	0,
	0,
	washer_name(type)];

//************* washer access functions *************
function washer_dia(type)  = type[0];
function washer_outer_dia(type)  = type[1];
function washer_thickness(type)  = type[2];
function washer_tolerance_diameter(type) = type[3];
function washer_tolerance_thickness(type) = type[4];
function washer_name(type)  = type[5];

//************* Generic Metric washers *************
// inner diameter = 0
// outer diameter = 1
// thickness = 2
// diameter tolerance = 3
// thickness tolerance = 4
// name = 5
washer_M2p5 =      [ 2.7,    6, 0.5, washer_tolerance_diameter, washer_tolerance_thickness, "(Generic) Metric M2.5 Washer"];
washer_M3 =        [ 3.2,    7, 0.5, washer_tolerance_diameter, washer_tolerance_thickness, "(Generic) Metric M3 Washer"];
washer_M3p5 =      [ 3.7,    8, 0.5, washer_tolerance_diameter, washer_tolerance_thickness, "(Generic) Metric M3.5 Washer"];
washer_M4 =        [ 4.3,    9, 0.8, washer_tolerance_diameter, washer_tolerance_thickness, "(Generic) Metric M4 Washer"];
washer_M5 =        [ 5.3,   10, 1.0, washer_tolerance_diameter, washer_tolerance_thickness, "(Generic) Metric M5 Washer"];
washer_M6 =        [ 6.4, 12.5, 1.6, washer_tolerance_diameter, washer_tolerance_thickness, "(Generic) Metric M6 Washer"];
washer_M8 =        [ 8.4,   17, 1.6, washer_tolerance_diameter, washer_tolerance_thickness, "(Generic) Metric M8 Washer"];
washer_M8_double = [ 8.4,   17, 3.2, washer_tolerance_diameter, washer_tolerance_thickness*2, "(Generic) Metric M8 Washer (Doubled)"];
washer_M10 =       [10.5,   21,   2, washer_tolerance_diameter, washer_tolerance_thickness, "(Generic) Metric M10 Washer"];

// custom printed washer
washer_M4_printed_0p5 =        [ 4.5,    5.5, 0.5, washer_tolerance_diameter, washer_tolerance_thickness, "(Generic) Metric M4 Washer"];

// Metric Fender washers
washer_fender_M2p5 = [ 2.7,    8, 0.8, washer_tolerance_diameter, washer_tolerance_thickness, "(Generic) Metric M2.5 Fender Washer"];
washer_fender_M3 =   [ 3.2,    9, 0.8, washer_tolerance_diameter, washer_tolerance_thickness, "(Generic) Metric M3 Fender Washer"];
washer_fender_M4 =   [ 4.3,   12, 1.0, washer_tolerance_diameter, washer_tolerance_thickness, "(Generic) Metric M4 Fender Washer"];
washer_fender_M5 =   [ 5.3,   15, 1.2, washer_tolerance_diameter, washer_tolerance_thickness, "(Generic) Metric M5 Fender Washer"];
washer_fender_M6 =   [ 6.4,   18, 1.6, washer_tolerance_diameter, washer_tolerance_thickness, "(Generic) Metric M6 Fender Washer"];
washer_fender_M8 =   [ 8.4,   24, 2.0, washer_tolerance_diameter, washer_tolerance_thickness, "(Generic) Metric M8 Fender Washer"];
washer_fender_M10 =  [10.5,   30, 2.5, washer_tolerance_diameter, washer_tolerance_thickness, "(Generic) Metric M10 Fender Washer"];

//************* Generic(inch) washers *************
// SAE standard washers
washer_inch_2 =    Inch_washer_to_Metric([  3/32,   7/32, 0.03, washer_tolerance_diameter, washer_tolerance_thickness, "(Generic) (inch) #2 Washer"]);
washer_inch_3 =    Inch_washer_to_Metric([  7/64,    1/4, 0.03, washer_tolerance_diameter, washer_tolerance_thickness, "(Generic) (inch) #3 Washer"]);
washer_inch_4 =    Inch_washer_to_Metric([   1/8,   5/16, 0.04, washer_tolerance_diameter, washer_tolerance_thickness, "(Generic) (inch) #4 Washer"]);
washer_inch_5 =    Inch_washer_to_Metric([  9/64,   9/32, 0.04, washer_tolerance_diameter, washer_tolerance_thickness, "(Generic) (inch) #5 Washer"]);
washer_inch_6 =    Inch_washer_to_Metric([  5/32,    3/8, 0.07, washer_tolerance_diameter, washer_tolerance_thickness, "(Generic) (inch) #6 Washer"]);
washer_inch_8 =    Inch_washer_to_Metric([  3/16,   7/16, 0.07, washer_tolerance_diameter, washer_tolerance_thickness, "(Generic) (inch) #8 Washer"]);
washer_inch_10 =   Inch_washer_to_Metric([  7/32,    1/2, 0.07, washer_tolerance_diameter, washer_tolerance_thickness, "(Generic) (inch) #10 Washer"]);
washer_inch_1_4 =  Inch_washer_to_Metric([  9/32,    5/8, 0.08, washer_tolerance_diameter, washer_tolerance_thickness, "(Generic) (inch) 1/4 Washer"]);
washer_inch_5_16 = Inch_washer_to_Metric([ 11/32,  11/16, 0.08, washer_tolerance_diameter, washer_tolerance_thickness, "(Generic) (inch) 5/16 Washer"]);
washer_inch_3_8 =  Inch_washer_to_Metric([ 13/32,  13/16, 0.08, washer_tolerance_diameter, washer_tolerance_thickness, "(Generic) (inch) 3/8 Washer"]);
washer_inch_1_2 =  Inch_washer_to_Metric([ 17/32, 1+1/16, 0.13, washer_tolerance_diameter, washer_tolerance_thickness, "(Generic) (inch) 1/2 Washer"]);

//(inch) Fender washers
washer_fender_inch_8 =          Inch_washer_to_Metric([ 11/64, 3/4, 0.05, washer_tolerance_diameter, washer_tolerance_thickness, "(Generic) (inch) #8 Fender Washer"]);
washer_fender_inch_10 =         Inch_washer_to_Metric([ 13/64, 1/2, 0.05, washer_tolerance_diameter, washer_tolerance_thickness, "(Generic) (inch) #10 Fender Washer"]);
washer_fender_inch_1_4_od_1_2 = Inch_washer_to_Metric([ 17/64, 1/2, 0.06, washer_tolerance_diameter, washer_tolerance_thickness, "(Generic) (inch) 1/4 ID 1/2 OD Fender Washer"]);
washer_fender_inch_1_4_od_1 =   Inch_washer_to_Metric([  9/32,   1, 0.06, washer_tolerance_diameter, washer_tolerance_thickness, "(Generic) (inch) 1/4 ID 1 OD Fender Washer"]);
washer_fender_inch_5_16 =       Inch_washer_to_Metric([ 11/32, 5/8, 0.08, washer_tolerance_diameter, washer_tolerance_thickness, "(Generic) (inch) 5/16 Fender Washer"]);
washer_fender_inch_3_8 =        Inch_washer_to_Metric([ 13/32,   1, 0.08, washer_tolerance_diameter, washer_tolerance_thickness, "(Generic) (inch) 3/8 Fender Washer"]);
washer_fender_inch_1_2 =        Inch_washer_to_Metric([ 17/32, 1.5, 0.08, washer_tolerance_diameter, washer_tolerance_thickness, "(Generic) (inch) 1/2 Fender Washer"]);
