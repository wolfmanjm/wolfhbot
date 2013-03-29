use <misumi-parts-library.scad>;

extrusion= 20; // extrusion 2020
sides= 500;

bed_assembly();

module bed_brace() {
	len1= sqrt(sides*sides*2);
	len2= len1/2 - extrusion/2;

	echo("main length= ", len1, ", side length= ", len2);
	rotate([0,0,45]) translate([0,-len1/2,0]) hfs2020(len1);
	rotate([0,0,-45]) translate([0,extrusion/2,0]) hfs2020(len2);
	rotate([0,0,135]) translate([0,extrusion/2,0]) hfs2020(len2);
}

module bed() {
	translate([0,0,extrusion/2 + 3/2]) cube([400, 400, 3], center= true);
}

module bed_assembly() {
	bed_brace();
	bed();
}