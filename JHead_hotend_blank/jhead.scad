hotend_jhead();

module hotend_jhead() {
	translate([0,0,0])  jhead_plastic_body();
	translate([0,0,40]) jhead_brass_nozzle();
}

module jhead_plastic_body() {
	intersection() {
	difference() {
		cylinder(h=40,r=8);
		translate([0,0,4.67]) jhead_groovemount_cutout();
	
		// add the wrench flats
		translate([0,0,32]) jhead_wrench_cutout();
		
		// add (crappy) cooling grooves
		translate([0,0,11.80]) jhead_cooling_cutout();
		translate([0,0,15.00]) jhead_cooling_cutout();
		translate([0,0,18.07]) jhead_cooling_cutout();
		translate([0,0,21.20]) jhead_cooling_cutout();
		translate([0,0,24.50]) jhead_cooling_cutout();
	}
	// get the rounded bit at the end
	sphere(r=40);
	}
}

module jhead_groovemount_cutout() {
	difference() {
		cylinder(h=4.67,r=10);
		cylinder(h=4.67,r=6);
	}
}

module jhead_wrench_cutout() {
	difference() {
		translate([-10,-10,0]) cube([20,20,8]);
		translate([-6,-10,0])  cube([12,20,8]);
	}
}

module jhead_cooling_cutout() {
	render() difference() {
		difference() {
			cylinder(h=2.20,r=10);		
			translate([-1,-10,0]) cube([2,20,2.2]);
			translate([-10,-1,0]) cube([20,2,2.2]);
		}
		cylinder(h=2.20,r=3.9);
	}
}

module jhead_brass_nozzle() { 
	// heater body 12.65 x 12.65 x 8
	//
	//
	difference() {
	union() {
	// draw the cylinder and cap it with the nozzle
	translate([0,0,0])     cylinder(h=9.60, r=3.95);
	translate([0,0,9.6])   cylinder(h=2.25, r1=3.95, r2=1.33);
	translate([-6.3,-4,0]) cube([12.6,12.6,8]);
	}
	translate([6.4,5,4]) rotate([0,270,0]) cylinder(h=12.8,r=3.125);
	}
}