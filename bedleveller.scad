use <../MCAD/regular_shapes.scad>
use <../MCAD/boxes.scad>
include <myLibs.scad>

pillar_h= 10;
pillar_dia=14;
perimeter_h= 15;
perimeter_side= 250-pillar_dia/2;
supportw= 155;
nut_thick=3.5;
bolt_shaft= 4.1;
head_h= 2.7;
nut_ffd=8.65;

module body(side=10, thickness=5, height=10) {
	r= (side/2)/cos(30);
	xo= cos(30)*r;
	yo= sin(30)*r;
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
		translate([-supportw/2, 0, 0])  cube(size=[supportw, thickness, height], center=false);
		translate([-thickness/2, 0, 0])  cube(size=[thickness, 130, height], center=false);
		translate([0, 0, height/2]) rotate([0, 0, -30]) translate([130/2, 0, 0])   cube(size=[135, thickness, height], center=true);
		translate([0, 0, height/2]) rotate([0, 0, -150]) translate([130/2, 0, 0])   cube(size=[135, thickness, height], center=true);
	}
}

module pillars(dia=10, height=10) {
	sl= dia*1.5;
	difference() {
		rotate([0,0,90]) slot(d= dia, l= sl, ht= height, clearance=0.1);
		hole(diam= bolt_shaft, height=20);
		translate([0,0,height-nut_thick-head_h]) nutTrap(ffd=nut_ffd, height=nut_thick+head_h+0.1);
	}
}

module flange(angle) {
	difference() {
		translate([0, 0, 1])   roundedBox([30, 40, 5], 5, true);
		translate([0,-6, -3]) rotate([0,0,angle]) slot(d= 7, l= 25, ht= 7);
	}
}

union() {
	body(side=perimeter_side, height=perimeter_h);

	//bolt down flanges
	translate([90,7,3/2]) rotate([0,0,30]) flange(-120);
	translate([-90,7,3/2]) rotate([0,0,-30]) flange(120);
}
