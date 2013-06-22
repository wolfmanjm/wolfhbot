//
// an eccentric cam for adjusting the third wheel
//
use <myLibs.scad>

ht= 10;
difference() {
	cylinder(r=20/2, h=ht, $fn=64);
	translate([0,4,-1]) hole(8, ht+2);
}