// steve grabers W wheel
od= 31.2;
id= 28;
t= (od-id);
thick= 11.7;
t2= thick-t;

function w_wheel_dia()= od;
function w_wheel_width()= thick;

module W_wheel() {
	cylinder(r1=od/2,r2=id/2, h=t/2);
	translate([0,0,t/2]) cylinder(r2=od/2,r1=id/2, h=t/2);
	translate([0,0,t]) cylinder(r=od/2, h= t2/2);
	translate([0,0,-t2/2]) cylinder(r=od/2, h= t2/2);
}

module w_wheel() {
	difference() {
		translate([0,0,-t/2]) W_wheel();
		#translate([0,0,-(thick+4)/2]) cylinder(r=8/2, h=thick+4, $fn=40);
	}
}

module w_wheel_vertical() {
	rotate([0,90,0]) w_wheel();
}

w_wheel_vertical();
//W_wheel();


