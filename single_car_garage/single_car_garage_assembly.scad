/*
 * PROMPT: H0 scale (1:87) single-car garage 3D assembly visualization combining all wall panels, garage door, and roof in their correct positions.
 */

use <single_car_garage_wall_front.scad>
use <single_car_garage_wall_back.scad>
use <single_car_garage_wall_left.scad>
use <single_car_garage_wall_right.scad>
use <single_car_garage_garage_door.scad>
use <single_car_garage_roof.scad>

$fn = 32;

S       = 1 / 87;
panel_t = 1.0;

bld_w     = 3000 * S;   // 34.5
bld_d     = 5500 * S;   // 63.2
bld_h     = 2400 * S;   // 27.6
gd_w      = 2400 * S;   // 27.6
gd_h      = 2100 * S;   // 24.1
roof_oh   = 1.5;
rw        = bld_w + 2 * roof_oh;   // 37.5
rd        = bld_d + 2 * roof_oh;   // 66.2
slope_w   = sqrt((rw / 2) * (rw / 2) + 8.0 * 8.0); // ≈ 20.4

// Front wall — exterior face at Y=0, panel extending in +Y
translate([0, panel_t, 0])
    rotate([90, 0, 0])
        wall_front();

// Back wall — exterior face at Y=bld_d
translate([0, bld_d - panel_t, bld_h])
    rotate([-90, 0, 0])
        wall_back();

// Left wall — exterior face at X=0
translate([panel_t, bld_d, 0])
    rotate([0, 0, -90])
        rotate([90, 0, 0])
            wall_left();

// Right wall — exterior face at X=bld_w
translate([bld_w - panel_t, 0, 0])
    rotate([0, 0, 90])
        rotate([90, 0, 0])
            wall_right();

// Garage door — seated in front wall opening, centred
translate([(bld_w - gd_w) / 2, panel_t, 0])
    rotate([90, 0, 0])
        garage_door();

// Roof
roof_assembled();
