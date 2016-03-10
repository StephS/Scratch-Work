// Tests to check the nuts_screws functions
include <..\print_config.scad>
include <assy_screw.scad>
include <func_nuts_screws_washers.scad>

myscrew = screw_obj(screw=screw_M3_hex_head, height=20, head_drop=0, hole_support=true, hole_fn=-1, head_fn=-1);
cube_width = ((screw_head_height(screw_obj_screw(myscrew)) > 0) ?
    screw_head_top_dia(screw_obj_screw(myscrew)) :
    screw_dia(screw_obj_screw(myscrew))) + 4;

screw_from_object(myscrew);

slice_cube=true;

translate([0, 0, 30])
difference() {
    translate ([-cube_width/2, -cube_width/2, 0])
        cube([cube_width, cube_width, 30]);
    screw_obj_hole(myscrew);
    if (slice_cube) translate([0, 0, -1]) cube([cube_width, cube_width, 32]);
}
