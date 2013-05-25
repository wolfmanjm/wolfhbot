Wolf HBot
============

A large build volume 3d printer based on the HBot (CoreXY) concept.

The plans are use 2020 Misumi extrusions for most of the frame.

* The XY carriages will run on the extrusions on Steve Grabers Universal W Wheels.
* The drive will use #25 Roller chain, but currently uses 65lb Spectra fishing line and machined spools.
* The Z bed lifting mechanism TBD
* build volume is around 12 inches cubed (300x300x300 mm)


Currently using line driven, and just XY moves...

* [first movements](http://youtu.be/cA50g_V9wbQ)
* [second movement](http://youtu.be/p5AFRTE33c4)
* [Drawing big circle](http://youtu.be/9L7iuisqjXY)
* [Insane speed circle](http://youtu.be/wYBltiACMb0)
* [animation of the scissor lift concept](http://blog.wolfman.com/files/scissor-lift.gif)
* [Scissor Lift prototype in action](http://youtu.be/5y0PBw3Y6yg)

Idlers are bearings with some simple collars that go on both ends
of the bearing so the spectra runs on the metal bearing surface.
Use the idlercollar stl, press fit onto each end of bearing with a vice.

The scissor lift idea was nice but the prototype showed that a Nema17 did
not have enough torque to lift the bed.  I think the bottom of the
scissor lift needs to lift 4 times the weight so any pressure on the
top caused the motor to skip. So onto the next idea.

BOM
---
All Aluminum parts are from Misumi with Misumi part numbers

* 12x 500mm HFS2020 20mm extrusions - frame
* 24x HBLFSN5 corner brackets - frame
* 2x  550mm HFS2020 - X Gantry sides
* 2x  85mm HFX2020 - X Gantry sides (Note it's cheaper to buy 2x 1000mm of 2020 and cut these yourself)
* 4x  HBLFSNF5 brackets - X Gantry
* 1x  678mm HFS2020 - Z Bed
* 2x  329mm HFS2020 - Z Bed
* 17x W Wheels with [bearings](http://3d.grabercars.com/?product=universal-w-delrin-roller-with-bearing)
* 2x  Delrin Spools for [Spectra](http://3d.grabercars.com/?product=filament-drive-reel-grooved-delrin-18mm-o-d)
* 2x  608zz bearings - for end idlers
* 4x  605zz bearings - for Gantry idlers
* several yards of 65lb Spectra fishing line (Powerpro)
* 2x ball swivels from a fishing store
* 2x Nema 17 Stepper motors (preferably Kysan or equivalent)
* lots of M5 nuts and bolts
* lots of M3 nuts and bolts

Printed Parts
-------------
* 2x idler-corner.stl
* 1x motor-bracket-l.stl
* 1x motor-bracket-r.stl
* 2x y-carriage.stl
* 1x x-carriage.stl
* 4x z-carriage.stl


TODO
----
Z bed lifting mechanics not designed yet, looking at a scissor lift arrangement

* 1x Nema 17
* 1x lead screw
* 4x 500mm steel or aluminum flat iron
* 4x bearings


License
-------
GPL3 - which basically means if you use any of this you need to release all of your work under GPL3 or compatible license as well.

