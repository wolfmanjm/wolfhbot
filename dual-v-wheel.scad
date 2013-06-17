// openbuilds dual v wheel
od= 24.39;
id= 18.75;

t= 5.12; // thickness of one half
thick= 10.23;

wheel_id= id; // the diameter of the outside hole
wheel_d= 0; // the depth from the outside of the wheel to the bearing
wheel_groove_d= 0; // the depth of the groove on the outside of the wheel
wheel_groove_w= 0; // the width of the groove on the outside of the wheel

bearingThickness= 5;
bearingOD= 16;
bearingID= 5;

function v_wheel_dia()= od;
function v_wheel_width()= thick;
function v_wheel_id()= wheel_id;
function v_wheel_indent()= wheel_d-0.1;

module V_wheel() {
	cylinder(r1=od/2,r2=id/2, h=t/2);
	translate([0,0,t/2]) cylinder(r2=od/2,r1=id/2, h=t/2);
	translate([0,0,t]) cylinder(r1=od/2, r2=id/2, h= t/2);
	translate([0,0,-t/2]) cylinder(r2=od/2, r1=id/2, h= t/2);
}

module groove() {
	// make a negative of the cutout so it can be differenced
	difference() {
		cylinder(r=od/2+0.1, h=wheel_groove_d+0.1, $fn=40);
		cylinder(r=od/2-wheel_groove_w, h=wheel_groove_d, $fn=40);
	}
}

module v_wheel() {
	difference() {
		translate([0,0,-t/2]) V_wheel();
		translate([0,0,-(thick+4)/2]) cylinder(r=bearingID/2, h=thick+4, $fn=40);
	}
}

module v_wheel_vertical() {
	rotate([0,90,0]) v_wheel();
}

v_wheel();
//w_wheel_vertical();
//V_wheel();


