use <../MCAD/bearing.scad>

module sprocket(teeth=20, roller=3, pitch=17, thickness=3, tolerance=0.2){
	$fs=0.5;
	roller=roller/2; //We need radius in our calculations, not diameter
	distance_from_center=pitch/(2*sin(180/teeth));
	echo(distance_from_center);
	angle=(360/teeth);
	pitch_circle=sqrt((distance_from_center*distance_from_center) - (pitch*(roller+tolerance))+((roller+tolerance)*(roller+tolerance)));
	echo(pitch_circle);
	difference(){
		union(){
			cylinder(r=pitch_circle,h=thickness);
			for(tooth=[1:teeth]){
				intersection(){
					rotate(a=[0,0,angle*(tooth+0.5)]){
						translate([distance_from_center,0,0]){
							cylinder(r=pitch-roller-tolerance,h=thickness);
						}
					}
					rotate(a=[0,0,angle*(tooth-0.5)]){
						translate([distance_from_center,0,0]){
							cylinder(r=pitch-roller-tolerance,h=thickness);
						}
					}
				}
			}
		}
		for(tooth=[1:teeth]){
			rotate(a=[0,0,angle*(tooth+0.5)]){
				translate([distance_from_center,0,-1]){
					cylinder(r=roller+tolerance,h=thickness+2);
				}
			}
		}
	}
}

thick= 0.126*25.4;
d= bearingOuterDiameter(608);
w= bearingWidth(608);

// #25
difference() {
	union() {
		sprocket(16,0.13*25.4,0.25*25.4,thick-0.2,0.2);
		translate([0,0,thick-0.3]) cylinder(r= d/2+2, h= w/2-thick/2+1);
	}
	cylinder(r=d/2, h= thick+w);
}

%translate([0,0,-w/2+thick/2]) bearing();

