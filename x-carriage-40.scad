// new 4 wheel x carriage for openrail and dual v wheels
// Add fan for cooling hot end

use <misumi-parts-library.scad>
use <dual-v-wheel.scad>
use <myLibs.scad>
use <XGantry.scad>
use <squirrel-fan.scad>

mm= 25.4;

columnfudge= 0.0; //fudge factor to get columns a bit bigger

//extruder_mount();

// display it for print == 1
//Xcarriage(1);

// render it for model
XcarriageModel();

//extruder_shelf();

//Xcarriage_with_wheels();

// the dimensions of the extrusion to run on
extrusion= 20;
extrusion_width= get_xgantry_width(); // the side that the wheels run on
extrusion_height= 20;

line_ht= 3.6; // height of line above extrusion

// the thickness of the base
thickness = 10;

mountingplate_w= 25.6+5;
mountingplate_l= 70+2;
mountingplate_h= 5;

wheel_diameter = v_wheel_dia();
wheel_width= v_wheel_width();
wheel_id= v_wheel_id();
wheel_indent= v_wheel_indent();

bearingFlangeThickness= 1;
bearingThickness= 8- bearingFlangeThickness*2;
bearingOD= 13;
bearingID= 5;
bearingFlangeDia= 15;
belt_thick= 2; // 1.45
belt_width= 6;

wheel_penetration=0; // the amount the w wheel fits in the slot
wheel_clearance= 0; // clearance between the side of the extrusion and the carriage

pillarht= 1; // the amount the bushing sticks out
bushing_ht= 0.25*mm;
bushing_dia= 8;

rounding= 22;

clearance= 0; // increase for more clearance, decrease for tighter fit
wheel_separation= extrusion_width+wheel_diameter+clearance-wheel_penetration*2; // separation of two wheels and bottom wheel for given extrusion

// calculate separation of top two wheels to make an equilateral triangle
//wheel_distance= (wheel_separation/tan(60))*2; // distance from wheel center to center of top two wheels
wheel_distance= 80;
echo("wheel distance= ", wheel_distance);

wheel_z= pillarht+wheel_width/2;
function get_wheel_z()= wheel_z;

idler1ht= -wheel_z+1.5 + 2;
idler2ht= idler1ht+bearingThickness+bearingFlangeThickness*2+1;

wheelpos= [ [-wheel_distance/2, 0, 0], [wheel_distance/2, 0, 0], [-wheel_distance/2, wheel_separation, 0], [wheel_distance/2, wheel_separation, 0]];

function get_wheelpos(n) = [wheelpos[n][0], -wheel_diameter/2];

module XcarriageModel() {
	Xcarriage(0);

	// show V Wheels
	for(p= wheelpos) {
		translate(p + [0, 0, -wheel_z]) v_wheel();
	}

	// show what we are riding on
	translate([0, get_xgantry_width()/2+wheel_diameter/2, -wheel_z-20]) {
		translate([0,0,-11.5]) Xgantry();
		// bolt head
		color("blue") translate([0,-get_xgantry_width()/2+10,22]) cylinder(r=10/2, h=2);
	}

	// extruder mount attachment
	translate([wheel_distance/2, -wheel_diameter, -thickness]) rotate([0, 0, 90])  hfs2020(wheel_distance);

	// extruder mount
	translate([0, -55, -20])  extruder_shelf();

	// show extruder and hotend
	translate([0,-65,-20]) rotate([0,0,0]) extruder();

	// Idler bearings
	translate([get_xgantry_length()/2-10, get_xgantry_width()/2+wheel_diameter/2-10, idler1ht]) idler();
	translate([get_xgantry_length()/2-10, get_xgantry_width()/2+wheel_diameter/2+10, idler2ht]) idler();

	// belt
	color("white") translate([0, get_xgantry_width()/2+wheel_diameter/2-10+bearingOD/2, idler1ht]) cube(size=[300, belt_thick, belt_width]);
	color("white") translate([0, get_xgantry_width()/2+wheel_diameter/2+10-bearingOD/2- belt_thick, idler2ht]) cube(size=[300, belt_thick, belt_width]);

}

module idler() {
	color("green") difference() {
		union() {
			cylinder(r=bearingOD/2, h=bearingThickness);
			translate([0, 0, -bearingFlangeThickness]) cylinder(r=bearingFlangeDia/2, h=bearingFlangeThickness);
			translate([0, 0, bearingThickness]) cylinder(r=bearingFlangeDia/2, h=bearingFlangeThickness);
		}
		translate([0, 0, -2])  cylinder(r=bearingID/2, h=bearingThickness+4);
	}
}

