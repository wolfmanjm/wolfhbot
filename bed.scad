use <misumi-parts-library.scad>;
use <z-carriage.scad>
include <parameters.scad>

mm= 25.4;
bedw= 350;
bedl= 350;

len1= sqrt(sides*sides*2)-wheel_diameter+2;
len2= len1/2 - extrusion/2;

s45= sin(45);
c45= cos(45);

endx= len1/2*s45;
endy= len1/2*c45;

echo("main length= ", len1, ", side length= ", len2);

// show a tower
sep1= sides/2+extrusion/2;
if(false) {
	translate([sep1, sep1,-sides/2]) rotate([90,0,0]) hfs2020(sides);
	translate([-sep1,-sep1,-sides/2]) rotate([90,0,0]) hfs2020(sides);
}

bed_assembly(0);

module bed_brace() {
	rotate([0,0,45]) translate([0,-len1/2,0]) hfs2020(len1);
	rotate([0,0,-45]) translate([0,extrusion/2,0]) hfs2020(len2);
	rotate([0,0,135]) translate([0,extrusion/2,0]) hfs2020(len2);
}

module bed() {
	translate([0,0,extrusion/2 + 3/2]) cube([bedw, bedl, 3], center= true);
}

module carriage(w=0) {
	translate([0,0,-10]) rotate([0,0,0]) z_carriage(w);	
}

module bed_assembly(w= 0) {
	bed_brace();
	bed();

	translate([endx,endy,0]) rotate([0,90,90+45]) carriage(w);
	translate([-endx, -endy,0]) rotate([0,90,-45]) carriage(w);
	translate([-endx, endy,0]) rotate([0,90,180+45]) carriage(w);
	translate([endx, -endy,0]) rotate([0,90,45]) carriage(w);
}