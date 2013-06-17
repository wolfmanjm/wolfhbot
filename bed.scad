use <misumi-parts-library.scad>;
use <z-carriage-3wheel.scad>
include <parameters.scad>

mm= 25.4;
bedw= 12*mm;
bedl= 12*mm;

len1= sqrt(sides*sides*2)-wheel_diameter+2;
len2= len1/2 - extrusion/2;

s45= sin(45);
c45= cos(45);

endx= len1/2*s45;
endy= len1/2*c45;

echo("main length= ", len1, ", side length= ", len2);

// show a tower
sep1= sides/2+extrusion/2;
if(true) {
	translate([sep1, sep1,-sides/2]) rotate([90,0,0]) hfs2020(sides);
	translate([-sep1,-sep1,-sides/2]) rotate([90,0,0]) hfs2020(sides);
}

bed_assembly(1, 76);

module bed_brace() {
	l= len1-40;
	rotate([0,0,45]) translate([0,-l/2,0]) hfs2020(l);
	//rotate([0,0,-45]) translate([0,extrusion/2,0]) hfs2020(len2);
	//rotate([0,0,135]) translate([0,extrusion/2,0]) hfs2020(len2);
}

module bed_bracket(ht) {
	translate([0,0,-ht/2]) rotate([0,0,45]) cube([10,10,ht], center= true);
}

module bed(ht=10) {
	for(p=[[0,0,-extrusion/2],[bedw/2,bedl/2,-extrusion/2],[-bedw/2,bedl/2,-extrusion/2],[bedw/2,-bedl/2,-extrusion/2],[-bedw/2,-bedl/2,-extrusion/2]]) translate(p) bed_bracket(ht);
	translate([0,0,-extrusion/2-ht]) cube([bedw, bedl, 3], center= true);
}

module carriage(w=0,m=0) {
    mirror([0,0,m])	translate([0,0,-15.5]) rotate([0,0,0]) z_carriage(w);	
}

module bed_assembly(w= 0, bed_ht=10) {
	rotate([180,0,0]) {
		translate([3.6,3.6,0]) bed_brace();
		//bed(bed_ht);

		//translate([endx,endy,0]) rotate([0,90,90+45]) carriage(w);
		//translate([-endx, -endy,0]) rotate([0,90,-45]) carriage(w);
		translate([-endx, endy,0]) rotate([0,90,180+45]) carriage(w, 0);
		translate([endx, -endy,0]) rotate([0,90,45]) carriage(w, 1);
	}
	
}