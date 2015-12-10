// conf_nuts_screws.scad
// Released under Attribution 3.0 Unported (CC BY 3.0) 
// http://creativecommons.org/licenses/by/3.0/
// Stephanie Shaltes
// This holds all of the dimensions for the fans
// also holds all of the access functions

// Select your fan type *********************
// hole seperation = 0
// outer dimensions = 1
// thickness = 2
// name = 3

function fan_hole_distance(type) = type[0];
function fan_size(type) = type[1];
function fan_name(type) = type[2];

fan_30mm = [ 24, [30, 30, 10], "30mm Fan, 10mm thickness"];
fan_40mm = [ 32, [40, 40, 10], "40mm Fan, 10mm thickness"];