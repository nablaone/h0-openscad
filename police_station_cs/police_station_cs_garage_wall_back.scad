/*
 * PROMPT: Back wall panel of the Cities-Skylines-style police station garage annex
 * in H0 scale (1:87). Plain facade with vertical siding grooves on exterior face.
 * Flat 1 mm panel, exterior face up.
 */

$fn = 32;
S = 1/87;
panel_t = 1.0;

annex_w_real  = 7000;
annex_h_real  = 4000;
siding_p_real = 500;
siding_w      = 0.8;
siding_d      = 0.3;

annex_w  = annex_w_real * S;
annex_h  = annex_h_real * S;
siding_p = siding_p_real * S;

module garage_wall_back() {
    difference() {
        cube([annex_w, annex_h, panel_t]);

        // vertical siding grooves on exterior face
        for (i = [1 : floor(annex_w / siding_p)]) {
            gx = i * siding_p - siding_w/2;
            translate([gx, -1, panel_t - siding_d])
                cube([siding_w, annex_h+2, siding_d+1]);
        }
    }
}

garage_wall_back();
