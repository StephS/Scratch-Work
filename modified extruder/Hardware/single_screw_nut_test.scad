// Tests to check the nuts_screws functions
include <..\print_config.scad>
include <obj_screw.scad>
include <func_nuts_screws_washers.scad>

myscrew = screw_obj(screw=screw_M3_socket_head, washer=washer_M3, nut=nut_M3, height=20, head_drop=5, hole_support=true);

cube_width = ((screw_head_height(screw_obj_screw(myscrew)) > 0) ?
    screw_head_top_dia(screw_obj_screw(myscrew)) :
    screw_dia(screw_obj_screw(myscrew))) + 4;

screw_from_object(myscrew);
translate ([0,0, screw_obj_height(myscrew) - 4])
    nut_obj(myscrew);

slice_cube=true;

translate([0, 0, 0])
difference() {
    translate ([-cube_width/2, -cube_width/2, 0])
        cube([cube_width, cube_width, 30]);
    screw_obj_hole(myscrew);
    translate ([0,0, screw_obj_height(myscrew) - 4])
    nut_obj_hole(myscrew, nut_slot=10);
    if (slice_cube) translate([0, 0, -1]) cube([cube_width, cube_width, 32]);
}
