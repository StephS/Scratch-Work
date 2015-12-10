// conf_linear_bearing

// Accessor functions
function lb_rod_dia(type) = type[0];
function lb_out_dia(type) = type[1];
function lb_length(type) = type[2];
function lb_type(type) = type[3];
function lb_tolerance_length(type) = type[4];
function lb_tolerance_diameter(type) = type[5];
function lb_name(type) = type[6];

function v_hole_lb(type, fn) =
	[hole_fit(lb_rod_dia(type)+lb_tolerance_diameter(type), fn),
	hole_fit(lb_out_dia(type)+lb_tolerance_diameter(type), fn),
	hole_fit(lb_length(type)+lb_tolerance_length(type), fn),
	lb_type(type),
	0,
	0,
	lb_name(type)];
	
//                  [rod_dia,   dia, length, type, lb_tolerance_length, lb_tolerance_diameter,                                    "name"]
lb_igus8 =     [      8,  10.2,     10,    1, lb_tolerance_length, lb_tolerance_diameter,      "igus J(V)FM 0810-10 or GFM 0810-10"];
lb_lm8uu =     [      8,  15.4,     24,    0, lb_tolerance_length, lb_tolerance_diameter,                "lm8uu bearing (standard)"];
lb_lm8luu =    [      8,  15.4,     45,    0, lb_tolerance_length, lb_tolerance_diameter,          "lm8luu bearing (double length)"];
lb_lme8uu =    [      8,  16.4,     25,    0, lb_tolerance_length, lb_tolerance_diameter,                          "lme8uu bearing"];
lb_bronze_8 =  [      8,    16,     11,    1, lb_tolerance_length, lb_tolerance_diameter,       "bronze self-aligning bushing, 8mm"];

lb_igus10 =    [     10,  12.2,     10,    1, lb_tolerance_length, lb_tolerance_diameter,                     "igus J(V)FM 1012-10"];
lb_lm10uu =    [     10,  19.4,     29,    0, lb_tolerance_length, lb_tolerance_diameter,        "lm10uu bearing (10mm smooth rod)"];
lb_lm10luu =   [     10,  19.4,     55,    0, lb_tolerance_length, lb_tolerance_diameter, "lm10luu bearing (10mm smooth rod, long)"];
lb_bronze_10 = [     10,    16,     11,    1, lb_tolerance_length, lb_tolerance_diameter,      "bronze self-aligning bushing, 10mm"];

lb_lm12uu =    [     12,  21.2,     30,    0, lb_tolerance_length, lb_tolerance_diameter,        "lm12uu bearing (12mm smooth rod)"];
lb_lm12luu =   [     12,  21.2,     57,    0, lb_tolerance_length, lb_tolerance_diameter,   "lm12luu bearing (12mm, double length)"];

