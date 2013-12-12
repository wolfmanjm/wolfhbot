use <myLibs.scad>
use <leadscrewnut_0.5in-10tpi.scad>

w= 60.0;
h= 60;
l= 40.00;
thick= 8;

hole_sep= 20;
nut_radius=15;
nut_ht= 20;
holder_thick= nut_ht+4;
nhw= nut_radius*2 +5;
mm= 25.4;

module nut_holder() {
	z= (l-holder_thick)/2;
	r= (nut_radius * cos(180 / 6))*2 + 0.2;
	difference() {
		translate([0, 0, -z])  cube(size=[w, nhw, holder_thick], center=true);
		translate([0, 0, -1]) cylinder(r=0.5*mm/2+4, h=l, center=true);
		translate([0, 0, -z]) rotate([0, 0, 30]) cylinder(h=nut_ht,r=nut_radius+0.1, center= true, $fn=6);
		// cut out to allow nut to be inserted
		translate([0, -nut_radius, -z]) cube(size=[r, r, nut_ht+0.1], center=true);
	}
}

module flange() {
	difference() {
		translate([0, 0, 0])  cube(size=[thick, h, l], center=true);
		translate([-5, 5, -10]) rotate([90, 0, 90])  slot(5, h-25, 10);
		translate([-5, 5, 10]) rotate([90, 0, 90])  slot(5, h-25, 10);
	}
}

module antibacklash_holder() {
	clearance= 0.2;
	t= 2.3+clearance;
	ht= 50;
	rotate([0, 0, 30]) difference() {
		cylinder(h=50,r=nut_radius+t, $fn=6);
		translate([0, 0, -1])  cylinder(h=ht+2,r=nut_radius+clearance, $fn=6);
	}
}

module leadnut_connector() {
	lsht= l/2 + holder_thick/2;
	py= (h - nhw) /2;
	rotate([0, 0, 0])
	union() {
		nut_holder();
		translate([0, 0, 2])  antibacklash_holder();
		translate([w/2-thick/2, py, 0])  flange();
		translate([-w/2+thick/2, py, 0])  flange();
		//translate([0, 0, -l/2])  leadscrew_nut(lsht);
	}
}

leadnut_connector();
// union() {
// 	antibacklash_holder();
// 	difference() {
// 		cylinder(r=nut_radius+5, h=0.9, center=true);
// 		translate([0, 0, -1]) cylinder(r=0.5*mm/2+4, h=l, center=true);
// 	}
// }
