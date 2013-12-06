use <../MCAD/regular_shapes.scad>
use <../MCAD/boxes.scad>
include <myLibs.scad>

pillar_h= 15;
pillar_dia=20;
perimeter_h= 15;
perimeter_side= 200-pillar_dia/2;

nut_thick=5.6/2;
bolt_shaft= 4.1;
head_h= 0;
nut_ffd=12.82;

bed_leveller();

module body(side=10, thickness=5, height=10) {
	r= (side/2)/cos(30);
	xo= cos(30)*r;
	yo= sin(30)*r;
	echo(str("xo= ", xo));
	echo(str("yo= ", yo));
	union() {
		difference() {
			triangle_tube(height= height, radius=r, wall=thickness*2);
			//cutoff apexes
			translate([0, r, 0]) cylinder(r=nut_ffd, h=height+1);
			translate([xo, -yo, 0]) cylinder(r=nut_ffd, h=height+1);
			translate([-xo, -yo, 0]) cylinder(r=nut_ffd, h=height+1);
		}
		translate([0, r, 0]) pillars(dia=pillar_dia, height=pillar_h);
		translate([xo, -yo, 0]) rotate([0,0,-120]) pillars(dia=pillar_dia, height=pillar_h);
		translate([-xo, -yo, 0]) rotate([0,0,120]) pillars(dia=pillar_dia, height=pillar_h);
		// middle supports
		translate([0, 0, height/2]) rotate([0, 0, 30]) translate([yo/2, 0, 0]) cube(size=[yo, thickness, height], center=true);
		translate([0, 0, height/2]) rotate([0, 0, 150]) translate([yo/2, 0, 0]) cube(size=[yo, thickness, height], center=true);
		translate([-thickness/2, 0, 0])  cube(size=[thickness, xo, height], center=false);
		translate([0, 0, height/2]) rotate([0, 0, -30]) translate([xo/2, 0, 0])  cube(size=[xo, thickness, height], center=true);
		translate([0, 0, height/2]) rotate([0, 0, -150]) translate([xo/2, 0, 0])  cube(size=[xo, thickness, height], center=true);
		translate([0, 0, 0]) cylinder(r=10, h=height, center=false);

		//bolt down flanges
		translate([yo+20,0,0]) rotate([0,0,30]) flange(-120);
		translate([0,-yo-10,0]) rotate([0,0,90]) flange(90);
		translate([0,xo+40,0]) rotate([0,0,90]) flange(90);
	}
}

module pillars(dia=10, height=10) {
	sl= dia*1.5;
	difference() {
		rotate([0,0,90]) slot(d= dia, l= sl, ht= height, clearance=0.1);
		//#hole(diam= bolt_shaft, height=20);
		translate([0,0,height-nut_thick]) nutTrap(ffd=nut_ffd, height=nut_thick+0.1);
	}
}

module flange(angle) {
	difference() {
		translate([0, 0, 5/2]) roundedBox([30, 40, 5], 5, true);
		translate([0,0, -1]) rotate([0,0,angle]) slot(d= 5, l= 25, ht= 7);
	}
}

module bed_leveller() {
	difference() {
		body(side=perimeter_side, height=perimeter_h);
		translate([0, 0, -1])  hole(diam= 5, height= perimeter_h+2);
	}
}
