use <misumi-parts-library.scad>;
use <y-carriage.scad>;

extrusion= 20; // extrusion 2020
sides= 500; // side length of cube in mm
sep1= sides/2+extrusion/2; // separation of each side
sep= sides;
height= sides-extrusion/2;
bsep= sides/2;
bsep1= sides/2+extrusion/2;
bheight= sides-extrusion;


carriage_ht= 35;
carriage_width= 12;

xgantry_length= sides+extrusion*2+carriage_width*2;
echo("xgantry length= ", xgantry_length);

%translate([0,0,-height-extrusion/2]) top();

Xgantry(0);

module Xgantry(xpos= 0) {
	translate([xgantry_length/2,0,carriage_ht]) rotate([0,0,90]) hfs2020(xgantry_length);
	translate([sep1,0,0]) rotate([0,0,90]) Ycarriage_with_wheels();
	translate([-sep1,0,0]) rotate([0,0,-90]) Ycarriage_with_wheels();
	translate([xpos,0,carriage_ht+10]) rotate([0,0,0]) Ycarriage_with_wheels();
}



module top() {
	// top
	translate([-sep1,-sep/2,height]) hfs2020(sides);
	translate([sep1,-sep/2,height]) hfs2020(sides);
	translate([sep/2,sep1,height]) rotate([0,0,90]) hfs2020(sides);
	translate([sep/2,-sep1,height]) rotate([0,0,90]) hfs2020(sides);
}
