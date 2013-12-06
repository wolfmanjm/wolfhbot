use <myLibs.scad>

w= 60.0;
h= 60;
l= 40.00;
thick= 8;
holder_thick= 10;

hole_sep= 20;
nut_radius=30.3/2 + 2;

nhw= nut_radius*2+10;
mm= 25.4;

module nut_holder() {
	difference() {
		translate([0, 0, 0])  cube(size=[w, nhw, holder_thick], center=true);
		cylinder(h=20,r=nut_radius, $fn=6);
		translate([0, 0, -1])  cylinder(r=0.5*mm/2+4, h=10, center=true);
	}
}

module flange() {
	difference() {
		translate([0, 0, 0])  cube(size=[thick, h, l], center=true);
		translate([-5, 5, -10]) rotate([90, 0, 90])  slot(5, h-25, 10);
		translate([-5, 5, 10]) rotate([90, 0, 90])  slot(5, h-25, 10);
	}
}

py= (h - nhw) /2;
rotate([90, 0, 0])
union() {
	nut_holder();
	translate([w/2-thick/2, py, 0])  flange();
	translate([-w/2+thick/2, py, 0])  flange();
}
