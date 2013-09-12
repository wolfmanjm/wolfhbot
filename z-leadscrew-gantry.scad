// new 4 wheel x carriage for openrail and dual v wheels

use <misumi-parts-library.scad>
use <dual-v-wheel.scad>
use <myLibs.scad>
use <motor-mount.scad>
use <../MCAD/teardrop.scad>
use <leadscrew-bearing-block.scad>

mm= 25.4;
sides= 500;
columnfudge= 0.0; //fudge factor to get columns a bit bigger

zgantry_length= 500-60;

// render it for model
ZcarriageModel();
//Zcarriage();
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

wheel_penetration=2.0; // the amount the v wheel fits in the slot

bushing_ht= 0.25*mm;
bushing_dia= 8;
pillarht= bushing_ht-1; // 1; // the amount the bushing sticks out

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

extrusion_clearance= 1.0; // clearance between the side of the extrusion and the carriage
cutout= extrusion_height/2-wheel_z+extrusion_clearance; // the cutout for the extrusion
echo(str("cutout= ", cutout));

module ZcarriageModel() {
	cht= 200;
	translate([0, 0, cht]) Zcarriage_with_wheels();

	// cantilever
	translate([27,-42,cht]) hfs2020(200);

	// show what we are riding on
	translate([0, 0, 0]) rotate([90,0,0]) hfs2040(zgantry_length);

	// the motor and leadscrew
	translate([0, 0, 0]) rotate([0, 90, 180])  actuator();
}

module Zcarriage_with_wheels() {
	rotate([0,90,0]) translate([length/2+10,-wheel_separation/2,wheel_z]) {
		rotate([0, 180, 0]) Zcarriage();

		// show W Wheels
		for(p=wheelpos)
			translate(p + [0, 0, -wheel_z]) v_wheel();
	}
}

module wheel_pillar(){
	translate([0,0,-0.1]) cylinder(r2=8/2, r1= 18/2, h=pillarht+0.1);
}

module base() {
	r= rounding/2;
	difference() {
		translate([0,0,-thickness+0.05]) linear_extrude(height= thickness) hull() {
			translate(wheelpos[0]) circle(r= r);
			translate(wheelpos[1]+top_offset) circle(r= r);
			translate(wheelpos[2]) circle(r= r);
			translate(wheelpos[3]+top_offset) circle(r= r);
		}
		translate([0, wheel_separation/2, -thickness/2]) rotate([0, 0, 0])  cylinder(r=30, h=thickness+2, center=true);
	}
}

module Zcarriage() {
	difference() {
		union() {
			base();
			// flanges to attach leadnut to
			translate([0, -thickness/2, 40/2-0.1])  cube(size=[40, thickness, 40], center=true);
			translate([0, wheel_separation+thickness/2, 40/2-0.1])  cube(size=[40, thickness, 40], center=true);

		}

		// holes for flanges
		for(y= [1, wheel_separation+thickness/2+6]) for(p= [[10, y, 40-10], [-10, y, 40-10], [10, y, 40-30], [-10, y, 40-30]]) {
			translate(p) rotate([90, 0, 0]) hole(5, thickness+2);
		}

		for(p=wheelpos) {
			// bushing holes
			#translate(p + [0,0,-(bushing_ht-pillarht)]) hole(bushing_dia, bushing_ht);
			// M5 holes for wheels
			translate(p + [0,0,-50/2]) hole(5,50);
		}

		for(p= [wheelpos[2], wheelpos[3]]) {
			// slot for adjustable wheel
		   translate(p + [0,0,-50/2]) rotate([0,0,90]) slot(5,12,50);
			// slot for bushing
		   translate(p + [0,0,-(bushing_ht-pillarht)]) rotate([0,0,90]) slot(bushing_dia,15,bushing_ht);
		}

		// grub screw at bottom for adjusting tightness of bottom wheels
		for(p= [wheelpos[2], wheelpos[3]]) {
			#translate(p+ [0,rounding/2+2,-thickness/2]) rotate([90,0,0]) hole(3,rounding/2);
			translate(p+ [0,14/2+1.0,-thickness/2]) rotate([90,30,0]) nutTrap(ffd=5.46,height=5);
			translate(p+ [0,14/2,0]) cube([5.46,3,thickness], center=true);
		}

		// extrusion cutout
		translate([top_offset[0]/2,  wheel_separation/2, -cutout/2]) cube(size=[wheel_distance+wheel_diameter+top_offset[0], extrusion_width+4, cutout+0.2], center=true);

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

module leadscrew() {
	%rotate([0,-90,0]) cylinder(r=0.5*mm/2, h= 12*mm);
}

module actuator() {
	mt= 5; // thickness of motor plate
	rotate([0,0,0]) {
		translate([-60,0,10+motorMountHeight()/2+mt]) leadscrew();
		translate([-40,0,10]) rotate([90,0,90]) motorPlate(mt,mt);
		// bearing block
		translate([-70, 0, 10]) rotate([0, 0, -90]) pillow(motorMountHeight()/2+mt);
	}
	echo(str("Bearing block ht=", motorMountHeight()/2+mt));
}
