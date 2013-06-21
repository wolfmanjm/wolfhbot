use <myLibs.scad>
dia= 46.45+0.9;
w= 51.75;
h= 51.5;
t= 15.3;
ductl= 19.5;
ductw= 15.5;
ducto= 3.65;
ductx=8.4;
holediag= 58;
holesz= 4.6;
flangew= 7;
flangel= 8.5;

d= dia;
flangepos= [[d/2*sin(55),-d/2*cos(55),-t/2], [-d/2*sin(45),d/2*cos(45),-t/2]];
fan();
//flange();

module flange() {
	r= flangew/2;
	translate([0,0,0]) difference() {
		union() {
			cube([flangew, flangel-r, t]);
			translate([r,flangel-r,0]) cylinder(r= r, h= t, $fn=64);
			translate([0,-5,0]) cube([flangew, 5, t]);
		}
		translate([flangew/2,flangel-holesz/2-1,-1]) hole(holesz, t+2);
	}
}

module bigger_radius() {
	x= 13;
	translate([0,x+2,-t/2]) cylinder(r=x, h= t);
}

module fan() {
	union() {
		translate([0,0,-t/2]) cylinder(r=dia/2, h= t);
		bigger_radius();
		translate([0,ductx,-t/2]) cube([dia/2+ducto,ductl,t]);
		translate(flangepos[0]) rotate([0,0,225]) flange(); 
		translate(flangepos[1]) rotate([0,0,45]) flange(); 
	}

}