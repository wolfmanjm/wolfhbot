use <myLibs.scad>
use <../MCAD/bearing.scad>
use <motor-mount.scad>

mm=25.4;

bracket_length= 250;
hole_size= 5;
roddia= 0.25*mm;
capthick= 4;

//translate([-get_width()/2,0,0]) angle_bracket(200);

//scissor_angle(70);

print= 0;
if(print == 1) {
	translate([0,-20,roddia/2+capthick]) rotate([-90,0,0]) cap();	
	translate([0,20,0]) rotate([90,0,0]) foot();

}else if(print == 0){
	// 120 - 420
	scissor_lift(300);
	translate([0,0,0]) foot();
	translate([0,20,15]) leadscrew();
	translate([20,-7,-10]) rotate([90,0,90]) motorPlate();
	
	// base
	translate([-50,0,-17]) color("white") cube([500,500, 10], center= true);
	// bottom running rod 1/4" round
	color("blue") translate([0,-3,-10]) rotate([0,-90,0]) cylinder(r=0.25*mm/2, h= 300);
}else{
	scissor_lift(120+((420-120)*$t));
}

function get_width()= 19;
function get_hole_pos()= 5;
function distancey(a,l)= cos(a)*l;
function distancex(a,l)= sin(a)*l;

// return angle required to get given height
function scissor_height(h,l)= acos((h/4)/(l/2));

module lsnut() {
	translate([-20/2,0,0]) rotate([0,90,0]) cylinder(r=15, h= 20, $fn=6);
}

module angle_bracket(l=100) {
	w= get_width();
	h= w;
	t= 3.2;
	translate([0,0,t/2]) {
		difference() {
			union() {
				cube([w,l,t], center=true);
				translate([w/2-t/2,0,h/2]) cube([t,l,h], center=true);
			}
			translate([0,0,-5]) hole(hole_size, 10);
			translate([0,l/2-get_hole_pos(),-5]) hole(hole_size, 10);
			translate([0,-l/2+get_hole_pos(),-5]) hole(hole_size, 10);
		}
	}
}

module scissor(angle= 45, l= 200) {
	rotate([0,0,angle]) angle_bracket(l);	
	translate([0,0,0]) rotate([0,180,-angle]) angle_bracket(l);
}

module scissor_angle(a, l=200) {	
	x= distancex(a,l/2-get_hole_pos());
	y= distancey(a,l/2-get_hole_pos());

	scissor(a,l);
	translate([0,y*2,0]) scissor(a,l);
	translate([-distancex(a,l/2-get_hole_pos()),-y,0]) bearing();
	translate([-distancex(a,l/2-get_hole_pos()),y*3,-7]) bearing();
	translate([-distancex(a,l/2-get_hole_pos()),-y+15,-20]) lsnut();	
}

module scissors(h) {
	l= bracket_length;
	a= scissor_height(h, l);
	y= distancey(a,l/2-get_hole_pos());
	x= distancex(a,l/2-get_hole_pos());
	translate([-x,y,0]) scissor_angle(a, l);

	// top plate
	translate([0,y*4+10,0]) cap();

	echo("d= ", sqrt((l/2*l/2) - (h/4*h/4))*2);
}

module scissor_lift(h) {
	rotate([90,0,0]) scissors(h);
}

module leadscrew() {
	%rotate([0,-90,0]) cylinder(r=0.5*mm/2, h= 12*mm);
}

// printable objects
module foot() {
	translate([0,40/2,-10]) cube([40,40,4], center= true);
	difference() {
		translate([0,10/2,0]) cube([40,10,30], center= true);
		translate([0,20/2+21/2,0]) rotate([90,0,0]) hole(hole_size, 22);
	}
}

module cap() {
	// top running rod 1/4" round
	%translate([-20,0,0]) rotate([0,-90,0]) cylinder(r=roddia/2, h= 300-40);
	union() {
		// top plate to attach to underside of bed extrusion
		translate([-300+20,roddia/2,-10]) cube([300,capthick,30]);
	
		// attachment bracket
		difference() {
			cylinder(r=40/2, h=4);
			translate([-80/2,roddia/2+4,-4]) cube([80,40,10]);
			#translate([0,-10,-5]) hole(hole_size,10);
		}
	}
}