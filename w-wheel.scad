// steve grabers W wheel
od= 31.2;
id= 28;
t= (od-id);
thick= 11.7;
t2= thick-t;

wheel_id= 22.0; // the diameter of the outside hole
wheel_d= 2.47; // the depth from the outside of the wheel to the bearing
wheel_groove_d= 2.5; // the depth of the groove on the outside of the wheel
wheel_groove_w= 3; // the width of the groove on the outside of the wheel

bearingThickness= 7;
bearingOD= 22;
bearingID= 8;

function w_wheel_dia()= od;
function w_wheel_width()= thick;
function w_wheel_id()= wheel_id;
function w_wheel_indent()= wheel_d-0.1;

module W_wheel() {
	cylinder(r1=od/2,r2=id/2, h=t/2);
	translate([0,0,t/2]) cylinder(r2=od/2,r1=id/2, h=t/2);
	translate([0,0,t]) cylinder(r=od/2, h= t2/2);
	translate([0,0,-t2/2]) cylinder(r=od/2, h= t2/2);
}

module groove() {
	// make a negative of the cutout so it can be differenced
	difference() {
		cylinder(r=od/2+0.1, h=wheel_groove_d+0.1, $fn=40);
		cylinder(r=od/2-wheel_groove_w, h=wheel_groove_d, $fn=40);
	}
}

module w_wheel() {
	difference() {
		translate([0,0,-t/2]) W_wheel();
		#translate([0,0,-(thick+4)/2]) cylinder(r=bearingID/2, h=thick+4, $fn=40);
		translate([0,0,thick/2-wheel_d]) cylinder(r=wheel_id/2, h=wheel_d+0.1, $fn=40);
		translate([0,0,-thick/2-wheel_d-0.1+wheel_d]) cylinder(r=wheel_id/2, h=wheel_d+0.1, $fn=40);
		translate([0,0,thick/2-wheel_d]) groove();
		translate([0,0,-thick/2-wheel_groove_d-0.1+wheel_d]) groove();
	}
}

module w_wheel_vertical() {
	rotate([0,90,0]) w_wheel();
}

w_wheel();
//w_wheel_vertical();
//W_wheel();


