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

// Screw Unit conversion function
function Inch_screw_to_Metric(type) = 
	[screw_dia(type) * 24.5,
	screw_head_bottom_dia(type) * 24.5,
	screw_head_top_dia(type) * 24.5,
	screw_head_height(type) * 24.5,
	screw_tolerance_hole(type),
	screw_tolerance_head(type),
    screw_hex(type),
	screw_name(type)];
	
function set_screw_tolerance(type, tolerance_hole=-1, tolerance_head=-1) = 
	[screw_dia(type),
	screw_head_bottom_dia(type),
	screw_head_top_dia(type),
	screw_head_height(type),
	((tolerance_hole==-1) ? screw_tolerance_hole(type) : tolerance_hole),
	((tolerance_head==-1) ? screw_tolerance_head(type) : tolerance_head),
    screw_hex(type),
	screw_name(type)];
	
//************* screw hole tolerance function *************
// Tolerance is set to zero, so further calls from this screw will not be affected
// Hole_fit takes tne FN and calculates the diameter of the hole, accounting for the number of faces in the hole.
// don't calculate head tolerance if the head height is zero (it's a rod)
function v_screw_hole(type, hole_fn, head_fn) = 
	[hole_fit(screw_dia(type)+screw_tolerance_hole(type), hole_fn),
	(screw_head_height(type) == 0) ? 0 : hole_fit(screw_head_bottom_dia(type)+screw_tolerance_head(type), head_fn),
	(screw_head_height(type) == 0) ? 0 : hole_fit(screw_head_top_dia(type)+screw_tolerance_head(type), head_fn),
	screw_head_height(type),
	0,
	0,
    screw_hex(type),
	screw_name(type)];

//************* screw access functions *************
function screw_dia(screw_type)  = screw_type[0];
function screw_head_bottom_dia(screw_type)  = screw_type[1];
function screw_head_top_dia(screw_type)  = screw_type[2];
function screw_head_height(screw_type) = screw_type[3];
function screw_tolerance_hole(screw_type) = screw_type[4];
function screw_tolerance_head(screw_type) = screw_type[5];
function screw_hex(screw_type) = screw_type[6];
function screw_name(screw_type) = screw_type[7];

// this function determines the screw head offset, given that countersunk screws will always start at the top of the screw head.
function screw_head_offset(screw_type)=
	((screw_head_bottom_dia(screw_type) < screw_head_top_dia(screw_type)) ? screw_head_height(screw_type) : 0);

// Screw parameters
// diameter = 0
// head_dia_bottom = 1
// head_dia_top = 2
// head_height = 3
// name = 4
// [screw_dia, head_bottom_dia, head_top_dia, head_height, name]

