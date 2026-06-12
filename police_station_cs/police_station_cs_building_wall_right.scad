/*
 * PROMPT: Right side wall panel of the Cities-Skylines-style police station main
 * building in H0 scale (1:87). Two large windows per floor at one-third and
 * two-thirds depth positions (four windows total). Vertical siding grooves on
 * exterior face. Flat 1 mm panel, exterior face up.
 */

$fn = 32;
S = 1/87;
panel_t = 1.0;

main_d_real   = 13000;
floor_h_real  = 3500;
win_w_real    = 1400;
win_h_real    = 1700;
siding_p_real = 500;
siding_w      = 0.8;
siding_d      = 0.3;

main_d   = main_d_real * S;
floor_h  = floor_h_real * S;
bld_h    = 2 * floor_h;
win_w    = win_w_real * S;
win_h    = win_h_real * S;
siding_p = siding_p_real * S;

module wall_right() {
    difference() {
        cube([main_d, bld_h, panel_t]);

        // windows at 1/3 and 2/3 depth, both floors
        for (f = [0:1]) for (pos = [1/3, 2/3]) {
            wx = pos * main_d - win_w/2;
            wy = f * floor_h + (floor_h - win_h) / 2;
            translate([wx, wy, -1])
                cube([win_w, win_h, panel_t+2]);
        }

        // vertical siding grooves on exterior face
        for (i = [1 : floor(main_d / siding_p)]) {
            gx = i * siding_p - siding_w/2;
            translate([gx, -1, panel_t - siding_d])
                cube([siding_w, bld_h+2, siding_d+1]);
        }
    }
}

wall_right();
