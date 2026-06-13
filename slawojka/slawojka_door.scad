/*
 * PROMPT: Door panel of the Polish outdoor toilet (sławojka) in H0 scale (1:87).
 * Traditional circular moon cutout centred horizontally and positioned near the top.
 * Flat 1 mm panel, exterior face up.
 */

$fn = 64;
S = 1/87;
panel_t = 1.0;

door_w_real = 550;
door_h_real = 1800;
moon_r_real = 100;
moon_z_real = 1500;

door_w = door_w_real * S;
door_h = door_h_real * S;
moon_r = moon_r_real * S;
moon_z = moon_z_real * S;

module door() {
    difference() {
        cube([door_w, door_h, panel_t]);

        // circular moon cutout, centred horizontally
        translate([door_w/2, moon_z, -1])
            cylinder(r=moon_r, h=panel_t+2, $fn=64);
    }
}

door();
