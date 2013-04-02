use <misumi-parts-library.scad>;

thick= 5;

rotate([0,0,90]) corner_bracket();
% translate([-20,20,0]) corner();

module corner() {
	translate([10,0,10]) hfs2020(80);
	translate([0,-10,10]) rotate([0,0,90]) hfs2020(80);
	translate([10,-10,0]) rotate([90,0,0]) hfs2020(80);
}

module corner_bracket() {
	translate([-thick,-thick,0]) union() {
		cube([20+thick,thick,40+20-thick]);
		cube([thick,20+thick,40+20-thick]);
		translate([20,0,0]) cube([40,thick,20]);
		translate([0,20,0]) cube([thick,40,20]);
	}
}