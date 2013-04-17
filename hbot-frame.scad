use <misumi-parts-library.scad>;
use <bed.scad>;
use <XGantry.scad>
use <motor-bracket.scad>
use <x-carriage.scad>
use <sg-spool.scad>

extrusion= 20; // extrusion 2020
sides= 500; // side length of cube in mm
sep1= sides/2+extrusion/2; // separation of each side
sep= sides;
height= sides-extrusion/2;
bsep= sides/2;
bsep1= sides/2+extrusion/2;
bheight= sides-extrusion;

// bottom
translate([-sep1,-sep/2,extrusion/2]) hfs2020(sides);
translate([sep1,-sep/2,extrusion/2]) hfs2020(sides);
translate([sep/2,sep1,extrusion/2]) rotate([0,0,90]) hfs2020(sides);
translate([sep/2,-sep1,extrusion/2]) rotate([0,0,90]) hfs2020(sides);

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
translate([bsep, -sep1, extrusion]) rotate([0,0,90]) hblfsn5();
translate([-bsep, -sep1, extrusion]) rotate([0,0,-90]) hblfsn5();
translate([bsep, sep1, extrusion]) rotate([0,0,90]) hblfsn5();
translate([-bsep, sep1, extrusion]) rotate([0,0,-90]) hblfsn5();

// brackets inside bottom corner bf
translate([bsep1, -bsep, extrusion]) rotate([0,0,0]) hblfsn5();
translate([-bsep1, -bsep, extrusion]) rotate([0,0,0]) hblfsn5();
translate([bsep1, bsep, extrusion]) rotate([0,0,180]) hblfsn5();
translate([-bsep1, bsep, extrusion]) rotate([0,0,180]) hblfsn5();

// brackets bottom corner
translate([bsep, -bsep, extrusion/2]) rotate([0,90,90]) hblfsn5();
translate([-bsep, -bsep, extrusion/2]) rotate([0,90,0]) hblfsn5();
translate([bsep, bsep, extrusion/2]) rotate([0,90,180]) hblfsn5();
translate([-bsep, bsep, extrusion/2]) rotate([0,90,-90]) hblfsn5();

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


translate([0,0, 180]) bed_assembly();
//scale([4,4,4]) rotate([90,0,0]) import("jack2.stl");

translate([0,0,height+extrusion/2]) gantry();
translate([0,-get_xgantry_width()/2-10,height+extrusion/2+30]) Xcarriage_with_wheels();

mh= height+10;
translate([-sides/2-extrusion,sides/2+extrusion,mh+20]) rotate([180,0,90]) motor_bracket(0);
translate([sides/2+extrusion,sides/2+extrusion,mh+20]) rotate([180,0,90]) motor_bracket(1);

translate([sides/2+extrusion-8,sides/2+extrusion+32,mh+20]) spool();
translate([-(sides/2+extrusion-8),sides/2+extrusion+32,mh+20]) spool();
