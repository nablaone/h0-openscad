/*
 * PROMPT: H0 scale (1:87) Eastern European prefab apartment block — assembly file for visualization. Assembles front wall, back wall, two gable walls, flat roof with chimneys, and an entrance canopy slab over the centre-bay door. For preview only, not for printing.
 */

$fn = 32;

use <ee_apartment_block_wall_front.scad>
use <ee_apartment_block_wall_back.scad>
use <ee_apartment_block_wall_gable.scad>
use <ee_apartment_block_roof.scad>

S          = 1/87;
panel_t    = 1.0;

floors     = 5;
bld_w      = 18000 * S;   // 206.9 mm
bld_d      = 12000 * S;   // 137.9 mm
floor_h    = 2800  * S;   //  32.2 mm
bld_h      = floors * floor_h;
parapet_h  = 600   * S;   //   6.9 mm
wall_panel_h = bld_h + parapet_h;

n_bays     = 5;
bay_w      = bld_w / n_bays;
center_bay = floor(n_bays / 2);

door_w     = 1000 * S;   // 11.5 mm
door_h     = 2200 * S;   // 25.3 mm

balc_t     = 1.5;

// Front wall: panel exterior face toward -Y (street side)
translate([0, panel_t, 0])
rotate([90, 0, 0])
wall_front();

// Back wall: panel exterior face toward +Y
translate([0, bld_d - panel_t, wall_panel_h])
rotate([-90, 0, 0])
wall_back();

// Left gable: exterior face toward -X
translate([panel_t, bld_d, 0])
rotate([0, 0, -90])
rotate([90, 0, 0])
wall_gable();

// Right gable: exterior face toward +X
translate([bld_w - panel_t, 0, 0])
rotate([0, 0, 90])
rotate([90, 0, 0])
wall_gable();

// Roof slab at building height (parapet is part of wall panels)
translate([0, 0, bld_h])
roof_panel();

// Entrance canopy (inline — no separate file)
cw = door_w + 4;
cx = center_bay * bay_w + (bay_w - door_w) / 2 - 2;
translate([cx, -3, door_h])
cube([cw, 3 + panel_t, balc_t]);
