use <misumi-parts-library.scad>;
use <../MCAD/stepper.scad>
use <../MCAD/motors.scad>
use <../MCAD/triangles.scad>
use <motor-mount.scad>
use <myLibs.scad>

thick= 5.6;
w= 54;
h= 55;

%translate([-20,20,0]) corner();
motor_bracket(1);

module motor_bracket(r=0) {
	mirror([0,r,0]) difference() { 
		union() {
			rotate([0,0,90]) corner_bracket();
			translate([thick,50/2+10,0]) rotate([0,0,-90])  motorPlate(thick, thick);
		}
		// mounting holes
		#translate([-1,10,h+3]) rotate([0,90,0]) hole(5, thick+2);
		translate([-1,20+25,20]) rotate([0,90,0]) slot(d=5, l=30,ht=thick+2);
		translate([-10,-thick-1,h]) rotate([0,90,90]) hole(5, thick+2);
		translate([-10,-thick-1,h-h/3]) rotate([0,90,90]) hole(5, thick+2);
		translate([-10,-thick-1,h/4]) rotate([0,90,90]) hole(5, thick+2);	}

}

module motorAttachment(thickness=4) {
        translate([0,h,thickness]) rotate([180,0,0]) difference() {
                cube([w,h,thickness]);
                translate([w/2,h/2,-1]) linear_extrude(height=thickness+2) stepper_motor_mount(17,8,true,0.1);
        }
}

module attachmentPlate(thickness=4) {
	cube([w,40,thickness]);
}

module buttress(thickness=4) {
        triangle(50, 40, thickness);
}

module motorPlate(thickness=4, buttressThickness=4) {
        union() {
                motorAttachment(thickness);
                translate([0,0.1,0]) rotate([90,0,0]) attachmentPlate(thickness);
                translate([buttressThickness,-0.1,0]) rotate([0,-90,0]) buttress(buttressThickness);
                translate([w,-0.1,0]) rotate([0,-90,0]) buttress(buttressThickness);
        }
}


module corner() {
	translate([10,0,10]) hfs2020(80);
	translate([0,-10,10]) rotate([0,0,90]) hfs2020(80);
	translate([10,-10,0]) rotate([90,0,0]) hfs2020(80);
}

module corner_bracket() {
	translate([-thick,-thick,0]) union() {
		cube([20+thick,thick,h+20-thick]);
		cube([thick,20+thick,h+20-thick]);
		translate([20,0,0]) cube([40,thick,40]);
	}
}

//module smount(w=50,l=50) {
//	translate([0,0,thick/2]) difference() {
//		cube([w,l,thick], center=true); 
//		translate([0,0,-thick/2-1]) linear_extrude(height= thick+2) stepper_motor_mount(nema_standard=17,slide_distance=5, mochup=false, tolerance=0.1);
//	}
//}
