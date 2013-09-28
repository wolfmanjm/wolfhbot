use <myLibs.scad>
use <../MCAD/triangles.scad>

width= 40;
height= 35;
depth= 30;
to_center= 20;

shafthole= 16;
bearinghole= 22;
bearingwidth= 7;
thick= 9;

module block(ext=0) {
	union() {
		// base
		translate([0,0,thick/2-ext/2]) cube([width,depth,thick+ext], center= true);

		// sides
		translate([width/2, depth/2-thick+1, thick/2+ext/2]) rotate([90, 0, -90])  triangle(height, depth-thick, 5);
		translate([-width/2+5, depth/2-thick+1, thick/2+ext/2]) rotate([90, 0, -90])  triangle(height, depth-thick, 5);

		// face
		translate([0, depth/2-thick/2, height/2+thick-0.1]) cube(size=[width, thick, height], center=true);
	}
}

module holes(ext=0) {
	// bearing hole
	translate([0, depth/2-thick+bearingwidth, height/2+thick]) rotate([90, 0, 0])  hole(bearinghole, 20);
	// shaft hole
	translate([0, depth/2+5, height/2+thick]) rotate([90, 0, 0])  hole(shafthole, 20);

	//attachment holes
	for(x= [10,-10]) {
		translate([x,-thick/2,-25]) hole(5, 50);
		//counter sink
		#translate([x,-thick/2,-ext+7]) hole(10, thick+ext+20);
	}
}

module pillow(ht=0) {
	// ht is height of center of bearing from the base
	h= ht- (height/2+thick);
	translate([0, 0, h]) difference() {
		block(h);
		holes(h);
	}
}

// print
rotate([-90, 0, 0])  pillow(30);

//pillow(height/2+thick+5);
