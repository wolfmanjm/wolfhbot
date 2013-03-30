use <misumi-parts-library.scad>
use <w-wheel.scad>

// the dimensions of the extrusion to run on
extrusion_width= 20; // the side that the wheels run on
extrusion_height= 20;

// the thickness of the base
thickness = 10;

wheel_distance= 66; // distance from wheel center to center of top two wheels

wheel_diameter = w_wheel_dia();
wheel_width= w_wheel_width();
wheel_id= w_wheel_id();

bearingThickness= 7;
bearingOD= 22;
bearingID= 8;

wheel_clearance= 2; // clearance between the side of the extrusion and the carriage
pillarht= extrusion_height/2-wheel_width/2+wheel_clearance;
pillardia= 19;
clearance= 0; // increase for more clearance, decrease for tighter fit
wheel_separation= extrusion_width+wheel_diameter+clearance; // separation of two wheels and bottom wheel for given extrusion

Ycarriage();

wheel_z= pillarht+wheel_width/2;
%translate([-wheel_distance/2, 0, wheel_z]) w_wheel();
%translate([wheel_distance/2, 0, wheel_z]) w_wheel();
%translate([0, wheel_separation, wheel_z]) w_wheel();


%translate([200/2, wheel_separation/2, wheel_z]) rotate([0, 0, 90]) hfs2020(200);

function get_wheel_z()= wheel_z;

// used to clean the base around the pillar using an intersection
module wheel_pillar_cutout(h=thickness) {
	translate([0,0,-thickness/2]) union() {
		cylinder(r=pillardia/2, h=h, center=true);
		translate([0, -100/2, 0]) cube([pillardia,100,h], center=true);
		translate([0, -200/2-pillardia/2, 0]) cube([200,200,h], center=true);
	}
}

module wheel_pillar(){
	ht= pillarht;
	translate([0,0,ht/2]) union() {
		cylinder(r1=pillardia/2, r2=16/2, h=ht, center=true);
		translate([0,0,ht/2]) cylinder(r=bearingID/2, h=bearingThickness);
	}
}

module base() {
	r= pillardia/2;
	difference() {
		translate([0,0,-thickness]) linear_extrude(height= thickness) hull() {
			translate([-wheel_distance/2,0,0]) circle(r= r);
			translate([wheel_distance/2,0,0]) circle(r= r);
			translate([0,wheel_separation,0]) circle(r= r);
		}
		translate([wheel_separation/2+6,wheel_distance/2+2,-thickness-0.1]) cylinder(r=50/2, h= thickness+0.2);
		translate([-wheel_separation/2-6,wheel_distance/2+2,-thickness-0.1]) cylinder(r=50/2, h= thickness+0.2);
		translate([0,-8,-thickness-0.1]) cylinder(r=40/2, h= thickness+0.2);
	}
}

module Ycarriage() {
	union() {
		intersection() {
			base();
			translate([0,wheel_separation,0]) wheel_pillar_cutout();
			translate([-wheel_distance/2,0,0]) rotate([0,0,90]) wheel_pillar_cutout();
			translate([wheel_distance/2,0,0]) rotate([0,0,-90]) wheel_pillar_cutout();
		}
		translate([-wheel_distance/2,0,0]) wheel_pillar();
		translate([wheel_distance/2,0,0]) wheel_pillar();
		translate([0,wheel_separation,0]) wheel_pillar();
	}
}