module Xcarriage_with_wheels() {
	translate([0,-wheel_diameter/2,wheel_z]) {
		Xcarriage(0);

		// show W Wheels
		for(p=wheelpos)
			translate(p + [0, 0, -wheel_z]) v_wheel();

		// show extruder and hotend
		translate([0,wheel_separation/2,thickness/2]) extruder();
	}
}

module wheel_pillar(){
	translate([0,0,-0.1]) cylinder(r2=8/2, r1= 18/2, h=pillarht+0.1);
}

module base() {
	co= 50;
	r= rounding/2;
	translate([0,0,-thickness+0.05]) linear_extrude(height= thickness) hull() {
		for(p= [wheelpos[0]-[0,wheel_diameter,0], wheelpos[1]-[0,wheel_diameter,0], wheelpos[2], wheelpos[3]]) {
			translate(p) circle(r= r);
		}
	}
}

module Xcarriage(print=1) {
	rotate([0,180,0]) {
		if(print == 1) {
			union() {
				Xcarriage_main(1);
				// bridging support layer
				//translate([0,wheel_separation/2,-5]) rotate([0,0,90]) mountingplate(4, 1);
			}
		}else{
			Xcarriage_main(0);
		}
	}
}

module Xcarriage_main(print=1) {
	belt_d= 5;
	belt_y1= get_xgantry_width()/2+wheel_diameter/2+10 - bearingOD/2 + belt_d/2;
	belt_y2= get_xgantry_width()/2+wheel_diameter/2-10 + bearingOD/2 - belt_d/2;

	difference() {
		base();

		for(p=wheelpos) {
			// bushing holes
			translate(p + [0,0,-(bushing_ht-pillarht)]) hole(bushing_dia, bushing_ht);
			// M5 holes for wheels
			translate(p + [0,0,-50/2]) hole(5,50);
		}

		if(print == 1) {
			for(p= [wheelpos[2], wheelpos[3]]) {
				// slot for adjustable wheel
			   translate(p + [0,0,-50/2]) rotate([0,0,90]) slot(5,12,50);
				// slot for bushing
			   translate(p + [0,0,-(bushing_ht-pillarht)]) rotate([0,0,90]) slot(bushing_dia,15,bushing_ht);
			}
		}

		// grub screw at bottom for adjusting tightness of bottom wheels
		for(p= [wheelpos[2], wheelpos[3]]) {
			translate(p+ [0,rounding/2+2,-thickness/2+3/2]) rotate([90,0,0]) hole(3,rounding/2);
			translate(p+ [0,14/2+1.0,-thickness/2+3/2]) rotate([90,30,0]) nutTrap(ffd=5.46,height=5);
			translate(p+ [0,14/2,0]) cube([5.46,3,thickness], center=true);
		}

		// termination for belts
		for(y= [belt_y1, belt_y2]) for(m= [0,1]){
			mirror([m,0,0]) {
				#translate([40,y,-20]) hole(5, 30);
			}
		}

		// mount for cable holder
		translate([0, wheel_separation/2, -5])  cylinder(r=0.25/2*mm, h=20, center=true);
	}
}

module extruder_shelf() {
	// base of extruder mount
	w= 30;
	l= 30;
	co= 50;
	thickness= 5;
	r= rounding/2;
	difference() {
		translate([0, 0, -thickness])  linear_extrude(height= thickness) hull() {
			for(p= [[w, l, 0], [-w, l, 0], [-w, -l, 0], [w, -l, 0]]) {
				translate(p) circle(r= r);
			}
		}

		// negative mount for extruder
		translate([0,-10,-thickness/2]) rotate([0,0,90]) extruder_mount(w);

		// mounting holes
		#translate([w, l, -10]) rotate([0, 0, 0]) hole(5, 20);
		#translate([-w, l, -10]) rotate([0, 0, 0]) hole(5, 20);

		// fan mount hole
		#translate([-w+2, 15, -10]) rotate([0, 0, 90])  slot(4, 20, 20);

	}
	// squirrel fan
	%translate([0,30,-15]) rotate([0, 0, -115])  fan();
}

// extruder and head
module extruder() {
	//translate([0,0,0]) rotate([0,0,90]) mountingplate();
	translate([22,-42,0]) rotate([0,0,0]) import("greg-wades-all.stl");
	translate([0,0,9.2]) rotate([180,0,0]) import("JHead_hotend_blank/jhead.stl");
}

module extruder_mount(w) {
	holes = 4;
	l= 60;
	height = thickness+2;

	translate([0,0,1]) difference() {
		translate([-5, 0, 0])  cube([w+5, l, height], center=true);
		difference() {
			cube([w, l, height], center=true);
			cylinder(r=20, h=height+1, center=true, $fn=6);
		    for (a = [-25,25]) translate([0, a, -height]) rotate([0, 0, 90])  slot(holes, 8, 2*height);
		}
	}
}
