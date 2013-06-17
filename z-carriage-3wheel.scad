include <parameters.scad>
use <myLibs.scad>
use <misumi-parts-library.scad>

thick= 10;
attach_thick= 4;

wheel_distance= 80;
depth= 60; // how deep the extrusion goes into the atachement
baselen= depth;
offset=60;

// third wheel separation
wheel_sep= 27.3; // sqrt((extrusion*extrusion)*2);
clearance= 0; // increase for more clearance, decrease for tighter fit
wheel_penetration=1; // the amount the w wheel fits in the slot
wheel_separation= wheel_sep+wheel_diameter+clearance-wheel_penetration*2; // separation of two wheels and bottom wheel for given extrusion

wheel_clearance= 2; // clearance between the side of the extrusion and the carriage
pillarht= wheel_sep/2-wheel_width/2+wheel_clearance;

wheelpos= [ [-wheel_distance/2, 0,0], [wheel_distance/2, 0,0], [0,-wheel_separation,0] ];

wheel_z= pillarht+wheel_width/2;
function get_wheel_z()= wheel_z;

echo("Wheel distance= ", wheel_distance);
echo("Wheel separation= ", wheel_sep);

show_wheels= 0;
print= 1;
//z_carriage(show_wheels,print);
rotate([0,180,0]) mirror([0,0,1]) z_carriage(show_wheels,print);

%support();

//wheel_pillar();
//extr_attach();

module w_wheel() {
	import("w-wheel.stl");
}

module support() {
	// show W Wheels
	for(p=wheelpos)
		translate(p+[-offset,0,wheel_z]) w_wheel();
	
	// show 2020 beam we are riding on
	ed= wheel_separation/2;	
	translate([200/2, -ed, wheel_z]) rotate([0, 45, 90]) hfs2020(300);
	
	// cross brace beam
	translate([0,20,10]) rotate([0, 0, 0]) hfs2020(100);
}

module z_carriage(wheels= 0, print= 0) {
	translate([-offset,0,0]) difference() {	
		union () {
			wheel_mount(print);
			translate([0,depth-pillardia/2,0]){
				extr_attach();
				translate([46,10,0]) rotate([90,0,0]) cylinder(r= 4, h= depth-20);
				translate([47,-8,-0.5]) rotate([-90,-90,180]) triangle(20, 20, 5);
			}
		}
		for(y=[20, 40, 60]) {
			#translate([offset,y,-thick-1]) rotate([0,0,0]) hole(5, thick+4);
		}
	}

	if(wheels == 1) {
		// show W Wheels
		for(p=wheelpos)
			translate(p+[-offset,0,wheel_z]) w_wheel();		
	}
}

module wheel_pillar(){
	ht= pillarht;
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
	d= depth-20;
	translate([offset-extrusion/2-thick/2,-d/4,(extrusion)/2]) rotate([90,0,0]) difference() {
		cube([thick, extrusion, d], center= true);
		// holes
		for(y=[-10, 10]) {
			#translate([-thick/2-2,0,y]) rotate([0,90,0]) hole(5, thick+4);
		}
	}
}

module wheel_mount(print=0) {
    co= 50;
 	r= pillardia/2;
	l= baselen;
	difference() {
		union() {
			translate([0,0,-thick+0.05]) linear_extrude(height= thick) hull() {
		   		translate(wheelpos[0]) circle(r= r);
				//translate(wheelpos[1]) circle(r= r);
				translate(wheelpos[2]) circle(r= r);
				// back support
				translate([offset,0,0]) circle(r= extrusion/2);		
				translate([offset,l,0]) circle(r= extrusion/2);
			}
		
			translate(wheelpos[0]) wheel_pillar();
			translate(wheelpos[1]) wheel_pillar();
          if(print == 0) {
 				translate(wheelpos[2]) wheel_pillar();
			}
 		}
		translate([0,0,-50/2]) {
			translate(wheelpos[0]) hole(3,50);
			translate(wheelpos[1]) hole(3,50);
          if(print == 1) {
	          translate([wheelpos[2][0], wheel_separation+pillardia+5, -50/2]) hole(3,50);
				// slot for adjustable wheel
             translate(wheelpos[2]) rotate([0,0,90]) slot(3,10,50);
			}else{
          	translate(wheelpos[2]) hole(3,50);
          }

			translate([0,-12,0]) cylinder(r=co/2,h= 50);
		}
		if(print == 1) {
			// grub screw at bottom for adjusting tightness of bottom wheel
			translate(wheelpos[2]+[0,-pillardia/4+2,-thick/2]) rotate([90,0,0]) hole(3,pillardia/2);
			translate(wheelpos[2]+[0,-9/2+1.5,-thick/2]) rotate([90,30,0]) nutTrap(ffd=5.46,height=5);
			translate(wheelpos[2]+[0,-9/2+3/2,0]) cube([5.46,3,thick], center=true);
		}

	}

	if(print == 1) {
	  	// print this one separatley so it can be adjustable
		difference() {
			translate([0,wheelpos[2][1]-pillardia-5,-thick]) wheel_pillar();
			translate([0,wheelpos[2][1]-pillardia-5,-50/2]) hole(3,50);			
		}
	}

}