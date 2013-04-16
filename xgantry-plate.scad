use <XGantry.scad>
use <y-carriage.scad>;
use <myLibs.scad>

extrusionw= 20;
extrusionh= 20;
sides= 500; // side length of cube in mm
sep1= sides/2+extrusionw/2; // separation of each side

thick= 5;
w= get_xgantry_width()+extrusionw;
l= 50;
xgantry_length= get_xgantry_length();
back_offset= 1; // amout the back plate is set back to allow for tightening

carriage_ht= 22;

support();

module support() {
	%translate([0,0,-carriage_ht]) Ycarriage_with_wheels();
	%translate([0,sep1+10,-10+thick/2]) rotate([0,0,90]) Xgantry(0);
}



mounting_plate();


module mounting_plate() {
	difference() {
		union() {
			translate([0,0,thick/2]) cube([w,l,thick], center= true);
			// back plate offset back a bit to allow tightening the two y carriages together
			translate([0,-l/2-thick/2-back_offset,(extrusionh+thick)/2]) cube([w,thick,extrusionh+thick], center= true);
			// join backplate with base plate
			#translate([0,-l/2-back_offset/2+0.1,thick/2]) cube([w,back_offset+0.2,thick], center= true);
	
		}
		// mounting holes base
		#translate([-w/2+extrusionw/2,10,0-1]) hole(5, thick+2);
		#translate([w/2-extrusionw/2,10,0-1]) hole(5, thick+2);

		// mounting holes back
		#translate([-w/4-5,-l/2+1,thick/2+extrusionh/2+5/2])rotate([90,0,0]) hole(5, thick+2);
		#translate([w/4+5,-l/2+1,thick/2+extrusionh/2+5/2])rotate([90,0,0]) hole(5, thick+2);
		#translate([0,-l/2+1,thick/2+extrusionh/2+5/2])rotate([90,0,0]) hole(5, thick+2);

		// cutouts for wheel screw heads
		#translate([get_wheelpos(0)[0], get_wheelpos(0)[1], -1]) cylinder(r=6, h= thick+2);
		#translate([get_wheelpos(1)[0], get_wheelpos(1)[1], -1]) cylinder(r=6, h= thick+2);
		#translate([0, l/2, -1]) cylinder(r=6, h= thick+2);

		// holes for fixing to carriage
		#translate([17,15,-1]) hole(3, thick+2);
		#translate([-17,15,-1]) hole(3, thick+2);
		#translate([0,10,-1]) cylinder(r=6/2, thick+2);
	}
}