use <myLibs.scad>

// 608
/*
bearingThickness= 7;
bearingOD= 22;
bearingID= 8;
*/
// 605
bearingThickness= 5;
bearingOD= 14;
bearingID= 5;

depth= 5/2;
od= (bearingOD+depth*2+2)/2;
w= 0.9;

idler();

module idler() {
	difference() {
		rotate_extrude($fn=200) polygon( points=[[0,0],[od,0],[od-depth,depth],[od-depth,depth+w],[od,depth+w+depth],[0,depth+w+depth]] );
       #translate([0,0,-1]) hole(bearingOD, bearingThickness+2, 0.0); // make it very tight fit
	}
}
