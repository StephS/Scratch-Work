// set the tolerance for the screws and nuts
SCREW_HEAD_THICKNESS_TOLERANCE = 0.1;
SCREW_HEAD_DIAMETER_TOLERANCE = 0.1;
SCREW_DIAMETER_TOLERANCE = 0.1;
NUT_DIAMETER_TOLERANCE = 0.1;
NUT_THICKNESS_TOLERANCE = 0.1;
NUT_FLAT_WIDTH_TOLERANCE = 0.1;

ROD_DIAMETER_TOLERANCE = 0.1;

_SIZE = 0;
_VALUE = 1;
_FN = 2;

//functions
// determine the number of sides for a printable object
// this will make sure that the sides is always and even number (fixes some issues)
function poly_sides(d) = (ceil((max(round(2 * d),3)+1)/2)*2);
// if $fn is not given then return the same value
function hole_fit( d=0, fn=0) = ((fn>0) ? d/cos(180/fn) : d);
// returns the real value, hole size, and number of facets
function hole_fit_fn( d=0 , tolerance=0) = [ d, ((d+tolerance)/cos(180/poly_sides((d+tolerance)))), poly_sides((d+tolerance))];

//modules
module nut_hole(d, h, center=false) {
	cylinder(d=d, h=h, $fn=6, center=center);
}

module screw(screw, h, center=false) {
	rotate([0,0,180/screw[_FN]])
	cylinder(d=screw[_VALUE], h=h, $fn=screw[_FN], center=center);
}

module rod(rod, h, center=false) {
	cylinder(d=rod[_VALUE], h=h, $fn=rod[_FN], center=center);
}

module horizontal_rod(rod, h, center=false) {
	echo("fn: ", rod[_FN]);
    echo("diameter: ", rod[_VALUE]);
    rotate([0,90,0])
    translate([0, 0, ((center) ? -h/2 : 0)])
    hull() {
        difference() {
            rotate([0,0,-45+180]) cube([rod[_VALUE]/2, rod[_VALUE]/2, h], center=false);
            translate([-rod[_VALUE], -rod[_VALUE]/2/2, -0.01])
            cube([rod[_VALUE]/2, rod[_VALUE]/2, h+0.02], center=false);
        }
		cylinder(d=rod[_VALUE], h=h, $fn=rod[_FN], center=false);
	}
}

module screw_head(screw_head, h, center=false) {
	rotate([0,0,180/screw_head[_FN]])
	cylinder(d=screw_head[_VALUE], h=h, $fn=screw_head[_FN], center=center);
}

// commonly used screws and nuts
M3_SCREW_HOLE_DIAMETER = hole_fit_fn(d=3, tolerance=SCREW_DIAMETER_TOLERANCE);
M3_SCREW_HOLE_HEAD_DIAMETER = hole_fit_fn(d=5.5, tolerance=SCREW_HEAD_DIAMETER_TOLERANCE);
M3_SCREW_HOLE_HEAD_THICKNESS = (3 + SCREW_HEAD_THICKNESS_TOLERANCE);
M3_NUT_HOLE_FLAT_WIDTH = (5.5 + NUT_FLAT_WIDTH_TOLERANCE);
M3_NUT_HOLE_DIAMETER = ((M3_NUT_HOLE_FLAT_WIDTH/cos(30)) + NUT_DIAMETER_TOLERANCE);
M3_NUT_HOLE_THICKNESS = (2.4 + NUT_THICKNESS_TOLERANCE);

M4_SCREW_HOLE_DIAMETER = hole_fit_fn(d=4, tolerance=SCREW_DIAMETER_TOLERANCE);
M4_SCREW_HOLE_HEAD_DIAMETER = hole_fit_fn(d=7, tolerance=SCREW_HEAD_DIAMETER_TOLERANCE);
M4_SCREW_HOLE_HEAD_THICKNESS = (4 + SCREW_HEAD_THICKNESS_TOLERANCE);
M4_NUT_HOLE_FLAT_WIDTH = (7 + NUT_FLAT_WIDTH_TOLERANCE);
M4_NUT_HOLE_DIAMETER = ((M4_NUT_HOLE_FLAT_WIDTH/cos(30)) + NUT_DIAMETER_TOLERANCE);
M4_NUT_HOLE_THICKNESS = (3.2 + NUT_THICKNESS_TOLERANCE);

M5_SCREW_HOLE_DIAMETER = hole_fit_fn(d=5, tolerance=SCREW_DIAMETER_TOLERANCE);
M5_SCREW_HOLE_HEAD_DIAMETER = hole_fit_fn(d=8.5, tolerance=SCREW_HEAD_DIAMETER_TOLERANCE);
M5_SCREW_HOLE_HEAD_THICKNESS = (5 + SCREW_HEAD_THICKNESS_TOLERANCE);
M5_NUT_HOLE_FLAT_WIDTH = (8 + NUT_FLAT_WIDTH_TOLERANCE);
M5_NUT_HOLE_DIAMETER = ((M5_NUT_HOLE_FLAT_WIDTH/cos(30)) + NUT_DIAMETER_TOLERANCE);
M5_NUT_HOLE_THICKNESS = (4 + NUT_THICKNESS_TOLERANCE);

M6_SCREW_HOLE_DIAMETER = hole_fit_fn(d=6, tolerance=SCREW_DIAMETER_TOLERANCE);
M6_SCREW_HOLE_HEAD_DIAMETER = hole_fit_fn(d=10, tolerance=SCREW_HEAD_DIAMETER_TOLERANCE);
M6_SCREW_HOLE_HEAD_THICKNESS = (6 + SCREW_HEAD_THICKNESS_TOLERANCE);
M6_NUT_HOLE_FLAT_WIDTH = (10 + NUT_FLAT_WIDTH_TOLERANCE);
M6_NUT_HOLE_DIAMETER = ((M6_NUT_HOLE_FLAT_WIDTH/cos(30)) + NUT_DIAMETER_TOLERANCE);
M6_NUT_HOLE_THICKNESS = (5 + NUT_THICKNESS_TOLERANCE);

M8_SCREW_HOLE_DIAMETER = hole_fit_fn(d=8, tolerance=SCREW_DIAMETER_TOLERANCE);
M8_SCREW_HOLE_HEAD_DIAMETER = hole_fit_fn(d=13, tolerance=SCREW_HEAD_DIAMETER_TOLERANCE);
M8_SCREW_HOLE_HEAD_THICKNESS = (8 + SCREW_HEAD_THICKNESS_TOLERANCE);
M8_NUT_HOLE_FLAT_WIDTH = (13 + NUT_FLAT_WIDTH_TOLERANCE);
M8_NUT_HOLE_DIAMETER = ((M8_NUT_HOLE_FLAT_WIDTH/cos(30)) + NUT_DIAMETER_TOLERANCE);
M8_NUT_HOLE_THICKNESS = (6.5 + NUT_THICKNESS_TOLERANCE);

M8_ROD_HOLE_DIAMETER = [8, hole_fit(d=(8 + ROD_DIAMETER_TOLERANCE), fn=32), 32];
M10_ROD_HOLE_DIAMETER = [10, hole_fit(d=(10 + ROD_DIAMETER_TOLERANCE), fn=40), 40];

//test
/*
horizontal_rod(rod=M10_ROD_HOLE_DIAMETER, h=20, center=true);
rotate([0,90,0])
rod(rod=M10_ROD_HOLE_DIAMETER, h=20, center=false);
*/