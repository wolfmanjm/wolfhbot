// this is the long spool from steve graber

spool();

h= 37;
sh= 19;
bh= 15;
th= 3;
dia= 18;
odia= 20.5;

module spool() {
	cylinder(r= odia/2, h=bh);
	translate([0,0,bh]) cylinder(r=dia/2, h=sh);
	translate([0,0,bh+sh]) cylinder(r=odia/2, h=th);
}