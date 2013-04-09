//
// an eccentric cam for adjusting the third wheel
//
use <myLibs.scad>

union() {
	cylinder(r=8, h=10, $fn=64);
	translate([0,2,10-0.1]) cylinder(r=8/2, h=7, $fn=64);
}