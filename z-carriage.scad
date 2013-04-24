include <parameters.scad>
use <myLibs.scad>
use <w-wheel.scad>
use <misumi-parts-library.scad>

thick= 5;
attach_thick= 4;
pillarht= extrusion/2;
wheel_distance= 100;
depth= 60; // how deep the extrusion goes into the atachement
baselen= depth;
wheelpos= [ [-wheel_distance/2, 0,0], [wheel_distance/2, 0,0]];
offset=20;

echo("Wheel distance= ", wheel_distance);

z_carriage(0);
//%support();

//wheel_pillar();
//extr_attach();

module support() {
	// show W Wheels
	for(p=wheelpos)
		translate(p+[0,0,pillarht]) w_wheel();
	
	// show 2020 beam we are riding on
	ed= sqrt(200);	
	translate([200/2, -ed-wheel_diameter/2+2, pillarht/2+wheel_width/2]) rotate([0, 45, 90]) hfs2020(200);
	
	// cross brace beam
	translate([0,-pillardia/2,10]) rotate([0, 0, 0]) hfs2020(100);
}

module z_carriage(wheels= 0) {
	translate([-offset,0,0]) difference() {	
		union () {
			wheel_mount();
			translate([0,depth-pillardia/2,0]) extr_attach();
		}
		for(y=[0, 20, 40, 60]) {
			#translate([offset,y,-thick/2-3]) rotate([0,0,0]) hole(5, thick+2);
		}
	}

	if(wheels == 1) {
		// show W Wheels
		%for(p=wheelpos)
			translate(p+[-offset,0,pillarht]) w_wheel();		
	}
}

module wheel_pillar(){
	ht= pillarht-bearingThickness+wheel_indent;
	translate([0,0,ht/2]) union() {
   		cylinder(r1=pillardia/2, r2=16/2, h=ht, center=true);
       translate([0,0,ht/2-0.05]) cylinder(r=bearingID/2, h=bearingThickness+wheel_indent, $fn=64);
       translate([0,0,ht/2-0.05]) cylinder(r1=16/2, r2= bearingShaftCollar/2, h=wheel_indent);
   }
}

// extrusion attachment
module extr_attach() {	
	thick= attach_thick;
	clearance= 0.0;
	translate([offset,-depth/2,(extrusion)/2]) rotate([90,0,0]) difference() {
		cube([extrusion+thick*2, extrusion, depth], center= true);
		cube([extrusion+clearance, extrusion+10, depth+2], center= true);
		// holes
		for(y=[-20, 0, 20]) {
			#translate([-extrusion/2-thick-2,0,y]) rotate([0,90,0]) hole(5, thick+4);
			#translate([extrusion/2-2,0,y]) rotate([0,90,0]) hole(5, thick+4);
		}
	}
}

module wheel_mount() {
	r= pillardia/2;
	l= baselen;
	difference() {
		union() {
			translate([0,0,-thick+0.05]) linear_extrude(height= thick) hull() {
		   		translate(wheelpos[0]) circle(r= r);
				translate(wheelpos[1]) circle(r= r);
				translate([offset,l,0]) circle(r= extrusion/2);
			}
		
			translate(wheelpos[0]) wheel_pillar();
			translate(wheelpos[1]) wheel_pillar();
		}
		translate([0,0,-50/2]) {
			translate(wheelpos[0]) hole(3,50);
			translate(wheelpos[1]) hole(3,50);
		}
	}
}