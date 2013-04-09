// a wheel that rides in t slot, based on steve grabers W wheel
use <myLibs.scad>

od= 31.2;
id= 28;
innert= 5;
outert=8;

wheel_id= 22.0; // the diameter of the outside hole
wheel_d= 2.47; // the depth from the outside of the wheel to the bearing
wheel_groove_d= 2.5; // the depth of the groove on the outside of the wheel
wheel_groove_w= 3; // the width of the groove on the outside of the wheel

bearingThickness= 7;
bearingOD= 22;
bearingID= 8;

function w_wheel_dia()= od;
function w_wheel_width()= (outert-innert*2)+innert;
function w_wheel_id()= wheel_id;
function w_wheel_indent()= wheel_d-0.1;

module W_wheel() {
	rth= outert-innert;
	union() {
		cylinder(r=od/2, h= innert, center=true, $fn=64);
		translate([0,0,innert/2-0.05]) cylinder(r1=od/2,r2=id/2, h=rth, $fn=64);
		translate([0,0,-innert/2-rth+0.05]) cylinder(r2=od/2,r1=id/2, h=rth, $fn=64);
	}
}

module w_wheel() {
	union() {
		difference() {
			W_wheel();
			translate([0,0,-40/2]) hole(bearingOD, 40, -0.1); // make it very tight fit
		}
		// rim
		//#cylinder(r=bearingOD/2+1, h= (w_wheel_width()-bearingThickness)/2);
		
	}
}

module w_wheel_vertical() {
	rotate([0,90,0]) w_wheel();
}

w_wheel();
//w_wheel_vertical();
//W_wheel();


