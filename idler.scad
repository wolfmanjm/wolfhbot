use <myLibs.scad>

mm= 1.0;

bearing= 608;
//bearing= 605;

// Bearing dimensions
// model == XXX ? [inner dia, outer dia, width]:
function bearingDimensions(model) =
  model == 608 ? [8*mm, 22*mm, 7*mm]:
  model == 605 ? [5*mm, 14*mm, 5*mm]:
  model == 623 ? [3*mm, 10*mm, 4*mm]:
  model == 624 ? [4*mm, 13*mm, 5*mm]:
  model == 627 ? [7*mm, 22*mm, 7*mm]:
  model == 688 ? [8*mm, 16*mm, 4*mm]:
  model == 698 ? [8*mm, 19*mm, 6*mm]:
  [8*mm, 22*mm, 7*mm]; // this is the default

bearingThickness= bearingDimensions(bearing)[2];
bearingOD= bearingDimensions(bearing)[1];
bearingID= bearingDimensions(bearing)[0];

echo("Using: ", bearingDimensions(bearing));

depth= 5/2;
od= (bearingOD+depth*2+2)/2;
w= 0.9;

idler();

module vidler() {
	difference() {
		rotate_extrude($fn=200) polygon( points=[[0,0],[od,0],[od-depth,depth],[od-depth,depth+w],[od,depth+w+depth],[0,depth+w+depth]] );
       #translate([0,0,-1]) hole(bearingOD, bearingThickness+2, 0.0); // make it very tight fit
	}
}

// just two collars that keep the line in place
module idler() {
	radius= bearingOD/2+4;
	ht= bearingThickness/2-0.5;
	for(x= [-radius-2, radius+2]) {
		translate([x,0,0]) difference() {
			cylinder(r= radius, h=ht);
	       #translate([0,0,-1]) hole(bearingOD, ht+2, 0.0); // make it very tight fit
		}
	}
}

