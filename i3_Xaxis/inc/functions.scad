// Stephs
// new primitives! new shapes!
include <fillets.scad>

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

// it's possible to create all objects centered, then translate as necessary, but if we're not careful then this can cause issues.
// determine the type of center veriable given
// if it's single like center=true/false, then assign the value to the entire array
function center_test(center) = (len(center)==undef) ? [center, center, center] : center;
// specifically for cylinders and spheres, to duplicate the normal usage
function center_test_cylinder(center) = (len(center)==undef) ? [true, true, center] : center;

// set the translate for center operations.
// this should be applied only to centered objects
function center_translate(size_array, center_array) = [(center_array[0]) ? 0 : size_array[0]/2, (center_array[1]) ? 0 : size_array[1]/2, (center_array[2]) ? 0 : size_array[2]/2];

function calc_z_angle(rotation) = (acos(cos(rotation[1])*cos(rotation[0])));

function sagitta_arc(r, angle) = (r* (1 - cos(angle/2) ));

function sagitta(r, l) = r - sqrt(pow(r,2) - pow(l,2));

function sagitta_radius(s, l) = (pow(s,2) + pow(l,2))/ (2*s);
//function sagitta_radius(s, l) = (hypotenuse / 2) / cos(90 - atan(short side / long side));

// This will size an outer diameter to fit inside dia with $fn sides
// use this to set the diameter before passing to polyhole
function hole_fit( dia=0, fn=0) = (dia/2)/cos(180/((fn>0) ? fn : 0.01))*2;
function hole_fit_poly( dia=0) = (dia/2)/cos(180/poly_sides(dia))*2;

// This determines the number of sides of a hole that is printable
// I added +1 because nobody wants to print a triangle. (plus it looks nicer, havn't tested printability yet.)
// made it return an even number of sides. it works better for operations like hull
function poly_sides(d) = (ceil((max(round(2 * d),3)+1)/4)*4);

function poly_sides_helper(fn=0, d) = ((d==undef) ? 0 : ((fn>0) ? fn : poly_sides(d)));

// depreciated functions
/*
// Based on nophead research
module polyhole(d, d1, d2, h, center=false, fn=0) {
    n = max(poly_sides_helper(fn, d), poly_sides_helper(fn, d1), poly_sides_helper(fn, d2));
    cylinder(h = h, d = d, d1 = d1, d2 = d2, $fn = n, center=center);
}

// make it interchangeable between this and cylinder
module cylinder_poly(r, r1, r2, h, center=false, fn=0){
    polyhole(d=r*2, d1=r1*2, d2=r2*2, h=h, center=center, fn = fn);
}

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
*/

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
    mycenter=center_test(center);
    mysize=(len(size)==undef) ? [size, size, size] : size;
    //echo(mycenter);	
    
    render(convexity = 2)
    if (use_fillets) {
        translate(center_translate(mysize, mycenter))
    		cube_fillet_inside(size, radius, vertical, top, bottom, $fn, vertical_fn, top_fn, bottom_fn);
    		//echo(size);
    } else {
        cube(size, center);
    }
}

module _cube(size, center=false) {
    mycenter=center_test(center);
    mysize=(len(size)==undef) ? [size, size, size] : size;
    translate(center_translate(mysize, mycenter))
        cube(size=mysize, center=true);
}

// the below functions are for duplicating the standard functionality of

function find_d1(r, r1, r2, d, d1, d2) = (d1!=undef) ?
                                                        d1 
                                                    :
                                                        (d2!=undef) ?
                                                            (r1!=undef) ?
                                                                r1*2
                                                            :
                                                                (d!=undef) ?
                                                                    d
                                                                :
                                                                    (r!=undef) ?
                                                                        r*2
                                                                    :
                                                                        2
                                                        :
                                                            (r1!=undef) ?
                                                                r1*2 
                                                            :
                                                                 (d!=undef) ?
                                                                    d
                                                                :
                                                                    (r!=undef) ?
                                                                        r*2
                                                                    :
                                                                        2;
                                                                    
function find_d2(r, r1, r2, d, d1, d2) = (d2!=undef) ?
                                                        d2 
                                                    :
                                                        (d1!=undef) ?
                                                            (r2!=undef) ?
                                                                r2*2
                                                            :
                                                                (d!=undef) ?
                                                                    d
                                                                :
                                                                    (r!=undef) ?
                                                                        r*2
                                                                    :
                                                                        2
                                                        :
                                                            (r2!=undef) ?
                                                                r2*2 
                                                            :
                                                                (d!=undef) ?
                                                                    d
                                                                :
                                                                    (r!=undef) ?
                                                                        r*2
                                                                    :
                                                                        2;

