use <misumi-parts-library.scad>;
use <bed.scad>;
use <XGantry.scad>
use <motor-bracket.scad>
use <x-carriage.scad>
use <y-carriage.scad>
use <sg-spool.scad>
use <idler-corner.scad>
use <scissor-lift.scad>

extrusion= 20; // extrusion 2020
sides= 500; // side length of cube in mm
sep1= sides/2+extrusion/2; // separation of each side
sep= sides;
height= sides-extrusion/2;
bsep= sides/2;
bsep1= sides/2+extrusion/2;
bheight= sides-extrusion;

module gantry(xpos=0) {
        translate([0,0,-2]) Xgantry(xpos);
        translate([sep1+10,0,-10]) rotate([0,0,90]) Ycarriage_with_wheels();
        translate([-sep1-10,0,-10]) rotate([0,0,-90]) Ycarriage_with_wheels();

}


// bottom
raised= 30;
translate([-sep1,-sep/2,extrusion/2+raised]) hfs2020(sides);
translate([sep1,-sep/2,extrusion/2+raised]) hfs2020(sides);
translate([sep/2,sep1,extrusion/2+raised]) rotate([0,0,90]) hfs2020(sides);
translate([sep/2,-sep1,extrusion/2+raised]) rotate([0,0,90]) hfs2020(sides);

// verticals
translate([-sep1,-sep1,0]) rotate([90,0,0]) hfs2020(sides);
translate([sep1,-sep1,0]) rotate([90,0,0]) hfs2020(sides);
translate([-sep1,sep1,0]) rotate([90,0,0]) hfs2020(sides);
translate([sep1,sep1,0]) rotate([90,0,0]) hfs2020(sides);

// top
translate([-sep1,-sep/2,height]) hfs2020(sides);
translate([sep1,-sep/2,height]) hfs2020(sides);
translate([sep/2,sep1,height]) rotate([0,0,90]) hfs2020(sides);
translate([sep/2,-sep1,height]) rotate([0,0,90]) hfs2020(sides);

// brackets inside bottom corner lr
translate([bsep, -sep1, raised]) rotate([0,180,90]) hblfsn5();
translate([-bsep, -sep1, raised]) rotate([0,180,-90]) hblfsn5();
translate([bsep, sep1, raised]) rotate([0,180,90]) hblfsn5();
translate([-bsep, sep1, raised]) rotate([0,180,-90]) hblfsn5();

// brackets inside bottom corner bf
translate([bsep1, -bsep, raised]) rotate([180,0,180]) hblfsn5();
translate([-bsep1, -bsep, raised]) rotate([180,0,180]) hblfsn5();
translate([bsep1, bsep, raised]) rotate([180,0,0]) hblfsn5();
translate([-bsep1, bsep, raised]) rotate([180,0,0]) hblfsn5();

// brackets bottom corner
translate([bsep, -bsep, extrusion/2+raised]) rotate([0,90,90]) hblfsn5();
translate([-bsep, -bsep, extrusion/2+raised]) rotate([0,90,0]) hblfsn5();
translate([bsep, bsep, extrusion/2+raised]) rotate([0,90,180]) hblfsn5();
translate([-bsep, bsep, extrusion/2+raised]) rotate([0,90,-90]) hblfsn5();

// brackets top corner
translate([bsep, -bsep, height]) rotate([0,90,90]) hblfsn5();
translate([-bsep, -bsep, height]) rotate([0,90,0]) hblfsn5();
translate([bsep, bsep, height]) rotate([0,90,180]) hblfsn5();
translate([-bsep, bsep, height]) rotate([0,90,-90]) hblfsn5();

// brackets inside top corner lr
translate([bsep, -sep1, bheight]) rotate([180,0,-90]) hblfsn5();
translate([-bsep, -sep1, bheight]) rotate([180,0,90]) hblfsn5();
translate([bsep, sep1, bheight]) rotate([180,0,-90]) hblfsn5();
translate([-bsep, sep1, bheight]) rotate([180,0,90]) hblfsn5();

// brackets inside top corner bf
translate([bsep1, -bsep, bheight]) rotate([180,0,180]) hblfsn5();
translate([-bsep1, -bsep, bheight]) rotate([180,0,180]) hblfsn5();
translate([bsep1, bsep, bheight]) rotate([180,0,0]) hblfsn5();
translate([-bsep1, bsep, bheight]) rotate([180,0,0]) hblfsn5();

// Base
translate([0,0,raised-10/2]) color("white") cube([520,520, 10], center= true);

///////////////////// end frame ///////////////////////

// Bed
bedh= 420; //top
//bedh= 120; // bottom
//bedh= 232;
translate([0,0, raised+10+bedh]) bed_assembly(1,20);
translate([50,50,raised+10]) rotate([0,0,45]) scissor_lift(bedh);

// X gantry
if(1) {
	translate([0,0,height+extrusion/2]) gantry();
	translate([0,-get_xgantry_width()/2-10,height+extrusion/2+20]) Xcarriage_with_wheels();
}


// Motors
mh= height+10;
if(0) {
	translate([-sides/2-extrusion,sides/2+extrusion,mh+10]) rotate([180,0,90]) motor_bracket(0);
	translate([sides/2+extrusion,sides/2+extrusion,mh+10]) rotate([180,0,90]) motor_bracket(1);
	
	translate([sides/2+extrusion-8,sides/2+extrusion+32,mh+10]) spool();
	translate([-(sides/2+extrusion-8),sides/2+extrusion+32,mh+10]) spool();
}

ih= height+20;
if(0) {
	//corner idlers
	translate([-sides/2-extrusion/2,-sides/2-extrusion/2,ih]) rotate([180,0,90]) idler_mount();
	translate([sides/2+extrusion/2,-sides/2-extrusion/2,ih]) rotate([180,0,180]) idler_mount();
}


