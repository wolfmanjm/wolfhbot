use <misumi-parts-library.scad>;
use <bed.scad>;
use <XGantry.scad>
use <motor-bracket.scad>
use <x-carriage-new.scad>
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
bheight= sides-30;

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
translate([-sep1,-sep/2,height-raised]) hfs2020(sides);
translate([sep1,-sep/2,height-raised]) hfs2020(sides);
translate([sep/2,sep1,height-raised]) rotate([0,0,90]) hfs2020(sides);
translate([sep/2,-sep1,height-raised]) rotate([0,0,90]) hfs2020(sides);

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
translate([bsep, -bsep, height-raised]) rotate([0,90,90]) hblfsn5();
translate([-bsep, -bsep, height-raised]) rotate([0,90,0]) hblfsn5();
translate([bsep, bsep, height-raised]) rotate([0,90,180]) hblfsn5();
translate([-bsep, bsep, height-raised]) rotate([0,90,-90]) hblfsn5();

// brackets inside top corner lr
translate([bsep, -sep1, bheight]) rotate([0,0,90]) hblfsn5();
translate([-bsep, -sep1, bheight]) rotate([0,0,-90]) hblfsn5();
translate([bsep, sep1, bheight]) rotate([0,0,90]) hblfsn5();
translate([-bsep, sep1, bheight]) rotate([0,0,-90]) hblfsn5();

// brackets inside top corner bf
translate([bsep1, -bsep, bheight]) rotate([0,0,0]) hblfsn5();
translate([-bsep1, -bsep, bheight]) rotate([0,0,0]) hblfsn5();
translate([bsep1, bsep, bheight]) rotate([0,0,180]) hblfsn5();
translate([-bsep1, bsep, bheight]) rotate([0,0,180]) hblfsn5();

// Base
translate([0,0,raised+10/2+20]) color("white") cube([520,520, 10], center= true);

///////////////////// end frame ///////////////////////

// Bed
//bedh= 400; //top
//bedh= 140; // bottom
bedh= 232;
if(1) {
	translate([0,0, raised+10+bedh]) bed_assembly(1,0,0);
	//translate([50,50,raised+10]) rotate([0,0,45]) scissor_lift(bedh);
}

// X gantry
if(0) {
	translate([0,0,height+extrusion/2-raised]) gantry();
	translate([0,-get_xgantry_width()/2-10,height+extrusion/2-raised+30]) Xcarriage_with_wheels();
}


// Motors
mh= height-10;
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

// Z gantry, experimental cantilever
zgantry_length= 500-60;
zgantry_pos= -20;
cantilever1_length= tan(45)*(sides/2-(zgantry_pos+20))-30;
echo(str("cantilever1_length=", cantilever1_length));

if(1) {
	translate([sides/2-20, zgantry_pos, 30])  rotate([90,0,90]) hfs2040(zgantry_length);
	translate([sides/2, zgantry_pos+20, raised+10+bedh])  rotate([0,0,90]) hfs2020(cantilever1_length);
	translate([sides/2-cantilever1_length , zgantry_pos+30, raised+10+bedh])  rotate([0,90,0]) hbl45ts5();
}
