Wolf HBot
============

_NOTE_ This is still in a process of design and is not currently printing, so anything can change.

A large build volume 3d printer based on the CoreXY concept.

The plans are use 2020 Misumi extrusions for most of the frame.

* The XY carriages will run on either 2020 vslot or 2020 and openrail from openbuilds.com as W Wheels are no longer available
* The drive currently uses 65lb Spectra fishing line and machined spools, but may try to switch to GT2 belts instead
* build volume is around 12 inches cubed (300x300x300 mm)
* The Z lift is in a state of redesign at the moment, currently the Z actuator is 2040 vslot
  and a printed carriage. It runs on an ACME 1/2" leadscrew with 10TPI and a printed PLA Nut

Currently using line driven, and just XY moves...

* [first movements](http://youtu.be/cA50g_V9wbQ)
* [second movement](http://youtu.be/p5AFRTE33c4)
* [Drawing big circle](http://youtu.be/9L7iuisqjXY)
* [Insane speed circle](http://youtu.be/wYBltiACMb0)
* [New Z actuator](http://flic.kr/p/gcBkjw)
* [New Z actuator](http://flic.kr/p/gcBGvX)

For historical purposes...
* [animation of the scissor lift concept](http://blog.wolfman.com/files/scissor-lift.gif)
* [Scissor Lift prototype in action](http://youtu.be/5y0PBw3Y6yg)

Recently re wired to be Corexy, the six idlers are grooved 5mm
bearings that bolt directly to the extrusion on the Xgantry.  The
bearings at the ends are stacked on top of each other with a washer in
between, this allows the cables to run on to of each other and no
cross over is needed.

The four end idlers are grooved 5mm bearings that are screwed directly
into the tapped center of the vertical extrusion. This provides very
solid idlers than can take the tension of the spectra when it is
tight.  The grooves are necessary otherwise the spectra just runs off
the top or bottom of the bearing.

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
smooth.

So this adds several printed parts... The Carriage, a bracket to hold
the leadscrew nut, and bearing blocks.

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
* 2x  Delrin Spools for [Spectra](http://3d.grabercars.com/?product=filament-drive-reel-grooved-delrin-18mm-o-d-for-kossel) or any of the spools he sells at http://3d.grabercars.com/?post_type=product
* 6x  625VV grooved bearings - for idlers from [ebay](http://www.ebay.com/itm/10-5-16-5mm-625VV-5mm-V-Groove-Guide-Pulley-Sealed-Rail-Ball-Bearing-5-16-5-/170998886188?pt=BI_Heavy_Equipment_Parts&hash=item27d053ef2c)
* several yards of 65lb Spectra fishing line (Powerpro)
* 2x ball swivels from a fishing store
* 2x Nema 17 Stepper motors (preferably Kysan or equivalent)
* lots of M5 nuts and bolts
* lots of M3 nuts and bolts

Printed Parts
-------------
* 1x motor-bracket-l.stl
* 1x motor-bracket-r.stl
* 2x y-carriage.stl
* 1x x-carriage.stl
* 4x z-carriage.stl


TODO
----
Z bed lifting mechanics in design, not happy with it yet

* 1x Nema 17
* 1x lead screw (maybe)
* TBD

License
-------

CC BY SA

<a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/deed.en_US"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by-sa/3.0/88x31.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">WolfHBot</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="http://wolfmanjm.github.com/wolfhbot" property="cc:attributionName" rel="cc:attributionURL">Jim Morris</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/deed.en_US">Creative Commons Attribution-ShareAlike 3.0 Unported License</a>.<br />Based on a work at <a xmlns:dct="http://purl.org/dc/terms/" href="https://github.com/wolfmanjm/wolfhbot" rel="dct:source">https://github.com/wolfmanjm/wolfhbot</a>.
