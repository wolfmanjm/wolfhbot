use <misumi-parts-library.scad>;
use <y-carriage.scad>;
use <xgantry-plate.scad>;

extrusion= 20; // extrusion 2020
sides= 500; // side length of cube in mm
sep1= sides/2+extrusion/2; // separation of each side
sep= sides;
height= sides-extrusion/2;
bsep= sides/2;
bsep1= sides/2+extrusion/2;
bheight= sides-extrusion;
Xgantry_width=65;

carriage_ht= 22;
carriage_width= 5;

xgantry_length= sides+extrusion*2+carriage_width*2;
echo("xgantry length= ", xgantry_length);
sidelen= Xgantry_width+extrusion;
echo("side length= ", sidelen);
echo("gap= ", sidelen-extrusion*2);

%translate([0,0,-height-extrusion/2]) top();

function get_xgantry_width()= Xgantry_width;
function get_xgantry_length()= xgantry_length;


gantry(0);
//translate([0,0,carriage_ht]) rotate([0,0,0]) extruder();
translate([sep1+10,0,carriage_ht-10]) rotate([0,0,90]) mounting_plate();

// extruder and head
module extruder() {
	translate([-2,-2.7,0]) rotate([180,0,0]) import("JHead_hotend_blank/jhead.stl");
	translate([0,10,0]) rotate([90,0,0,0,0]) import("me_body_v5.2_3mm.stl");
}

module gantry(xpos=0) {
	translate([0,0,4]) Xgantry(xpos);
	translate([sep1+10,0,-10]) rotate([0,0,90]) Ycarriage_with_wheels();
	translate([-sep1-10,0,-10]) rotate([0,0,-90]) Ycarriage_with_wheels();
	//translate([xpos,0,carriage_ht+10]) rotate([0,0,0]) Ycarriage_with_wheels();
}

module Xgantry(xpos= 0) {
	translate([xgantry_length/2,Xgantry_width/2,carriage_ht]) rotate([0,0,90]) hfs2020(xgantry_length);
	translate([xgantry_length/2,-Xgantry_width/2,carriage_ht]) rotate([0,0,90]) hfs2020(xgantry_length);
	translate([xgantry_length/2+extrusion/2,-sidelen/2,carriage_ht]) hfs2020(sidelen);
	translate([-xgantry_length/2-extrusion/2,-sidelen/2,carriage_ht]) hfs2020(sidelen);
	
	//brackets
	translate([xgantry_length/2,-Xgantry_width/2+10,carriage_ht+10]) rotate([0,90,90]) hblfsnf5();
	translate([xgantry_length/2,Xgantry_width/2-10,carriage_ht-10]) rotate([0,-90,90]) hblfsnf5();
	translate([-xgantry_length/2,-Xgantry_width/2+10,carriage_ht-10]) rotate([0,-90,-90]) hblfsnf5();
	translate([-xgantry_length/2,Xgantry_width/2-10,carriage_ht+10]) rotate([0,90,-90]) hblfsnf5();
}



module top() {
	// top
	translate([-sep1,-sep/2,height]) hfs2020(sides);
	translate([sep1,-sep/2,height]) hfs2020(sides);
	translate([sep/2,sep1,height]) rotate([0,0,90]) hfs2020(sides);
	translate([sep/2,-sep1,height]) rotate([0,0,90]) hfs2020(sides);
}
