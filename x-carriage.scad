use <misumi-parts-library.scad>
use <w-wheel.scad>
use <myLibs.scad>
use <XGantry.scad>

columnfudge= 0.0; //fudge factor to get columns a bit bigger

//extruder_mount();

// display it for print
Xcarriage(1);

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
//wheel_distance= (wheel_separation/tan(60))*2; // distance from wheel center to center of top two wheels
wheel_distance= 100;
echo("wheel distance= ", wheel_distance);

wheel_z= pillarht+wheel_width/2;
function get_wheel_z()= wheel_z;

wheelpos= [ [-wheel_distance/2, 0], [wheel_distance/2, 0], [0, wheel_separation] ];
function get_wheelpos(n) = [wheelpos[n][0], -wheel_diameter/2];

module XcarriageModel() {
	Xcarriage(0);
	
	// show W Wheels
	%translate([-wheel_distance/2, 0, wheel_z]) w_wheel();
	%translate([wheel_distance/2, 0, wheel_z]) w_wheel();
	%translate([0, wheel_separation, wheel_z]) w_wheel();
	
	// show what we are riding on
	%translate([0, wheel_separation/2, -10]) rotate([0, 0, 0]) Xgantry();

	// show extruder and hotend
	//translate([0,wheel_separation/2,-thickness-5]) rotate([0,180,0]) extruder();
}

module Xcarriage_with_wheels() {
	rotate([0,180,0]) translate([0,-wheel_diameter/2,-wheel_z]) {	
		Xcarriage(0);
	
		// show W Wheels
		for(p=wheelpos)
			translate([p[0], p[1], wheel_z]) w_wheel();
	
		// show extruder and hotend
		translate([0,wheel_separation/2,-thickness-5]) rotate([0,180,0]) extruder();
	}
}

module wheel_pillar(){
	ht= pillarht;
	translate([0,0,ht/2]) union() {
		cylinder(r1=pillardia/2, r2=16/2, h=ht, center=true);
		translate([0,0,ht/2-0.05]) cylinder(r=bearingID/2+columnfudge, h=bearingThickness+wheel_indent, $fn=64);
		translate([0,0,ht/2-0.05]) cylinder(r1=16/2, r2= bearingShaftCollar/2, h=wheel_indent);
	}
}

module base() {
	co= 50;
	r= pillardia/2;
	translate([0,0,-thickness+0.05]) linear_extrude(height= thickness) hull() {
		translate([-wheel_distance/2,0,0]) circle(r= r);
		translate([wheel_distance/2,0,0]) circle(r= r);
		translate([0,wheel_separation,0]) circle(r= r);
	}
}

// bracket for 2020 extrusion connection
module flange(width) {
//	difference() {
//		cube([5,20,width]);
//		translate([5/2-5/2-0.25, 20/2,width/2]) rotate([0,90,0]) hole(5, 5+0.5);
//	}
}

module Xcarriage(print=1) {
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

		// negative mount for extruder
		translate([0,wheel_separation/2,-thickness/2]) rotate([0,0,90]) extruder_mount();

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

		// grub screw at bottom for adjusting tightness of bottom wheel
		translate([0,wheelpos[2][1]+pillardia/2+2,-thickness/2]) rotate([90,0,0]) hole(3,pillardia/2);
		translate([0,wheelpos[2][1]+9/2+1.0,-thickness/2]) rotate([90,30,0]) nutTrap(ffd=5.46,height=5);
		#translate([0,wheelpos[2][1]+9/2-3/2,0]) cube([5.46,3,thickness], center=true);

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