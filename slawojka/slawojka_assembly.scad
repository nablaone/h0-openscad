/*
 * PROMPT: Assembly of the Polish outdoor toilet (sławojka) in H0 scale (1:87).
 * Positions all wall panels, door, roof and entrance step in their correct assembled
 * locations. For visualization and GitHub preview only — not for printing.
 */

use <slawojka_wall_front.scad>
use <slawojka_wall_back.scad>
use <slawojka_wall_side.scad>
use <slawojka_door.scad>
use <slawojka_roof.scad>
use <slawojka_step.scad>

$fn = 64;
S       = 1/87;
panel_t = 1.0;
bld_w   = 1100 * S;
bld_d   = 1100 * S;
bld_h   = 2000 * S;
door_w  = 550  * S;
door_h  = 1800 * S;
step_w  = 700  * S;
step_d  = 350  * S;
step_h  = 150  * S;

// Front wall — exterior at Y=0
translate([0, panel_t, 0])
    rotate([90, 0, 0])
        wall_front();

// Back wall — exterior at Y=bld_d
translate([0, bld_d - panel_t, bld_h])
    rotate([-90, 0, 0])
        wall_back();

// Left wall — exterior at X=0
translate([panel_t, bld_d, 0])
    rotate([0, 0, -90])
        rotate([90, 0, 0])
            wall_side();

// Right wall — exterior at X=bld_w
translate([bld_w - panel_t, 0, 0])
    rotate([0, 0, 90])
        rotate([90, 0, 0])
            wall_side();

// Door — in front wall opening, centred
translate([(bld_w - door_w)/2, panel_t, 0])
    rotate([90, 0, 0])
        door();

// Roof — assembled polyhedron
roof_assembled();

// Entrance step — centred in front of door
translate([(bld_w - step_w)/2, -step_d, 0])
    step();
