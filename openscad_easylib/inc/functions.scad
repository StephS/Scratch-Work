// PRUSA iteration3
// Functions used in many files
// GNU GPL v3
// Josef Pr?ša <josefprusa@me.com>
// Václav 'ax' H?la <axtheb@gmail.com>
// Vlnofka <>
// http://www.reprap.org/wiki/Prusa_Mendel
// http://github.com/prusajr/PrusaMendel
include <fillets.scad>
//include <nuts_screws.scad>

use_fillets=true;

module chamfer(x=10,y=10,z=10) {
 rotate(a=[90,-90,0])
 linear_extrude(height = y, center = true, convexity = 2, twist = 0)
 polygon(points = [
[-1.00,-1.00]
,[-1.00,x-1.00]
,[0.00,x]
,[z,0.00]
,[z-1.00,-1.00]
]
,paths = [
[0,1,2,3,4]]
       );
}

function calc_z_angle(rotation) = (acos(cos(rotation[1])*cos(rotation[0])));

function sagitta_arc(r, angle) = (r* (1 - cos(angle/2) ));

function sagitta(r, l) = r - sqrt(pow(r,2) - pow(l,2));

// calculate the radius of a circle to meet the given saggita. 
// s is the depth from the center of the arc to it's base it can be thought of as the depth of the arc.
// l is the 1/2 the width of the base of the arc, or the arm of the arc
// by defining these 2 points it will return the required radius of the arc to be tangent with these (3) points.
// It's 3 points as l is computed in both sides of the arc, like an isosceles triangle.
function sagitta_radius(s, l) = (pow(s,2) + pow(l,2))/ (2*s);
//function sagitta_radius(s, l) = (hypotenuse / 2) / cos(90 - atan(short side / long side));

//
module cylinder_slot(r=0, r1, r2, h, length=0, center=false, fn=0) {
	n = (fn > 0) ? fn : max(poly_sides(r*2), poly_sides(r1*2), poly_sides(r2*2));
	
	//temporary fix using hull() until I find the broken math
	hull()
	union() {
		rotate([0,0, 180/n]) cylinder_poly(h=h, r=r, r1=r1, r2=r2, center=center, fn=n);
		if (length>0) {
			//translate([((center) ? length/2 : 0),((center) ? 0 : -((r>0) ? r : r1)*cos(180/n)), 0]) trapezoid(cube=[length, ((r>0) ? r*2 : r1*2) *cos(180/n),h], y1=(r1-r2)*cos(180/n), y2=(r1-r2)*cos(180/n), center=center);
			//cube([length, dia*cos(180/n),h]);
			translate([length, 0, 0]) rotate([0,0, 180/n-180]) cylinder_poly(h=h, r=r, r1=r1, r2=r2, center=center, fn=n);
		}
	}
}

module trapezoid(cube=[10, 10, 10], x1=0, x2=0, y1=0, y2=0, center=false) {
	translate((center) ? [0,0,0] : [cube[0]/2, cube[1]/2, cube[2]/2] ) {
		difference() {
			translate([0, 0 ,0]) cube(cube, center=true);
			if (x2 >0 ) translate([cube[0]/2, -(cube[1]+0.1)/2, -cube[2]/2]) rotate([0,-atan(x2/cube[2]),0]) cube([x2*cos(atan(x2/cube[2]))+0.1, cube[1]+0.1, sqrt( pow(cube[2], 2) + pow(x2, 2))]);
			if (x1 >0 ) translate([-cube[0]/2, -(cube[1]+0.1)/2, -cube[2]/2]) rotate([0,atan(x1/cube[2]),0]) translate([ -(x1*cos(atan(x1/cube[2]))+0.1), 0, 0]) cube([x1*cos(atan(x1/cube[2]))+0.1, cube[1]+0.1, sqrt( pow(cube[2], 2) + pow(x1, 2))]);
			if (y1 >0 ) translate([-(cube[0]+0.1)/2, -cube[1]/2, -cube[2]/2]) rotate([-atan(y1/cube[2]),0,0]) translate([ 0, -(y1*cos(atan(y1/cube[2]))+0.1), 0]) cube([cube[0]+0.1, y1*cos(atan(y1/cube[2]))+0.1, sqrt( pow(cube[2], 2) + pow(y1, 2))]);
			if (y2 >0 ) translate([-(cube[0]+0.1)/2, cube[1]/2, -cube[2]/2]) rotate([atan(y2/cube[2]),0,0]) cube([cube[0]+0.1, y2*cos(atan(y2/cube[2]))+0.1, sqrt( pow(cube[2], 2) + pow(y2, 2))]);
		}
	}
}

module cube_fillet(size, radius=-1, vertical=[3,3,3,3], top=[0,0,0,0], bottom=[0,0,0,0], center=false, $fn=0, vertical_fn=[0,0,0,0], top_fn=[0,0,0,0], bottom_fn=[0,0,0,0]){
    //
    render(convexity = 2)
    if (use_fillets) {
        if (center) {
            cube_fillet_inside(size, radius, vertical, top, bottom, $fn, vertical_fn, top_fn, bottom_fn);
        } else {
            translate([size[0]/2, size[1]/2, size[2]/2])
                cube_fillet_inside(size, radius, vertical, top, bottom, $fn, vertical_fn, top_fn, bottom_fn);
        }
    } else {
        cube(size, center);
    }
}