/*
 * PROMPT: H0 scale (1:87) PRL-era police station assembly for visualization.
 * Assembles front wall, back wall, two side walls, roof, entrance steps, and canopy
 * from the individual part files. Not intended for printing — visualization only.
 */

$fn = 32;

use <police_station_wall_front.scad>
use <police_station_wall_back.scad>
use <police_station_wall_side.scad>
use <police_station_roof.scad>
use <police_station_steps.scad>

S            = 1/87;
panel_t      = 1.0;

bld_w        = 18000*S;         // 206.9 mm
bld_d        = 9000*S;          // 103.4 mm
floor_h      = 3000*S;          //  34.5 mm
bld_h        = 2*floor_h;       //  69.0 mm
parapet_h    = 600*S;           //   6.9 mm
wall_panel_h = bld_h + parapet_h; // 75.9 mm

n_bays       = 5;
bay_w        = bld_w / n_bays;  //  41.4 mm
center_bay   = 2;

door_w       = 1800*S;          //  20.7 mm
door_h       = 2500*S;          //  28.7 mm

canopy_proj  = 4.0;
canopy_t     = 2.0;

n_steps      = 3;
step_h       = 150*S;           //   1.7 mm
step_d       = 300*S;           //   3.4 mm

// Front wall: panel lies in XZ plane, exterior face facing -Y
translate([0, panel_t, 0])
    rotate([90, 0, 0])
        wall_front();

// Back wall: panel lies in XZ plane, exterior face facing +Y
translate([0, bld_d - panel_t, wall_panel_h])
    rotate([-90, 0, 0])
        wall_back();

// Left wall: panel lies in YZ plane, exterior face facing -X
translate([panel_t, bld_d, 0])
    rotate([0, 0, -90])
        rotate([90, 0, 0])
            wall_side();

// Right wall: panel lies in YZ plane, exterior face facing +X
translate([bld_w - panel_t, 0, 0])
    rotate([0, 0, 90])
        rotate([90, 0, 0])
            wall_side();

// Roof: flat slab at top of walls (below parapet — parapet is part of wall panels)
translate([0, 0, bld_h])
    roof_panel();

// Steps in front of entrance door
translate([center_bay*bay_w + (bay_w - door_w)/2 - 4, -(n_steps*step_d), 0])
    steps();

// Canopy above entrance door (inline, no separate part file)
translate([center_bay*bay_w + (bay_w - door_w)/2 - 3, -canopy_proj, door_h])
    cube([door_w + 6, canopy_proj + panel_t, canopy_t]);
