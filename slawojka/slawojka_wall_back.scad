/*
 * PROMPT: Back wall panel of the Polish outdoor toilet (sławojka) in H0 scale (1:87).
 * Centred ventilation slot near the top, vertical plank grooves on exterior face.
 * Flat 1 mm panel, exterior face up.
 */

$fn = 32;
S = 1/87;
panel_t = 1.0;

bld_w_real   = 1100;
bld_h_real   = 2000;
vent_w_real  = 300;
vent_h_real  = 100;
vent_z_real  = 1800;
plank_period = 200 * S;
groove_w     = 0.8;
groove_d     = 0.5;

bld_w  = bld_w_real * S;
bld_h  = bld_h_real * S;
vent_w = vent_w_real * S;
vent_h = vent_h_real * S;
vent_z = vent_z_real * S;

module wall_back() {
    difference() {
        cube([bld_w, bld_h, panel_t]);

        // ventilation slot, centred, near top
        translate([(bld_w - vent_w)/2, vent_z, -1])
            cube([vent_w, vent_h, panel_t+2]);

        // vertical plank grooves on exterior face
        for (i = [1 : floor(bld_w / plank_period) - 1]) {
            gx = i * plank_period - groove_w/2;
            translate([gx, -1, panel_t - groove_d])
                cube([groove_w, bld_h+2, groove_d+1]);
        }
    }
}

wall_back();
