/*
 * PROMPT: Assembly of the Cities-Skylines-style police station garage annex in H0
 * scale (1:87). Positions all four wall panels and the roof panel in their correct
 * assembled locations. For visualization and GitHub preview only — not for printing.
 */

use <police_station_cs_garage_wall_front.scad>
use <police_station_cs_garage_wall_back.scad>
use <police_station_cs_garage_wall_left.scad>
use <police_station_cs_garage_wall_right.scad>
use <police_station_cs_garage_roof.scad>

$fn = 32;
S       = 1/87;
panel_t = 1.0;
annex_w = 7000 * S;
annex_d = 9000 * S;
annex_h = 4000 * S;

// Front wall — exterior at Y=0
translate([0, panel_t, 0])
    rotate([90, 0, 0])
        garage_wall_front();

// Back wall — exterior at Y=annex_d
translate([0, annex_d - panel_t, annex_h])
    rotate([-90, 0, 0])
        garage_wall_back();

// Left wall — exterior at X=0
translate([panel_t, annex_d, 0])
    rotate([0, 0, -90])
        rotate([90, 0, 0])
            garage_wall_left();

// Right wall — exterior at X=annex_w
translate([annex_w - panel_t, 0, 0])
    rotate([0, 0, 90])
        rotate([90, 0, 0])
            garage_wall_right();

// Roof — sits flush at Z=annex_h
translate([0, 0, annex_h])
    garage_roof();
