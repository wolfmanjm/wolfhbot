use <misumi-parts-library.scad>;
use <myLibs.scad>

thick= 4;
h= 20+thick/2;

// the dimensions of the extrusion
extrusion_width= 20;
extrusion_height= 20;

bearingThickness= 7;
bearingOD= 22;
bearingID= 8;
bearingShaftCollar= 11.5;
wheel_width= bearingThickness;
wheel_indent= 1;
pillarht= 0;
pillardia= 20;


rotate([180,0,0]) 
idler_mount();
% translate([-10,10,-20]) rotate([0,0,-90]) corner();

module corner() {
	translate([10,0,10]) hfs2020(80);
}

module base_bracket() {
  	difference() {
		translate([0,-thick,0]) cube([20,thick,h]);
	   translate([10,-thick-1,h/2]) rotate([0,90,90]) hole(5, thick+2);
       
	}
}

module wheel_pillar(){
        ht= pillarht;
        translate([0,0,pillarht/2-0.1]) union() {
                cylinder(r1=pillardia/2, r2=16/2, h=ht, center=true);
                translate([0,0,ht/2-0.05]) cylinder(r=bearingID/2, h=bearingThickness+wheel_indent, $fn=64);
                translate([0,0,ht/2-0.05]) cylinder(r1=16/2, r2= bearingShaftCollar/2, h=wheel_indent);
        }
}

module idler_mount() {
	difference() {
		union() {
			translate([-10,-10,-thick/2]) base_bracket();
			translate([-10.1,-10.1,-thick/2]) cube([20.1,20.1,thick/2]);
			#translate([0,0,-thick/2]) rotate([180,0,0]) wheel_pillar();
		}
		#translate([0,0,-25]) hole(3, 50);
	}
}