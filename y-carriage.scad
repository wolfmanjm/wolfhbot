use <misumi-parts-library.scad>
use <w-wheel.scad>
use <myLibs.scad>

// display it for print
Ycarriage(1);

// render it for model
//YcarriageModel();

//carriage_with_wheels();

// the dimensions of the extrusion to run on
extrusion_width= 20; // the side that the wheels run on
extrusion_height= 20;

// the thickness of the base
thickness = 10;

wheel_diameter = w_wheel_dia();
wheel_width= w_wheel_width();
wheel_id= w_wheel_id();
wheel_indent= w_wheel_indent();

bearingThickness= 7;
bearingOD= 22;
bearingID= 8;
bearingShaftCollar= 11.5;

wheel_penetration=1; // the amount the w wheel fits in the slot
wheel_clearance= 2; // clearance between the side of the extrusion and the carriage
pillarht= extrusion_height/2-wheel_width/2+wheel_clearance;
pillardia= 19;
clearance= 0; // increase for more clearance, decrease for tighter fit
wheel_separation= extrusion_width+wheel_diameter+clearance-wheel_penetration*2; // separation of two wheels and bottom wheel for given extrusion

// calculate separation of top two wheels to make an equilateral triangle
wheel_distance= (wheel_separation/tan(60))*2; // distance from wheel center to center of top two wheels
echo("wheel distance= ", wheel_distance);

wheel_z= pillarht+wheel_width/2;
function get_wheel_z()= wheel_z;

wheelpos= [ [-wheel_distance/2, 0], [wheel_distance/2, 0], [0, wheel_separation] ];

module YcarriageModel() {
	Ycarriage(0);
	
	// show W Wheels
	%translate([-wheel_distance/2, 0, wheel_z]) w_wheel();
	%translate([wheel_distance/2, 0, wheel_z]) w_wheel();
	%translate([0, wheel_separation, wheel_z]) w_wheel();
	
	// show 2020 beam we are riding on
	%translate([200/2, wheel_separation/2, wheel_z]) rotate([0, 0, 90]) hfs2020(200);

	%translate([0, -20, -thickness]) rotate([90,0,90]) hfs2020(50);
}

module Ycarriage_with_wheels() {
	rotate([-90,0,0]) translate([0,-wheel_diameter/2,-wheel_z]) {	
		Ycarriage(0);
	
		// show W Wheels
		for(p=wheelpos)
			translate([p[0], p[1], wheel_z]) w_wheel();
	}
}

module wheel_pillar(){
	ht= pillarht;
	translate([0,0,ht/2]) union() {
		cylinder(r1=pillardia/2, r2=16/2, h=ht, center=true);
		translate([0,0,ht/2-0.05]) cylinder(r=bearingID/2, h=bearingThickness+wheel_indent, $fn=64);
		translate([0,0,ht/2-0.05]) cylinder(r1=16/2, r2= bearingShaftCollar/2, h=wheel_indent);
	}
}

module base() {
	co= 33;
	r= pillardia/2;
	difference() {
		translate([0,0,-thickness+0.05]) linear_extrude(height= thickness) hull() {
			translate([-wheel_distance/2,0,0]) circle(r= r);
			translate([wheel_distance/2,0,0]) circle(r= r);
			translate([0,wheel_separation,0]) circle(r= r);
		}
		translate([0,co/2+3,-thickness-0.1]) cylinder(r=co/2, h= thickness+0.2);
	}
}

// bracket for 2020 extrusion connection
module flange(width) {
	difference() {
		cube([5,20,width]);
		#translate([5/2-5/2-0.25, 20/2,width/2]) rotate([0,90,0]) hole(5, 5+0.5);
	}
}

module Ycarriage(print=1) {
	difference() {
	   union() {
			base();
			translate([wheelpos[0][0], wheelpos[0][1],0]) wheel_pillar();
			translate([wheelpos[1][0], wheelpos[1][1],0]) wheel_pillar();
			if(print == 1) {
				// print this one separatley so it can be adjustable
				translate([wheelpos[2][0], wheelpos[2][1]+pillardia+5,-thickness]) wheel_pillar();
			}else{
				translate([wheelpos[2][0],wheelpos[2][1],0]) wheel_pillar();
			}
			translate([10.05,-pillardia/2-20+0.1,-(15/2+thickness/4)]) flange(15);
			translate([-10.05-5,-pillardia/2-20+0.1,-(15/2+thickness/4)]) flange(15);
		}
		// M3 holes for wheels
		translate([wheelpos[0][0], wheelpos[0][1], -50/2]) hole(3,50);
		translate([wheelpos[1][0], wheelpos[1][1], -50/2]) hole(3,50);
		if(print == 1) {
			translate([wheelpos[2][0], wheel_separation+pillardia+5, -50/2]) hole(3,50);
			// slot for adjustable wheel
		   translate([wheelpos[2][0], wheelpos[2][1], -50/2]) rotate([0,0,90]) slot(3,9,50);
		}else{
			translate([wheelpos[2][0], wheelpos[2][1], -50/2]) hole(3,50);
		}
	}
}

