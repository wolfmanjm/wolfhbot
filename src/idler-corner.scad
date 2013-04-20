use <misumi-parts-library.scad>;
use <myLibs.scad>

thick= 4;
h= 50;

// the dimensions of the extrusion
extrusion_width= 20;
extrusion_height= 20;

bearingThickness= 7;
bearingOD= 22;
bearingID= 8;
bearingShaftCollar= 11.5;
wheel_width= bearingThickness;
wheel_indent= 2;
pillarht= 40;
pillardia= 20;


rotate([180,0,0]) 
idler_mount();
% translate([10,10,0]) rotate([0,0,-90]) corner();

module corner() {
	translate([10,0,10]) hfs2020(80);
	translate([0,-10,10]) rotate([0,0,90]) hfs2020(80);
	translate([10,-10,0]) rotate([90,0,0]) hfs2020(80);
}

module corner_bracket() {
  	difference() {
		translate([-thick,-thick,0]) union() {
			cube([20+thick,thick,h]);
			cube([thick,20+thick,h]);
		}
	   translate([10,-thick-1,h/2]) rotate([0,90,90]) hole(5, thick+2);
		translate([10,-thick-1,h/4]) rotate([0,90,90]) hole(5, thick+2);
	   	translate([10,-thick-1,h-(h/4)]) rotate([0,90,90]) hole(5, thick+2);       
	   translate([-thick-1,10,h/2]) rotate([0,90,0]) hole(5, thick+2);
		translate([-thick-1,10,h/4]) rotate([0,90,0]) hole(5, thick+2);
	   	translate([-thick-1,10,h-h/4]) rotate([0,90,0]) hole(5, thick+2);       
	}
}

module wheel_pillar(){
        ht= pillarht-bearingThickness+wheel_indent-bearingThickness/2-thick-5;
        translate([0,0,ht/2]) union() {
                cylinder(r1=pillardia/2, r2=16/2, h=ht, center=true);
                translate([0,0,ht/2-0.05]) cylinder(r=bearingID/2, h=bearingThickness+wheel_indent, $fn=64);
                translate([0,0,ht/2-0.05]) cylinder(r1=16/2, r2= bearingShaftCollar/2, h=wheel_indent);
        }
}

module idler_mount() {
	union() {
		translate([-10,-10,-thick]) corner_bracket();
		translate([-10.1,-10.1,-thick]) cube([20.1,20.1,thick]);
		translate([0,0,-thick+0.1]) rotate([180,0,0]) wheel_pillar();
	}
}