// we're going to assume that screws with head height, diameter, etc set to zero is a rod and not a screw.
//********** (inch) Rods (Generic) **********
rod_inch_n1 =   Inch_screw_to_Metric([INCH_n1, 0, 0, 0, rod_tolerance_hole, 0, false, "(Generic) (inch) #2 Rod"]);
rod_inch_n2 =   Inch_screw_to_Metric([INCH_n2, 0, 0, 0, rod_tolerance_hole, 0, false, "(Generic) (inch) #2 Rod"]);
rod_inch_n3 =   Inch_screw_to_Metric([INCH_n3, 0, 0, 0, rod_tolerance_hole, 0, false, "(Generic) (inch) #3 Rod"]);
rod_inch_n4 =   Inch_screw_to_Metric([INCH_n4, 0, 0, 0, rod_tolerance_hole, 0, false, "(Generic) (inch) #4 Rod"]);
rod_inch_n5 =   Inch_screw_to_Metric([INCH_n5, 0, 0, 0, rod_tolerance_hole, 0, false, "(Generic) (inch) #5 Rod"]);
rod_inch_n6 =   Inch_screw_to_Metric([INCH_n6, 0, 0, 0, rod_tolerance_hole, 0, false, "(Generic) (inch) #6 Rod"]);
rod_inch_n8 =   Inch_screw_to_Metric([INCH_n8, 0, 0, 0, rod_tolerance_hole, 0, false, "(Generic) (inch) #8 Rod"]);
rod_inch_n10 =  Inch_screw_to_Metric([INCH_n10, 0, 0, 0, rod_tolerance_hole, 0, false, "(Generic) (inch) #10 Rod"]);
rod_inch_n12 =  Inch_screw_to_Metric([INCH_n12, 0, 0, 0, rod_tolerance_hole, 0, false, "(Generic) (inch) #12 Rod"]);
rod_inch_1_4 =  Inch_screw_to_Metric([INCH_1_4,  0, 0, 0, rod_tolerance_hole, 0, false, "(Generic) (inch) 1/4 Rod"]);
rod_inch_5_16 = Inch_screw_to_Metric([INCH_5_16, 0, 0, 0, rod_tolerance_hole, 0, false, "(Generic) (inch) 5/16 Rod"]);
rod_inch_3_8 =  Inch_screw_to_Metric([INCH_3_8,  0, 0, 0, rod_tolerance_hole, 0, false, "(Generic) (inch) 3/8 Rod"]);
rod_inch_1_2 =  Inch_screw_to_Metric([INCH_1_2,  0, 0, 0, rod_tolerance_hole, 0, false, "(Generic) (inch) 1/2 Rod"]);

//********** Metric Rods (Generic) **********
rod_M2p5 = [METRIC_M2p5, 0, 0, 0, rod_tolerance_hole, 0, false, "(Generic) Metric Rod M2.5 "];
rod_M3 =   [  METRIC_M3, 0, 0, 0, rod_tolerance_hole, 0, false, "(Generic) Metric Rod M3"];
rod_M4 =   [  METRIC_M4, 0, 0, 0, rod_tolerance_hole, 0, false, "(Generic) Metric Rod M4"];
rod_M5 =   [  METRIC_M5, 0, 0, 0, rod_tolerance_hole, 0, false, "(Generic) Metric Rod M5"];
rod_M6 =   [  METRIC_M6, 0, 0, 0, rod_tolerance_hole, 0, false, "(Generic) Metric Rod M6"];
rod_M8 =   [  METRIC_M8, 0, 0, 0, rod_tolerance_hole, 0, false, "(Generic) Metric Rod M8"];
rod_M10 =  [ METRIC_M10, 0, 0, 0, rod_tolerance_hole, 0, false, "(Generic) Metric Rod M10"];
rod_M12 =  [ METRIC_M12, 0, 0, 0, rod_tolerance_hole, 0, false, "(Generic) Metric Rod M12"];

//************* 8020inc(inch) screws *************
// http://www.3dcontentcentral.com/parts/supplier/80%2020-Inc/9/14/620.aspx
//                            [screw_dia, head_bottom_dia, head_top_dia, head_height, name]
screw_8020_1_4_flange_head =  [6.35, 13.08, 13.08, 3.08, screw_tolerance_hole, screw_tolerance_head, false, "8020inc #3066 #3342 #3390 1/4-20 Flange Screw"];
screw_8020_5_16_flange_head = [7.94, 16.93, 16.93, 4.13, screw_tolerance_hole, screw_tolerance_head, false, "8020inc #3330 #3340 5/16-18 Flange Screw"];
screw_8020_1_4_button_head =  [6.35,  11.1,  11.1, 3.35, screw_tolerance_hole, screw_tolerance_head, false, "8020inc #3059 1/4-20 Button Head Screw"];
screw_8020_5_16_button_head = [7.94, 13.89, 13.89, 4.22, screw_tolerance_hole, screw_tolerance_head, false, "8020inc #3104 5/16-18 Button Head Screw"];
screw_8020_1_4_socket_head =  [6.35,  9.52,  9.52, 6.35, screw_tolerance_hole, screw_tolerance_head, false, "8020inc #3058 1/4-20 Socket Head Screw"];
screw_8020_5_16_socket_head = [7.94, 12.41, 12.41, 8.45, screw_tolerance_hole, screw_tolerance_head, false, "8020inc #3106 5/16-18 Socket Head Screw"];
screw_8020_1_4_flat_head =    [6.35,  6.35, 13.56, 4.14, screw_tolerance_hole, screw_tolerance_head, false, "8020inc #3400 1/4-20 CounterSunk Flat Head Screw"];
screw_8020_5_16_flat_head =   [7.94,  7.94, 16.66, 5.07, screw_tolerance_hole, screw_tolerance_head, false, "8020inc #3410 5/16-18 CounterSunk Flat Head Screw"];

