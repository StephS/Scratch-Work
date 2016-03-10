// conf_motors.scad
// Released under Attribution 3.0 Unported (CC BY 3.0) 
// http://creativecommons.org/licenses/by/3.0/
// Stephanie Shaltes
// This holds all of the dimensions for the motors
// also holds all of the access functions

include <hdw_motors.scad>
include <func_nuts_screws_washers.scad>

// accessor functions
function motor_obj_motor(type) = type[0];
function motor_obj_screw_objects(type) = type[1];
function screw_obj_name(type) = type[2];

//screw objects is an array of 4 screw objects. Set the slot and screw parameters for each screw. use -1 if no screw will be at that location.

// creates the motor object
function motor_obj(motor=-1, screw_objects=[-1, -1, -1, -1], name=-1) =
	[motor,
	screw_objects,
	(name==-1) ? ((motor==-1) ? "No Name" : motor_name(motor)) : name];