// (c) 2011 Christopher "ScribbleJ" Jansen
//
// bend() module - creates a cube with a U or L shaped bend of the specified
// radius.

// d1 = length of first cube segment
// d2 = length of second cube segment
// r = (inner) radius of bend
// w = width of cube
// a = angle of bend.  0 = U, 180 = ---
// h = height of cube


module bend_demo()
{
  translate([-40*3,0,0])
  rotate([0,0,-90])
  for(i = [0:6])
    translate([0,40*i,0]) bend(a=(6-i)*30);
}

module bend(d1=10,d2=10,r=10,w=5,a=0,h=10)
{
  huge = r*w;
  difference()
  {
    cylinder(r=r+w, h=h);

    translate([0,0,-0.5])
    {
      cylinder(r=r, h=h+1);
      translate([0,r-huge,0]) cube([huge, huge, h+1]);
      rotate([0,0,-a]) translate([0,-r,0]) cube([huge, huge, h+1]);
    }
  }

  translate([0,0,-0.005])
  {
    translate([0,r,0]) cube([d1, w, h+0.01]);
    rotate([0,0,-a]) translate([0,-(r+w),0]) cube([d2, w, h+0.01]);
  }
}

