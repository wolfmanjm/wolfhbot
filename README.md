Wolf CoreXY
============

_NOTE_ This is still a work in progess, it is currently printing quite well.
_UPDATE_ Changed the Y rails to Makerslide and Makeslide carriages and VWheels.

A large build volume 3d printer based on the CoreXY concept.

It uses 2020 Misumi extrusions for most of the frame.

* The X carriage runs on 2020 and openrail from openbuilds.com
* The Y carraiges run on Makerslide from Inventables.com
* The drive can use either 65lb Spectra fishing line and machined spools, or GT2 pulleys and belts
* the Belts have no corss over, they are stacked on top of eachother instead
* build volume is around 12 inches cubed (300x300x300 mm)
* The Z platform has one Z actuator made of 2040 vslot
  and a printed carriage. It runs on an ACME 1/2" leadscrew with 10TPI and a printed PLA Nut
  and uses a moving knot to keep the cantilever level
* The X carriage is printable but is best milled from MDF

Pictures and Videos
-------------------

* [first movements](http://youtu.be/cA50g_V9wbQ)
* [second movement](http://youtu.be/p5AFRTE33c4)
* [Drawing big circle](http://youtu.be/9L7iuisqjXY)
* [Insane speed circle](http://youtu.be/wYBltiACMb0)
* [New Z actuator](http://flic.kr/p/gcBkjw)
* [New Z actuator](http://flic.kr/p/gcBGvX)
* [Printing vase](http://youtu.be/nGm1CWDJkY0)
* [Corexy Belt no cross over](http://flic.kr/p/iT5DkX)
* [Corexy Belt no cross over](http://flic.kr/p/iT7Lpm)
* [Corexy Belt no cross over](http://flic.kr/p/iT73UX)

For historical purposes...

* [animation of the scissor lift concept](http://blog.wolfman.com/files/scissor-lift.gif)
* [Scissor Lift prototype in action](http://youtu.be/5y0PBw3Y6yg)

Recently re wired to be Corexy rather than HBot. This seems to reduce
racking of the X Gantry. [See](http://joshuavasquez.com/docs/jVasquez/Projects/coreXY.html)

I see no difference between using Spectra line drive and GT2 belts, in
fact if anything it was slightly smoother using the line drive.

Spectra Drive
--------------
For Spectra drive the four idlers on the XGantry are grooved 5mm bearings that bolt
directly to the extrusion slots. One of the X carriage bearings is
raised 10mm to keep the lines parallel.

The four end idlers are grooved 5mm bearings that are screwed directly
into the tapped center of the vertical extrusion. This provides very
solid idlers than can take the tension of the spectra when it is
tight.  The grooves are necessary otherwise the spectra just runs off
the top or bottom of the bearing.
These bearings are stacked on top of each other with a
washer in between, this allows the cables to run on top of each other
and no cross over is needed.

GT2 Belt Drive
--------------
The two end idlers are 2x flanged bearings back to back, and another pair separated with a washer above it,
Then two of the idlers on the X Gantry are raised to keep the belt riding level.
I avoid the cross over of the belts by running the two belts one above the other in parallel.

Z Bed
-----

The scissor lift idea was nice but the prototype showed that a Nema17
did not have enough torque to lift the bed.  I think the bottom of the
scissor lift needs to lift 4 times the weight so any pressure on the
top caused the motor to skip.

The new Z actuator is a length of 500mm of 2040 VSlot, with a printed
carriage and v wheels. Driven by a McMaster ACME 1/2" leadscrew with
10TPI, Bearing blocks using 608 at top and bottom and a Nema17 with
5mm/0.25" flexible coupling. The bottom bearing block isolates the
flexible coupling from taking any weight and compressing. As the 1/2"
leadscrew is pretty big it has no wobble as far as I can tell and
having bearings top and bottom seems to be very stable. I also used a
printed Leadscrew nut printed in PLA and it seems pretty snug and
smooth. I also used a half height leadscrew nut and spring to implement
antibacklash which appears to be necessary.

There is a length of 2040 that spans from the Z actuator to the other
side of the frame where another 500mm length of 2040 VSlot has a vslot
mini carriage which is bolted to the end of the 2040 beam. Halfway
along this beam is a short piece of 2020 perpendicular to it, this
provides the third attachment point for the bed.

The most important part of this design is the
[moving knot](http://cockrum.net/cnc_mechanical.html), which is attached to
the top and bottom and runs over 4 v groove bearings on the cross
beam, This keeps the beam level while allowing a single actuator on one
end to move it up and down. This is the [far end](http://flic.kr/p/i67Sim),
and here is a view of the [whole assembly](http://flic.kr/p/i67Es7).

The bed is attached to the cross beam at three places to provide three
point bed levelling.  I use a scheme where a 4mm stud is screwed into
the tslots, and a 25mm length of aluminum rod, tapped to 4mm is
screwed onto that, this can be turned to move up and down the stud. At
the top of the aluminum is a cut out that the glass bed fits. Next to
this, and also bolted into the tslot, is an M4 bolt with a conical
spring bolted to the top, this pushes the glass at the three
attachment points up into the slots on the aluminum rounds. This keeps
the glass flat without deforming it, and allows it to be leveled at
three points by turning the aluminum rounds. Some jam nuts are used
to screw up to the aluminum rounds to stop them unscrewing once
levelled.

So this adds several printed parts... The Carriage, a bracket to hold
the leadscrew nut, and bearing blocks. Also some lathe work to cut a
thread into the center of some 1/2" aluminum round, and lathe a groove
at the top that the glass can slot into. (If the bed is not heated
this could be a printed part).

BOM
---
Aluminum parts are from Misumi with Misumi part numbers

* 10x 500mm HFS2020 20mm extrusions - frame
* 16x HBLFSN5 corner brackets - frame
* 2x  550mm HFS2020 - X Gantry sides
* 2x  85mm HFS2020 - X Gantry sides (Note it's cheaper to buy 2x 1000mm of 2020 and cut these yourself)
* 2x  540mm Makerslide - Y Rails
* 4x  HBLFSNF5 brackets - X Gantry
* 1x  500mm HFS2040 - Z Bed
* 1x  250mm HFS2020 - Z Bed
* 2x  Shapeoko motor mounts https://www.inventables.com/technologies/upgraded-shapeoko-motor-mount - Y carriages
* 12x VWheels https://www.inventables.com/technologies/dual-bearing-v-wheel-kit or http://openbuildspartstore.com/delrin-v-wheel-kit/
* lots of M5 nuts and bolts
* lots of M3 nuts and bolts
* 2x Nema 17 Stepper motors (preferably Kysan or equivalent)

Spectra drive
-------------
* 2x  Delrin Spools for [Spectra](http://3d.grabercars.com/?product=filament-drive-reel-grooved-delrin-18mm-o-d-for-kossel) or any of the spools he sells at http://3d.grabercars.com/?post_type=product
* 8x  625VV grooved bearings - for idlers from [ebay](http://www.ebay.com/itm/10-5-16-5mm-625VV-5mm-V-Groove-Guide-Pulley-Sealed-Rail-Ball-Bearing-5-16-5-/170998886188?pt=BI_Heavy_Equipment_Parts&hash=item27d053ef2c)
* several yards of 65lb Spectra fishing line (Powerpro)
* 2x ball swivels from a fishing store

OR

Belt Drive
----------
* 10 meters GT2 belt
* 2 x GT2 pulleys 20 tooth
* 12 x 5mm flanged bearings for the idlers 

Printed Parts
-------------
* 1x motor-bracket-l.stl
* 1x motor-bracket-r.stl
* 1x x-carriage.stl

Z bed
-----
* 1x Nema 17
* 1x lead screw (McMaster 1/2" 10TPI ACME)
* Two printed Leadscrew nuts and a collar for the anti backlash
* 5/8" diameter spring for the anti backlash
* 2x 500mm 2040 VSlot
* 4x solid V Wheels http://openbuildspartstore.com/solid-v-wheel-kit/
* 1x printed Z carriage, plus leadnut holder
* 1x mini vslot carriage and mini wheels http://openbuildspartstore.com/mini-v-wheel-plate/
* 4x v groove bearings, 2x turnbuckles, two lengths of Spectra fishing line for the moving knot

Construction
------------

Getting the top of the frame square is essential, measure each end of the Y
rails to make sure they are parallel. Next the belts need to have exactly the
same tension to keep the X gantry straight, this was introducing non-square
prints for me. Loosen the X gantry on both Y carriages so it sits loosely on
the Y carriages, then measure the distance of each end of the X Gantry to the
front corner of the frame. Now tighten one or other belt until the X Gantry is
square to the Y rails, then tighten it down to the Y carriages.

If you find cylinders print out oblong or squares are not square this is
probably the problem.

License
-------

CC BY SA

<a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/deed.en_US"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by-sa/3.0/88x31.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">WolfHBot</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="http://wolfmanjm.github.com/wolfhbot" property="cc:attributionName" rel="cc:attributionURL">Jim Morris</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/deed.en_US">Creative Commons Attribution-ShareAlike 3.0 Unported License</a>.<br />Based on a work at <a xmlns:dct="http://purl.org/dc/terms/" href="https://github.com/wolfmanjm/wolfhbot" rel="dct:source">https://github.com/wolfmanjm/wolfhbot</a>.