//************* Generic (inch) Button Head screws *************
//                                                 [screw_dia, head_bottom_dia, head_top_dia, head_height, name]
screw_inch_2_button_head =    Inch_screw_to_Metric([INCH_n2,  0.164, 0.164, 0.046, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) (inch) #2 Button Head"]);
screw_inch_3_button_head =    Inch_screw_to_Metric([INCH_n3,  0.188, 0.188, 0.052, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) (inch) #3 Button Head"]);
screw_inch_4_button_head =    Inch_screw_to_Metric([INCH_n4,  0.213, 0.213, 0.059, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) (inch) #4 Button Head"]);
screw_inch_5_button_head =    Inch_screw_to_Metric([INCH_n5,  0.238, 0.238, 0.066, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) (inch) #5 Button Head"]);
screw_inch_6_button_head =    Inch_screw_to_Metric([INCH_n6,  0.262, 0.262, 0.073, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) (inch) #6 Button Head"]);
screw_inch_8_button_head =    Inch_screw_to_Metric([INCH_n8,  0.312, 0.312, 0.087, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) (inch) #8 Button Head"]);
screw_inch_10_button_head =   Inch_screw_to_Metric([INCH_n10,  0.361, 0.361, 0.101, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) (inch) #10 Button Head"]);
screw_inch_1_4_button_head =  Inch_screw_to_Metric([INCH_1_4,  0.437, 0.437, 0.132, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) (inch) 1/4 Button Head"]);
screw_inch_5_16_button_head = Inch_screw_to_Metric([INCH_5_16, 0.547, 0.547, 0.166, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) (inch) 5/16 Button Head"]);
screw_inch_3_8_button_head =  Inch_screw_to_Metric([INCH_3_8,  0.656, 0.656, 0.199, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) (inch) 3/8 Button Head"]);
screw_inch_1_2_button_head =  Inch_screw_to_Metric([INCH_1_2,  0.675, 0.675, 0.265, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) (inch) 1/2 Button Head"]);

//************* Generic (inch) Socket Head screws *************
//                                                 [screw_dia, head_bottom_dia, head_top_dia, head_height, name]
screw_inch_2_socket_head =    Inch_screw_to_Metric([INCH_n2, 0.140, 0.140, INCH_n2, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) (inch) #2 Socket Head"]);
screw_inch_3_socket_head =    Inch_screw_to_Metric([INCH_n3, 0.161, 0.161, INCH_n3, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) (inch) #3 Socket Head"]);
screw_inch_4_socket_head =    Inch_screw_to_Metric([INCH_n4, 0.183, 0.183, INCH_n4, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) (inch) #4 Socket Head"]);
screw_inch_5_socket_head =    Inch_screw_to_Metric([INCH_n5, 0.205, 0.205, INCH_n5, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) (inch) #5 Socket Head"]);
screw_inch_6_socket_head =    Inch_screw_to_Metric([INCH_n6, 0.226, 0.226, INCH_n6, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) (inch) #6 Socket Head"]);
screw_inch_8_socket_head =    Inch_screw_to_Metric([INCH_n8, 0.270, 0.270, INCH_n8, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) (inch) #8 Socket Head"]);
screw_inch_10_socket_head =   Inch_screw_to_Metric([INCH_n10, 0.312, 0.312, INCH_n10, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) (inch) #10 Socket Head"]);
screw_inch_1_4_socket_head =  Inch_screw_to_Metric([INCH_1_4,  0.375, 0.375,  INCH_1_4, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) (inch) 1/4 Socket Head"]);
screw_inch_5_16_socket_head = Inch_screw_to_Metric([INCH_5_16, 0.469, 0.469, INCH_5_16, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) (inch) 5/16 Socket Head"]);
screw_inch_3_8_socket_head =  Inch_screw_to_Metric([INCH_3_8,  0.563, 0.563,  INCH_3_8, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) (inch) 3/8 Socket Head"]);
screw_inch_1_2_socket_head =  Inch_screw_to_Metric([INCH_1_2,  0.750, 0.750,  INCH_1_2, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) (inch) 1/2 Socket Head"]);

//************* Generic (inch) Flat Head (countersunk) Screws *************
//                                               [screw_dia, head_bottom_dia, head_top_dia, head_height, name]
screw_inch_2_flat_head =    Inch_screw_to_Metric([INCH_n2,  INCH_n2,  0.197, 0.064, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) (inch) #2 Flat Head (countersunk) Screw"]);
screw_inch_3_flat_head =    Inch_screw_to_Metric([INCH_n3,  INCH_n3,  0.226, 0.073, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) (inch) #3 Flat Head (countersunk) Screw"]);
screw_inch_4_flat_head =    Inch_screw_to_Metric([INCH_n4,  INCH_n4,  0.255, 0.083, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) (inch) #4 Flat Head (countersunk) Screw"]);
screw_inch_5_flat_head =    Inch_screw_to_Metric([INCH_n5,  INCH_n5,  0.281, 0.090, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) (inch) #5 Flat Head (countersunk) Screw"]);
screw_inch_6_flat_head =    Inch_screw_to_Metric([INCH_n6,  INCH_n6,  0.307, 0.097, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) (inch) #6 Flat Head (countersunk) Screw"]);
screw_inch_8_flat_head =    Inch_screw_to_Metric([INCH_n8,  INCH_n8,  0.359, 0.112, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) (inch) #8 Flat Head (countersunk) Screw"]);
screw_inch_10_flat_head =   Inch_screw_to_Metric([INCH_n10,  INCH_n10,  0.411, 0.127, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) (inch) #10 Flat Head (countersunk) Screw"]);
screw_inch_1_4_flat_head =  Inch_screw_to_Metric([INCH_1_4,  INCH_1_4,  0.531, 0.161, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) (inch) 1/4 Flat Head (countersunk) Screw"]);
screw_inch_5_16_flat_head = Inch_screw_to_Metric([INCH_5_16, INCH_5_16, 0.656, 0.198, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) (inch) 5/16 Flat Head (countersunk) Screw"]);
screw_inch_3_8_flat_head =  Inch_screw_to_Metric([INCH_3_8,  INCH_3_8,  0.781, 0.234, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) (inch) 3/8 Flat Head (countersunk) Screw"]);
screw_inch_1_2_flat_head =  Inch_screw_to_Metric([INCH_1_2,  INCH_1_2,  0.938, 0.251, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) (inch) 1/2 Flat Head (countersunk) Screw"]);

//************* Generic Metric Button Head screws *************
//                      [screw_dia, head_bottom_dia, head_top_dia, head_height, name]
screw_M3_button_head =  [ METRIC_M3,  5.7,  5.7, 1.65, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) Metric M3 Button Head"];
screw_M4_button_head =  [ METRIC_M4,  7.6,  7.6,  2.2, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) Metric M4 Button Head"];
screw_M5_button_head =  [ METRIC_M5,  9.5,  9.5, 2.75, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) Metric M5 Button Head"];
screw_M6_button_head =  [ METRIC_M6, 10.5, 10.5,  3.3, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) Metric M6 Button Head"];
screw_M8_button_head =  [ METRIC_M8,   14,   14,  4.4, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) Metric M8 Button Head"];
screw_M10_button_head = [METRIC_M10, 17.5, 17.5,  5.5, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) Metric M10 Button Head"];

//************* Generic Metric Socket Head screws *************
//                       [screw_dia, head_bottom_dia, head_top_dia, head_height, name]
screw_M2p5_socket_head = [METRIC_M2p5, 4.5, 4.5, 2.5, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) Metric M2.5 Socket Head"];
screw_M3_socket_head =   [  METRIC_M3, 5.5, 5.5,   3, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) Metric M3 Socket Head"];
screw_M4_socket_head =   [  METRIC_M4,   7,   7,   4, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) Metric M4 Socket Head"];
screw_M5_socket_head =   [  METRIC_M5, 8.5, 8.5,   5, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) Metric M5 Socket Head"];
screw_M6_socket_head =   [  METRIC_M6,  10,  10,   6, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) Metric M6 Socket Head"];
screw_M8_socket_head =   [  METRIC_M8,  13,  13,   8, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) Metric M8 Socket Head"];
screw_M10_socket_head =  [ METRIC_M10,  16,  16,  10, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) Metric M10 Socket Head"];

//************* Generic Metric Flat Head screws *************
//                    [screw_dia, head_bottom_dia, head_top_dia, head_height, name]
screw_M3_flat_head =  [ METRIC_M3,  3,  6.72,  1.83, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) Metric M3 Flat Head"];
screw_M4_flat_head =  [ METRIC_M4,  4,  8.96,  2.48, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) Metric M4 Flat Head"];
screw_M5_flat_head =  [ METRIC_M5,  5,  11.2,  3.10, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) Metric M5 Flat Head"];
screw_M6_flat_head =  [ METRIC_M6,  6, 13.44,  3.72, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) Metric M6 Flat Head"];
screw_M8_flat_head =  [ METRIC_M8,  8, 17.92,  4.96, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) Metric M8 Flat Head"];
screw_M10_flat_head = [METRIC_M10, 10,  22.4,  6.20, screw_tolerance_hole, screw_tolerance_head, false, "(Generic) Metric M10 Flat Head"];

//************* Generic Metric Hex Head screws *************
//                       [screw_dia, head_bottom_dia, head_top_dia, head_height, name]
screw_M3_hex_head =   [  METRIC_M3, (5.5/cos(30)), (5.5/cos(30)), 2, screw_tolerance_hole, screw_tolerance_hex_head, true, "(Generic) Metric M3 Hex Head"];
screw_M4_hex_head =   [  METRIC_M4,  (7/cos(30)),  (7/cos(30)), 2.8, screw_tolerance_hole, screw_tolerance_hex_head, true, "(Generic) Metric M4 Hex Head"];
screw_M5_hex_head =   [  METRIC_M5,  (8/cos(30)),  (8/cos(30)), 3.5, screw_tolerance_hole, screw_tolerance_hex_head, true, "(Generic) Metric M5 Hex Head"];
screw_M6_hex_head =   [  METRIC_M6, (10/cos(30)), (10/cos(30)),   4, screw_tolerance_hole, screw_tolerance_hex_head, true, "(Generic) Metric M6 Hex Head"];
screw_M8_hex_head =   [  METRIC_M8, (13/cos(30)), (13/cos(30)), 5.3, screw_tolerance_hole, screw_tolerance_hex_head, true, "(Generic) Metric M8 Hex Head"];
screw_M10_hex_head =  [ METRIC_M10, (17/cos(30)), (17/cos(30)), 6.4, screw_tolerance_hole, screw_tolerance_hex_head, true, "(Generic) Metric M10 Hex Head"];