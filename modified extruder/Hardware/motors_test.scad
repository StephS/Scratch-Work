// conf_motors.scad
// Released under Attribution 3.0 Unported (CC BY 3.0) 
// http://creativecommons.org/licenses/by/3.0/
// Stephanie Shaltes
// This holds all of the functions for the motors

include <func_motors.scad>;

motor_plate_size=[42, 42, 10];
my_motor_screw = screw_obj(screw=screw_M3_socket_head, washer=washer_M3, nut=-1, height=motor_plate_size[2], head_drop=0, slot_length=5, slot_offset=0, hole_support=false, horizontal=false, hole_fn=-1, head_fn=-1, name=-1);
my_motor = motor_obj(motor=motor_nema17, screw_objects=[my_motor_screw, my_motor_screw, my_motor_screw, my_motor_screw], name=-1);

// a plate with screw holes to mount the motor to
motor_plate(motor_object = my_motor, size=motor_plate_size, offset=[0,0], vertical_fillet=[0,0,0,0], slot_angles=[0, 0, 0, 0], flange_slot_length=5, shadow=true, $fn=0);