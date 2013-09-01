// new 4 wheel x carriage for openrail and dual v wheels

use <misumi-parts-library.scad>
use <dual-v-wheel.scad>
use <myLibs.scad>
use <motor-mount.scad>
use <tensioner-gt2-F695zz.scad>

// gt2 pulley
gt2_length= 17.51;
gt2_inner_length= 7.42;
gt2_outer_dia= 17.85;
gt2_inner_dia= 12.25;
gt2_min_shaft_len= 9.14;
gt2_max_shaft_len= 13.64;

mm= 25.4;
sides= 500;
columnfudge= 0.0; //fudge factor to get columns a bit bigger

zgantry_length= 500-60;

// render it for model
ZcarriageModel();
//Zcarriage(1);
//Zcarriage_with_wheels();

//actuator();

// the dimensions of the extrusion to run on
extrusion= 20;
extrusion_width= 40; // the side that the wheels run on
extrusion_height= 20;
function zgantry_width() = extrusion_width;

// the thickness of the base
thickness = 10;

wheel_diameter = v_wheel_dia();
wheel_width= v_wheel_width();
wheel_id= v_wheel_id();
wheel_indent= v_wheel_indent();

wheel_penetration=1.77; // the amount the v wheel fits in the slot

pillarht= 1; // the amount the bushing sticks out
bushing_ht= 0.25*mm;
bushing_dia= 8;

rounding= 22;

// total length (height) of carriage
length= 100;
function get_zcarriage_height()= length;

top= 20; // room at top for extrusion cantilever

clearance= 0; // increase for more clearance, decrease for tighter fit
wheel_separation= extrusion_width+wheel_diameter+clearance-wheel_penetration*2; // separation of wheels for given extrusion

wheel_distance= length-top; // wheel_separation;
echo("wheel distance= ", wheel_distance);

wheel_z= pillarht+wheel_width/2;
function get_wheel_z()= wheel_z;

wheelpos= [ [-wheel_distance/2, 0, 0], [wheel_distance/2, 0, 0], [-wheel_distance/2, wheel_separation, 0], [wheel_distance/2, wheel_separation, 0]];

function get_wheelpos(n) = [wheelpos[n][0], -wheel_diameter/2];

// how much higher top is to accomodate cantilever
top_offset= [top,0,0];

extrusion_clearance= 0.5; // clearance between the side of the extrusion and the carriage
cutout= extrusion_height/2-wheel_z+extrusion_clearance; // the cutout for the extrusion

module ZcarriageModel() {
	cht= 200;
	translate([0, 0, cht]) Zcarriage_with_wheels();

	// cantilever
	translate([27,-42,cht]) hfs2020(200);

	// show what we are riding on
	translate([0, 0, 0]) rotate([90,0,0]) hfs2040(zgantry_length);

	// the motor
	translate([32+30, 0, 0]) rotate([0, 0, 0])  actuator();

	//idler
	translate([10, 10, zgantry_length-20]) rotate([0, 0, 90]) tensioner_695();

}

module Zcarriage_with_wheels() {
	rotate([0,90,0]) translate([length/2+10,-wheel_separation/2,wheel_z]) {
		Zcarriage(0);

		// show W Wheels
		for(p=wheelpos)
			translate(p + [0, 0, -wheel_z]) v_wheel();
	}
}

module wheel_pillar(){
	translate([0,0,-0.1]) cylinder(r2=8/2, r1= 18/2, h=pillarht+0.1);
}

module base() {
	co= 50;
	r= rounding/2;
	translate([0,0,-thickness+0.05]) linear_extrude(height= thickness) hull() {
		translate(wheelpos[0]) circle(r= r);
		translate(wheelpos[1]+top_offset) circle(r= r);
		translate(wheelpos[2]) circle(r= r);
		translate(wheelpos[3]+top_offset) circle(r= r);
	}
}

module Zcarriage(print=1) {
	rotate([0,180,0]) {
		if(print == 1) {
			union() {
				Zcarriage_main(1);
			}
		}else{
			Zcarriage_main(0);
		}
	}
}

module Zcarriage_main(print=1) {
	difference() {
		base();

		for(p=wheelpos) {
			// bushing holes
			#translate(p + [0,0,-(bushing_ht-pillarht)]) hole(bushing_dia, bushing_ht);
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
			#translate(p+ [0,rounding/2+2,-thickness/2]) rotate([90,0,0]) hole(3,rounding/2);
			translate(p+ [0,14/2+1.0,-thickness/2]) rotate([90,30,0]) nutTrap(ffd=5.46,height=5);
			translate(p+ [0,14/2,0]) cube([5.46,3,thickness], center=true);
		}

		// extrusion cutout
		translate([top_offset[0]/2,  wheel_separation/2, -cutout/2]) cube(size=[wheel_distance+wheel_diameter+top_offset[0], extrusion_width+1, cutout+0.2], center=true);

		// bolts for cantilever
		#translate([length/2+10, 0, -30/2]) hole(5, 25);
		#translate([length/2+10, wheel_separation, -30/2]) hole(5, 25);
	}
}

module z_gantry() {
	// Z gantry, experimental cantilever
	cantilever1_length= tan(45)*(sides/2-(zgantry_pos+20))-30;
	echo(str("cantilever1_length=", cantilever1_length));

	translate([sides/2-20, zgantry_pos, 30])  rotate([90,0,90]) hfs2040(zgantry_length);
	translate([sides/2, zgantry_pos+20, raised+10+bedh])  rotate([0,0,90]) hfs2020(cantilever1_length);
}

module actuator() {
	rotate([0,0,0]) {
		//translate([-60,0,33]) leadscrew();
		translate([0,-28,0]) rotate([90,0,90]) motorPlate();
		translate([-10, 0, 22]) rotate([0, -90, 0])  color("red") gt2_pulley();
	}
}

module gt2_pulley() {
	cylinder(r=gt2_inner_dia/2, h=gt2_length, center=true);
	translate([0, 0, gt2_length/2]) cylinder(r=gt2_outer_dia, h=1, center=true);
	translate([0, 0, gt2_length/2-gt2_inner_length]) cylinder(r=gt2_outer_dia, h=1, center=true);
}
