use <myLibs.scad>

bracket_length= 250;

//translate([-get_width()/2,0,0]) angle_bracket(200);

//scissor_angle(70);

//scissors(300*$t);

scissor_lift(410);

function get_width()= 10;
function get_hole_pos()= 5;
function distance(a,l)= cos(a)*l;

// return angle required to get given height
function scissor_height(h,l)= acos((h/4)/(l/2));

module angle_bracket(l=100) {
	w= get_width();
	h= 10;
	t= 2;
	translate([0,0,t/2]) {
		difference() {
			union() {
				cube([w,l,t], center=true);
				translate([w/2-t/2,0,h/2]) cube([t,l,h], center=true);
			}
			translate([0,0,-5]) hole(4, 10);
			translate([0,l/2-get_hole_pos(),-5]) hole(4, 10);
			translate([0,-l/2+get_hole_pos(),-5]) hole(4, 10);
		}
	}
}

module scissor(angle= 45, l= 200) {
	rotate([0,0,angle]) angle_bracket(l);	
	translate([]) rotate([0,180,-angle]) angle_bracket(l);
}

module scissor_angle(a, l=200) {	
	scissor(a,l);
	translate([0,distance(a,l/2-get_hole_pos())*2,0]) scissor(a,l);
}

module scissors(h) {
	l= bracket_length;
	a= scissor_height(h, l);
	translate([0,distance(a,l/2),0]) scissor_angle(a, l);
}

module scissor_lift(h) {
	rotate([90,0,0]) scissors(h);
}