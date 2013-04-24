use <w-wheel.scad>

// the dimensions of the extrusion to run on
extrusion_width= 20; // the side that the wheels run on
extrusion_height= 20;
extrusion= 20; // the smaller of the two dimensions

wheel_diameter = w_wheel_dia();
wheel_width= w_wheel_width();
wheel_id= w_wheel_id();
wheel_indent= w_wheel_indent();

pillardia= 19;

bearingThickness= 7;
bearingOD= 22;
bearingID= 8;
bearingShaftCollar= 11.5;

sides= 500; // side length of frame in mm
height= sides-extrusion/2; // height of frame
