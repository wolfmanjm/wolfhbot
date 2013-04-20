use <myLibs.scad>

bearingThickness= 7;
bearingOD= 22;
bearingID= 8;

depth= 5/2;
od= (bearingOD+depth*2+2)/2;
w= 0.9;

idler();

module idler() {
	difference() {
		rotate_extrude($fn=200) polygon( points=[[0,0],[od,0],[od-depth,depth],[od-depth,depth+w],[od,depth+w+depth],[0,depth+w+depth]] );
       #translate([0,0,-0.1]) hole(bearingOD, bearingThickness, 0.1); // make it very tight fit
	}
}