// if d is given and d1, then d2=d
// if r is given and d2, d1=r*2
// if d1 is given, and d2 or d or r2 or r is not, then r1=1
// if r2 is defined, check for r1.
// if r1 is defined, check for r2.
// cylinder order of precedence
// d2, d1, r2, r1, d, r
// set length > 0 to define a slot
module _cylinder(h, r, r1, r2, center=[true,true,false], d, d1, d2, length=0, $fn=0) {
    
    mycenter=center_test_cylinder(center);
    my_d1=find_d1(r, r1, r2, d, d1, d2);
    my_d2=find_d2(r, r1, r2, d, d1, d2);
    larger_d = max(my_d1, my_d2);
    
    // utilize polysides for all cylinders
    n = ($fn > 0) ? $fn : poly_sides(larger_d);

    mysize=[larger_d, larger_d, h];

    translate(center_translate(mysize, mycenter))
        render()
        hull() {
            rotate([0,0, 180/n])
            cylinder(h=h, d1=my_d1, d2=my_d2, center=true, $fn=n);
            if (length > 0) {
                // second side of the elongated cylinder
                translate([length, 0, 0]) rotate([0,0, 180/n-180]) cylinder(h=h, d1=my_d1, d2=my_d2, center=true, $fn=n);
                    // this is kind of a hack that makes it easy to make elongated holes and cones.
                    intersection() {
                        _cube([length, larger_d, h], center=[false,true,true]);
                        union() {
                            rotate([0,0,45])
                            cylinder(h=h, d1=my_d1/cos(45), d2=my_d2/cos(45), center=true, $fn=4);
                            translate([length, 0, 0]) rotate([0,0,45]) cylinder(h=h, d1=my_d1/cos(45), d2=my_d2/cos(45), center=true, $fn=4);
                        }
                }
            }
        }
}

// this makes a cylinder that fits outside/around the object of the diameter
// this is nearly a duplicate of _cylinder, but because of bugs using $fn I cannot simply call _cylinder
module _cylinder_outer(h, r, r1, r2, center=[true,true,false], d, d1, d2, length=0, $fn=0) {
    mycenter=center_test_cylinder(center);
    my_d1=find_d1(r, r1, r2, d, d1, d2);
    my_d2=find_d2(r, r1, r2, d, d1, d2);
    
    larger_d = max(my_d1, my_d2);
    
    // utilize polysides for all cylinders
    n = ($fn > 0) ? $fn : poly_sides(larger_d);
    
    // find the new diameter
    my_d1_outer=(my_d1/2)/cos(180/n)*2;
    my_d2_outer=(my_d2/2)/cos(180/n)*2;
    
    larger_d_outer=max(my_d1_outer, my_d2_outer);
    
    mysize=[larger_d_outer, larger_d_outer, h];

    translate(center_translate(mysize, mycenter)) 
        render()
        hull() {
            rotate([0,0, 180/n])
            cylinder(h=h, d1=my_d1_outer, d2=my_d2_outer, center=true, $fn=n);
            if (length > 0) {
                // second side of the elongated cylinder
                translate([length, 0, 0]) rotate([0,0, 180/n-180]) cylinder(h=h, d1=my_d1_outer, d2=my_d2_outer, center=true, $fn=n);
                    // this is kind of a hack that makes it easy to make elongated holes and cones.
                    intersection() {
                        _cube([length, larger_d_outer, h], center=[false,true,true]);
                        union() {
                            rotate([0,0,45])
                            cylinder(h=h, d1=my_d1_outer/cos(45), d2=my_d2_outer/cos(45), center=true, $fn=4);
                            translate([length, 0, 0]) rotate([0,0,45]) cylinder(h=h, d1=my_d1_outer/cos(45), d2=my_d2_outer/cos(45), center=true, $fn=4);
                        }
                }
            }
        }
}

// determine the diameter of a outer diameter cylinder
function _cylinder_outer_dia(d, $fn=0) = (d/2)/cos(180/(($fn>0) ? $fn : poly_sides(d)))*2;

// this function returns the number of sides on a standard cylinder
// you can copy and paste what you put into a cylinder into here
function _cylinder_fn(r, r1, r2, d, d1, d2, $fn=0) = ($fn > 0) ? $fn : poly_sides(max(find_d1(r, r1, r2, d, d1, d2), find_d2(r, r1, r2, d, d1, d2)));

// haven't tested this yet. it should work, i think.
// could easily make it slotted like the cylinder. not sure how useful that would be.
module _sphere(r, center=[true,true,false], d) {
    mycenter=center_test_cylinder(center);
    my_d=(d!=undef) ? d : r*2;
    mysize=[my_d, my_d, my_d];
    translate(center_translate(mysize, mycenter))
        cylinder(h=h, d1=my_d1, d2=my_d2, center=true);
}