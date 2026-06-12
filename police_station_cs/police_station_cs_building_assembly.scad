/*
 * PROMPT: Assembly of the Cities-Skylines-style police station main building in H0
 * scale (1:87). Positions all four wall panels and the roof panel in their correct
 * assembled locations. For visualization and GitHub preview only — not for printing.
 */

use <police_station_cs_building_wall_front.scad>
use <police_station_cs_building_wall_back.scad>
use <police_station_cs_building_wall_left.scad>
use <police_station_cs_building_wall_right.scad>
use <police_station_cs_building_roof.scad>

$fn = 32;
S       = 1/87;
panel_t = 1.0;
main_w  = 18000 * S;
main_d  = 13000 * S;
bld_h   = 2 * 3500 * S;
roof_oh = 2.5;

// Front wall — exterior at Y=0
translate([0, panel_t, 0])
    rotate([90, 0, 0])
        wall_front();

// Back wall — exterior at Y=main_d
translate([0, main_d - panel_t, bld_h])
    rotate([-90, 0, 0])
        wall_back();

// Left wall — exterior at X=0
translate([panel_t, main_d, 0])
    rotate([0, 0, -90])
        rotate([90, 0, 0])
            wall_left();

// Right wall — exterior at X=main_w
translate([main_w - panel_t, 0, 0])
    rotate([0, 0, 90])
        rotate([90, 0, 0])
            wall_right();

// Roof — sits at Z=bld_h with overhang on all sides
translate([-roof_oh, -roof_oh, bld_h])
    roof();
