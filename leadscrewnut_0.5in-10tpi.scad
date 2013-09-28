use <Thread_Library.scad>

mm= 25.4;
ht= 20;

trapezoidNut(
	length=ht, 				// axial length of the threaded rod 
	radius=15, 				// outer radius of the nut	
	pitch=0.1*mm,                 		// axial distance from crest to crest
	pitchRadius=12/2, 			// radial distance from center to mid-profile
	threadHeightToPitch=0.5,	        // ratio between the height of the profile and the pitch
						// std value for Acme or metric lead screw is 0.5
	profileRatio=0.5, 			// ratio between the lengths of the raised part of the profile and the pitch
						// std value for Acme or metric lead screw is 0.5
	threadAngle=29, 			// angle between the two faces of the thread 
						// std value for Acme is 29 or for metric lead screw is 30
	RH=true, 				// true/false the thread winds clockwise looking along shaft, i.e.follows the Right Hand Rule
	countersunk=0.2, 		// depth of 45 degree chamfered entries, normalized to pitch
	clearance=0.0, 			// radial clearance, normalized to thread height
	backlash=0.1, 			// axial clearance, normalized to pitch
	stepsPerTurn=24 			// number of slices to create per turn
	);
