/*
 * PROMPT: Roof panel of the Cities-Skylines-style police station main building in H0
 * scale (1:87). Flat corrugated metal panel with 2.5 mm overhang on all sides,
 * corrugation grooves running front-to-back, four HVAC dome ventilation units on the
 * top surface. Flat 1 mm panel, exterior face up.
 */

$fn = 32;
S = 1/87;
panel_t = 1.0;

main_w_real = 18000;
main_d_real = 13000;
roof_oh     = 2.5;
corr_p      = 2.5;
corr_w      = 0.8;
corr_d      = 0.5;
dome_r      = 1.5;
dome_cyl_h  = 1.5;

main_w = main_w_real * S;
main_d = main_d_real * S;

module roof() {
    rw = main_w + 2*roof_oh;
    rd = main_d + 2*roof_oh;

    difference() {
        cube([rw, rd, panel_t]);

        // corrugation grooves on exterior face (run Y direction)
        for (i = [1 : floor(rw / corr_p) - 1]) {
            gx = i * corr_p - corr_w/2;
            translate([gx, -1, panel_t - corr_d])
                cube([corr_w, rd+2, corr_d+1]);
        }
    }

    // HVAC dome vents on exterior face
    for (xi = [0,1]) for (yi = [0,1]) {
        dx = roof_oh + main_w * (xi == 0 ? 0.22 : 0.78);
        dy = roof_oh + main_d * (yi == 0 ? 0.28 : 0.72);
        translate([dx, dy, panel_t]) {
            cylinder(r=dome_r, h=dome_cyl_h, $fn=16);
            translate([0, 0, dome_cyl_h]) sphere(r=dome_r, $fn=16);
        }
    }
}

roof();
