use <misumi-parts-library.scad>
use <w-wheel.scad>
use <../myLibs.scad>

extrusion_width= 20; // 2020
thickness = 10;

wheel_distance= 66; // distance from wheel center to center of top two wheels

wheel_diameter = w_wheel_dia();
wheel_width= w_wheel_width();

bearingThickness= 7;
bearingOD= 22;
bearingID= 8;

pillarht= 18;
pillardia= 19;
clearance= 0; // increase for more clearance, decrease for tighter fit
wheel_separation= extrusion_width+wheel_diameter+clearance; // separation of two wheels and bottom wheel for given extrusion

Ycarriage();

wheel_z= pillarht+wheel_width/2;
%translate([-wheel_distance/2, 0, wheel_z]) w_wheel();
%translate([wheel_distance/2, 0, wheel_z]) w_wheel();
%translate([0, wheel_separation, wheel_z]) w_wheel();


%translate([200/2, wheel_separation/2, wheel_z]) rotate([0, 0, 90]) hfs2020(200);

module oldXcarriage() {
translate([0, 0, thickness/2])
	difference() {
	  union() {
	    for (x = [-wheelx, wheelx]) {
	      for (y = [-wheely, wheely]) {
	        translate([x, y, 0]) {
				#cylinder(r=8, h=thickness, center=true);
				translate([0,0,thickness/2]) standoff();
	 			//%translate([0, 0, thickness/2 + bearingThickness/2+standoffht]) w_wheel();
	        }
	      }
	    }
	    for (a = [-extrusion_width, extrusion_width]) rotate([0, 0, a]) difference() {
	      cube([8, d*2, thickness], center=true);
	      translate([0, 0, 50]) rotate([0, 90, 0])
	        cylinder(r=50, h=8.1, center=true, $fn=120);
	    }
	  }
	  for (x = [-wheelx, wheelx]) {
	    for (y = [-wheely, wheely]) {
	      translate([x, y, -thickness/2]) {
	        hole(8, thickness+5);
	      }
	    }
	  }
	}
}

module wheel_pillar(){
	ht= pillarht;
	translate([0,0,ht/2]) union() {
		cylinder(r1=pillardia/2, r2=16/2, h=ht, center=true);
		translate([0,0,ht/2]) cylinder(r=8/2, h=7);
	}
}

module base() {
	r= 19/2;
	difference() {
		translate([0,0,-thickness]) linear_extrude(height= thickness) hull() {
			translate([-wheel_distance/2,0,0]) circle(r= r);
			translate([wheel_distance/2,0,0]) circle(r= r);
			translate([0,wheel_separation,0]) circle(r= r);
		}
		#translate([wheel_separation/2+6,wheel_distance/2+2,-thickness]) cylinder(r=50/2, h= thickness);
		#translate([-wheel_separation/2-6,wheel_distance/2+2,-thickness]) cylinder(r=50/2, h= thickness);
	}
}

module Ycarriage() {
	union() {
		base();
		translate([-wheel_distance/2,0,0]) wheel_pillar();
		translate([wheel_distance/2,0,0]) wheel_pillar();
		translate([0,wheel_separation,0]) wheel_pillar();
	}
}

