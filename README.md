# pcb2csx
This is a collection of matlab/octave scripts used to convert printed circuit board (PCB) geometry to CSXCAD. This is intended for PCB layout not just for the layout tool PCB-RND but for anyone else who feels like supporting it. 

# The problem with polygons
CSXCAD is built using CSG (Constructive Solid Geometry) however a lot of PCB layout software does not use this method for calculating clearance in polygons. This library supports clearance via precutting polygons and using the libraries own cutting solids automatically generated with each object (trace, pad, & etc).

# Installation
At the moment I have no real installation system just copy this code to a sensible location and add the following line to your startup.m (matlab) or .octaverc (octave).
addpath('~/opt/openEMS/share/pcb2csx/matlab');
Alternatively you could just copy it to the same directory CSXCAD placed it's matlab files in which you should already have done an addpath for.

# Limitations

* No polygons inside CSG created holes inside polygons. I am working to fix the nested polygon problem.
* No curves/arcs this is a limitation inherited from CSXCAD.
* Trace ends in almost every PCB layout tool ever are round. Currently we let the user define what order polygon to replace them with.
* The terminals (ports) produced are currently only rectangular because they are 1:1 conversions of geometry to CSXCAD port constructs.

# Plans

* Fix the nested polygon problem (see Limitations)
* Support curves/arcs (see Limitations)
* Set the order of the polygon's used to replace round stuff as a function of mesh density.
* Support for non-rectangular port geometry.

# License
This library is LGPL 2/LGPL 3.0. LGPL2 is my prefrence but LGPL 3.0 is added to match the license used by CSXCAD.



