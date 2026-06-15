/*
 * PROMPT: H0 scale (1:87) ISO shipping container assembly — visualization only.
 * Assembles five flat panels (two long sides, door end, nose end, roof) into a
 * complete container shell. Long axis along X, width along Y, height along Z.
 */

$fn = 32;
S = 1 / 87;

panel_t     = 1.0;
container_m = 6;

ctnr_l      = (container_m == 6 ? 6058 : 12192) * S;  // 69.6 mm
ctnr_w      = 2438 * S;                                //  28.0 mm
ctnr_h      = 2591 * S;                                //  29.8 mm

use <marine_container_side.scad>
use <marine_container_door_end.scad>
use <marine_container_nose_end.scad>
use <marine_container_roof.scad>

// Front long side — at Y=0, exterior face pointing toward -Y
// panel X→container X, panel Y→container Z
translate([0, panel_t, 0])
    rotate([90, 0, 0])
        side_panel();

// Back long side — at Y=ctnr_w, exterior face pointing toward +Y
// flip 180° around panel X axis so exterior face still faces outward
translate([0, ctnr_w - panel_t, ctnr_h])
    rotate([-90, 0, 0])
        side_panel();

// Door end — at X=0, exterior face pointing toward -X
// panel X→container Y, panel Y→container Z; rotate in XY then tip up
translate([panel_t, ctnr_w, 0])
    rotate([90, 0, -90])
        door_end_panel();

// Nose end — at X=ctnr_l, exterior face pointing toward +X
translate([ctnr_l - panel_t, 0, 0])
    rotate([90, 0, 90])
        nose_end_panel();

// Roof — sits on top at Z=ctnr_h, exterior face pointing upward (+Z)
translate([0, 0, ctnr_h])
    roof_panel();
