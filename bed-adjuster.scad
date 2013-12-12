// spacer that allows be height adjustment
// usually made from aluminum and tapped to M4

include <myLibs.scad>

mm= 25.4;
h1= 15;
h2= 8;
h3= 2;
radius= 0.5*mm/2;
ir= 6/2;

difference() {
	union() {
		cylinder(r=radius, h=h1, center=false);
		translate([0, 0, h1]) cylinder(r=ir, h=h2, center=false);
		translate([0, 0, h1+h2]) cylinder(r=radius, h=h3, center=false);
	}
	translate([0, 0, -1])  hole(4, 30);
	nutTrap(6);
}
