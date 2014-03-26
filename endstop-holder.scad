// two parts one to hold the Hall-o endstopthe other to hold the magnet

use <myLibs.scad>
use <bend.scad>


mag_dia= 3;

magnet_holder_X();
//rotate([90, 0, 0])  endstop_holder();


module magnet_holder_X() {
	l= 35+15;
	w= 20;
	t= 3;
	cutout= 1/4*25.4;
	difference() {
		union() {
	 		translate([-w/2, -l/2, 0])  cube(size=[w, l, t]);
	 		translate([0, -l/2-10/2, t/2]) cube(size=[w, 10, cutout+5], center=true);
	 	}
	 	#translate([0, l/2-3, 0.5])  rotate([0, 0, 0]) hole(mag_dia, 5);
	 	translate([0, -l/2-6, t/2]) cube(size=[w+2, 9, cutout+0.1], center=true);
	 }
}

module magnet_holder_Z() {
	l= 20;
	w= 20;
	union() {
	 	difference() {
	 		translate([0, 0, 0])  cube(size=[w, l, 5], center=true);
	 		#translate([0,0,-5]) rotate([0, 0, 90]) slot(d= 4, l= l-5, ht= 10);
	 	}
 		difference() {
	 		translate([0, l/2, 10/2 - 5/2])  cube(size=[w, 5, 10], center=true);
	 		#translate([0, 0, 5])  rotate([0, 90, 90]) hole(mag_dia, 20);
	 	}
	 }
}

module magnet_holder_Y() {
	ml1= 30;
	ml2= 10;
	mw= 5;
	mh= 15;
	fml= 25;
	union() {
	 	translate([0, -10/2, 0])  rotate([0, 0, -45])  difference() {
	 		translate([0, -10, 0])  bend(d1=ml1,d2=ml2,r=10,w=mw,a=90+45,h=mh);
	 		//#translate([fml/2, 10-1, mh/2]) rotate([90, 0, 0]) slot(d= 4, l= fml-10, ht= 10);
	 		#translate([2, 9, 5]) rotate([90, 0, 0]) cube([fml, 4, 10]);// slot(d= 4, l= fml-10, ht= 10);
	 	}
	 	translate([-ml2-2, 9+mw/2, 0]) {
	 		difference() {
	 			rotate([0, 0, 180-45]) bend(d1=15,d2=10,r=10,w=mw,a=90+45,h=mh);
	 			translate([-15, 0, mh/2])  rotate([90, 90, -45]) translate([0, 0, -10])  hole(mag_dia, 20);
	 		}
	 	}
	 }
	 echo(str("length= ", fml+30+(cos(45)*ml2)));
	 echo(str("drop= ", (sin(45)*(ml2+10))));
	 %rotate([0, 0, -45])  translate([-25, 0, 0])  cube(size=[30, 10, 10]);
	 %rotate([0, 0, 45])  translate([-10, 20, 0])  cube(size=[10, 10, 10]);
}
// hallo-holder, holds hallo horizontally witj bolt down to top of extrusion
esw= 13.64;
esl= 20;
est= 4;
esh= 10;
esbt= 1.55; // board thickness

module endstop_holder() {
	difference() {
		union() {
			cube(size=[esw+est*2, esl, esh], center=true);
			// flange
			translate([0, 0, -esh/2+2])  cube(size=[40, esl, 4], center=true);
		}
		translate([0, 0, 0])  cube(size=[esw, esl+1, 6], center=true);
		translate([0, 0, -2])  cube(size=[14.72, esl+1, esbt], center=true);
		#translate([-40/2+4, 0, -6])  hole(4, 6);
		#translate([40/2-4, 0, -6])  hole(4, 6);
	}
}
