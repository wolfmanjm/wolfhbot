use <myLibs.scad>
use <misumi-parts-library.scad>

od= 31.2;
id= 28;
innert= 5;
outert=8;

wheel_id= 22.0; // the diameter of the outside hole
wheel_d= 2.47; // the depth from the outside of the wheel to the bearing
wheel_groove_d= 2.5; // the depth of the groove on the outside of the wheel
wheel_groove_w= 3; // the width of the groove on the outside of the wheel

function w_wheel_dia()= od;
function w_wheel_width()= (outert-innert*2)+innert;
function w_wheel_id()= wheel_id;
function w_wheel_indent()= wheel_d-0.1;

mm= 1.0;

bearing= 608;
//bearing= 605;
%translate([300/2, -od+4, 3]) rotate([0, 45, 90]) hfs2020(300);

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

vwheel();
//profile();

module profile() {
	thick= 4;
	depth= 3;
	od= (bearingOD+depth*2+thick)/2;
	polygon( points=[[0,0],[od,0],[od-depth,depth],[od,depth+depth],[0,depth+depth]] );
}

module vwheel() {
	render() difference() {
		rotate_extrude($fn=200) profile();
       #translate([0,0,-1]) hole(bearingOD, bearingThickness+2, -0.2); // make it very tight fit
	}
}
