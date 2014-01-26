use <myLibs.scad>

mm= 25.4;

h= 28;
dia= 16.5;
depth= 5.1;
default_carriage_thickness= 1/4*mm;
chamfer= 2;

layer_ht= 0.25;

function hotend_extender_height() = h;

hotend_extender();

module hotend_extender(carriage_thickness= default_carriage_thickness) {
	union() {
		difference() {
			union() {
				rounded_base(65, 18, 8, h);
				translate([0, 0, h-0.1])  cylinder(r=dia/2, carriage_thickness+depth/2+0.1, $fn= 64);
				translate([0, 0, h+carriage_thickness+depth/2-0.05])  cylinder(r1=dia/2, r2= (dia-1)/2, depth/2-0.4, $fn= 64);
			}

			// hole for extruder head
			translate([0, 0, -0.02])  cylinder(r=dia/2, depth, $fn= 64);

			// extruder mounting holes
			#for (a = [-25,25]) translate([a, 0, -20]) rotate([0, 0, 0])  slot(4, 10, 70);

			// hole for filament
			translate([0, 0, h/2])  cylinder(r=4/2, h=h*2, center=true, $fn= 64);// hole for filament

			// chamfer for filament hole at top
			translate([0, 0, h+depth+carriage_thickness-chamfer+0.1])  cylinder(r2=3, r1=4/2, h=chamfer, $fn= 64);
		}

		// bridging support for bottom hole
		translate([0, 0, depth])  cylinder(r=dia/2+0.5, h=layer_ht, center=false);
	}

}
