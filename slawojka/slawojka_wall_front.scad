/*
 * PROMPT: Front wall panel of the Polish outdoor toilet (sławojka) in H0 scale (1:87).
 * Centred door opening from floor to door height, vertical plank grooves on exterior
 * face. Flat 1 mm panel, exterior face up.
 */

$fn = 32;
S = 1/87;
panel_t = 1.0;

bld_w_real    = 1100;
bld_h_real    = 2000;
door_w_real   = 550;
door_h_real   = 1800;
plank_period  = 200 * S;
groove_w      = 0.8;
groove_d      = 0.5;

bld_w  = bld_w_real * S;
bld_h  = bld_h_real * S;
door_w = door_w_real * S;
door_h = door_h_real * S;

module wall_front() {
    difference() {
        cube([bld_w, bld_h, panel_t]);

        // door opening, centred, from floor
        translate([(bld_w - door_w)/2, 0, -1])
            cube([door_w, door_h, panel_t+2]);

        // vertical plank grooves on exterior face
        for (i = [1 : floor(bld_w / plank_period) - 1]) {
            gx = i * plank_period - groove_w/2;
            translate([gx, -1, panel_t - groove_d])
                cube([groove_w, bld_h+2, groove_d+1]);
        }
    }
}

wall_front();
