/*
 * PROMPT: Side wall panel of the Polish outdoor toilet (sławojka) in H0 scale (1:87).
 * Plain facade with vertical plank grooves on exterior face. Used for both left and
 * right sides (identical). Flat 1 mm panel, exterior face up.
 */

$fn = 32;
S = 1/87;
panel_t = 1.0;

bld_d_real   = 1100;
bld_h_real   = 2000;
plank_period = 200 * S;
groove_w     = 0.8;
groove_d     = 0.5;

bld_d = bld_d_real * S;
bld_h = bld_h_real * S;

module wall_side() {
    difference() {
        cube([bld_d, bld_h, panel_t]);

        // vertical plank grooves on exterior face
        for (i = [1 : floor(bld_d / plank_period) - 1]) {
            gx = i * plank_period - groove_w/2;
            translate([gx, -1, panel_t - groove_d])
                cube([groove_w, bld_h+2, groove_d+1]);
        }
    }
}

wall_side();
