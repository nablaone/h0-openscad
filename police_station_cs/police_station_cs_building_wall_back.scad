/*
 * PROMPT: Back wall panel of the Cities-Skylines-style police station main building
 * in H0 scale (1:87). Three-bay facade with two large windows per bay per floor
 * (twelve windows total). Vertical siding grooves on exterior face.
 * Flat 1 mm panel, exterior face up.
 */

$fn = 32;
S = 1/87;
panel_t = 1.0;

main_w_real   = 18000;
floor_h_real  = 3500;
win_w_real    = 1400;
win_h_real    = 1700;
siding_p_real = 500;
siding_w      = 0.8;
siding_d      = 0.3;

main_w   = main_w_real * S;
floor_h  = floor_h_real * S;
bld_h    = 2 * floor_h;
bay_w    = main_w / 3;
win_w    = win_w_real * S;
win_h    = win_h_real * S;
siding_p = siding_p_real * S;

module wall_back() {
    difference() {
        cube([main_w, bld_h, panel_t]);

        // windows: all three bays, both floors
        for (b = [0:2]) for (f = [0:1]) {
            wy = f * floor_h + (floor_h - win_h) / 2;
            g  = (bay_w - 2*win_w) / 3;
            for (i = [0:1])
                translate([b*bay_w + g + i*(win_w+g), wy, -1])
                    cube([win_w, win_h, panel_t+2]);
        }

        // vertical siding grooves on exterior face
        for (i = [1 : floor(main_w / siding_p)]) {
            gx = i * siding_p - siding_w/2;
            translate([gx, -1, panel_t - siding_d])
                cube([siding_w, bld_h+2, siding_d+1]);
        }
    }
}

wall_back();
