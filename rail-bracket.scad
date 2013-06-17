use <myLibs.scad>

mm= 25.4;
dia= 0.25 * mm;
thick= 2;
len= 10;
flangel= 18;
flanget= 3;
flangew= dia/2+8;

//tube();
base_bracket();
//half_cyl(d=dia+thick+4, h= len);

module half_cyl(d, h) {
	$fn= 32;
	difference() {
		translate([0,0,-0.1]) cylinder(r=d/2, h= h);
		translate([-d/2,-d,-0.2]) cube([d,d,h+0.4]);		
	}	
}

module tube() {
	x= dia+thick+6;
	difference() {
		translate([-x/2,0,0]) cube([x,flangew,len]);
		translate([0,dia/2,-0.1]) cylinder(r=dia/2, h= len+0.2,$fn=64);
		translate([0,0,len/2]) cube([dia,dia,len+0.2], center=true);
	}
}

module base_bracket() {
	difference() {
		union() {
			intersection() {
				tube();
				translate([0,thick-0.1,0]) half_cyl(d=dia*2+thick,h=len);
			}
	
			translate([-flangel/2-dia/2,0,0]) cube([flangel/2,thick,len]);
			translate([dia/2,0,0]) cube([flangel/2,thick,len]);
		}
		// holes
		#translate([-flangel/2,6/2,len/2]) rotate([90,0,0]) hole(3, 6);
		#translate([flangel/2,6/2,len/2]) rotate([90,0,0]) hole(3, 6);
	}
}