// new 4 wheel x carriage for openrail and dual v wheels

use <misumi-parts-library.scad>
use <dual-v-wheel.scad>
use <myLibs.scad>
use <XGantry.scad>

mm= 25.4;

columnfudge= 0.0; //fudge factor to get columns a bit bigger

//extruder_mount();

// display it for print == 1
Xcarriage(0);

// render it for model
//XcarriageModel();

//Xcarriage_with_wheels();

// the dimensions of the extrusion to run on
extrusion= 20;
extrusion_width= get_xgantry_width()+extrusion; // the side that the wheels run on
extrusion_height= 20;

line_ht= 3.6; // height of line above extrusion

// the thickness of the base
thickness = 10;

wheel_diameter = v_wheel_dia();
wheel_width= v_wheel_width();
wheel_id= v_wheel_id();
wheel_indent= v_wheel_indent();

bearingThickness= 5;
bearingOD= 16;
bearingID= 5;
bearingShaftCollar= 6;//???

wheel_penetration=0; // the amount the w wheel fits in the slot
wheel_clearance= 0; // clearance between the side of the extrusion and the carriage
pillarht= 4; // 0.25*mm + wheel_clearance;
pillardia= 8;

rounding= 22;

clearance= 0; // increase for more clearance, decrease for tighter fit
wheel_separation= extrusion_width+wheel_diameter+clearance-wheel_penetration*2; // separation of two wheels and bottom wheel for given extrusion

// calculate separation of top two wheels to make an equilateral triangle
//wheel_distance= (wheel_separation/tan(60))*2; // distance from wheel center to center of top two wheels
wheel_distance= 80;
echo("wheel distance= ", wheel_distance);

wheel_z= pillarht+wheel_width/2;
function get_wheel_z()= wheel_z;

wheelpos= [ [-wheel_distance/2, 0, 0], [wheel_distance/2, 0, 0], [-wheel_distance/2, wheel_separation, 0], [wheel_distance/2, wheel_separation, 0]];

function get_wheelpos(n) = [wheelpos[n][0], -wheel_diameter/2];

module openrail(l= 500) {
	rotate([-90,0,90]) import("openrail500.stl");
}

module XcarriageModel() {
	Xcarriage(0);
	
	// show V Wheels
	for(p= wheelpos) {
		translate(p + [0, 0, wheel_z]) v_wheel();
	}
	
	// show what we are riding on
	translate([0, get_xgantry_width()/2+10+wheel_diameter/2,  wheel_z]) {
		translate([0,0,-11.5]) Xgantry();
		translate([0, -get_xgantry_width()/2-10.8, 0]) openrail();
		translate([0, get_xgantry_width()/2+10.8, 0]) rotate([0,0,180]) openrail();
		// bolt head
		color("blue") translate([0,-get_xgantry_width()/2,-6.7]) cylinder(r=10/2, h=4);
	}

	// show extruder and hotend
	translate([0,wheel_separation/2,-thickness-5]) rotate([0,180,0]) extruder();
}

module Xcarriage_with_wheels() {
	rotate([0,180,0]) translate([0,-wheel_diameter/2,-wheel_z]) {	
		Xcarriage(0);
	
		// show W Wheels
		for(p=wheelpos)
			translate(p + [0, 0, wheel_z]) v_wheel();
	
		// show extruder and hotend
		translate([0,wheel_separation/2,-thickness-5]) rotate([0,180,0]) extruder();
	}
}

module wheel_pillar(){	
	translate([0,0,-0.1]) cylinder(r2=8/2, r1= 18/2, h=pillarht+0.1);
}

module base() {
	co= 50;
	r= rounding/2;
	translate([0,0,-thickness+0.05]) linear_extrude(height= thickness) hull() {
		for(p= wheelpos) {
			translate(p) circle(r= r);
		}
	}
}


module Xcarriage(print=1) {
	difference() {
	   union() {
			base();
			translate(wheelpos[0]) wheel_pillar();
			translate(wheelpos[1]) wheel_pillar();
			if(print == 1) {
				// print this one separatley so it can be adjustable
				translate(wheelpos[2]+[0, pillardia+5,-thickness]) wheel_pillar();
				translate(wheelpos[3]+[0, pillardia+5,-thickness]) wheel_pillar();
			}else{
				translate(wheelpos[2]) wheel_pillar();
				translate(wheelpos[3]) wheel_pillar();
			}
		}

		// negative mount for extruder
		translate([0,wheel_separation/2,-thickness/2]) rotate([0,0,90]) extruder_mount();

		// M5 holes for wheels
		translate(wheelpos[0] + [0,0,-50/2]) hole(5,50);
		translate(wheelpos[1] + [0,0,-50/2]) hole(5,50);

		if(print == 1) {
			translate([wheelpos[2][0], wheel_separation+pillardia+5, -50/2]) hole(3,50);
			// slot for adjustable wheel
		   translate([wheelpos[2][0], wheelpos[2][1], -50/2]) rotate([0,0,90]) slot(3,9,50);
		}else{
			translate(wheelpos[2] + [0,0,-50/2]) hole(5,50);
			translate(wheelpos[3] + [0,0,-50/2]) hole(5,50);
		}

		// grub screw at bottom for adjusting tightness of bottom wheels
		for(p= [wheelpos[2], wheelpos[3]]) {
			translate(p+ [0,pillardia/2+2,-thickness/2]) rotate([90,0,0]) hole(3,pillardia/2);
			translate(p+ [0,9/2+1.0,-thickness/2]) rotate([90,30,0]) nutTrap(ffd=5.46,height=5);
			#translate(p+ [0,9/2-3/2,0]) cube([5.46,3,thickness], center=true);
		}

		// groove for through cable
		#translate([0,wheel_separation/2+get_xgantry_width()/2-extrusion/2+2,-1]) cube([200,5,line_ht], center=true);

		// termination for fixed cable
		#translate([36,wheel_separation/2-get_xgantry_width()/2+extrusion/2-2,-1.5]) cube([25,10,6], center=true);
		#translate([36-25/2+3,wheel_separation/2-get_xgantry_width()/2+extrusion/2-1.5,-20/2]) hole(3, 20);

		mirror([1,0,0]) {
			#translate([36,wheel_separation/2-get_xgantry_width()/2+extrusion/2-2,-1.5]) cube([25,10,6], center=true);
			#translate([36-25/2+3,wheel_separation/2-get_xgantry_width()/2+extrusion/2-1.5,-20/2]) hole(3, 20);
		}
		
	}
}

// extruder and head
module extruder() {
        translate([-2,-2.7,0]) rotate([180,0,0]) import("JHead_hotend_blank/jhead.stl");
        translate([0,10,0]) rotate([90,0,0,0,0]) import("me_body_v5.2_3mm.stl");
}

module extruder_mount() {
	holes = 4;
	w =  get_xgantry_width() - 20 - 1;
	l= 60;
	height = thickness+2;
	
	translate([0,0,1]) difference() {
		cube([w, l, height], center=true);
		difference() {
			cube([w, l, height], center=true);
			cylinder(r=15, h=height+1, center=true, $fn=16);
		  #for (a = [-25,25]) translate([0, a, -height]) hole(holes, 2*height);
		}
	}
}