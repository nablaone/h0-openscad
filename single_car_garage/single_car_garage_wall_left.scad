/*
 * PROMPT: H0 scale (1:87) single-car garage left side wall panel, 63.2 mm wide x 27.6 mm tall x 1 mm thick, with a centred through-hole window opening 6.9 mm wide x 6.9 mm tall at sill height 13.8 mm.
 */

$fn = 32;

panel_t = 1.0;

bld_d    = 63.2;
bld_h    = 27.6;
win_w    = 6.9;
win_h    = 6.9;
win_sill = 13.8;

module wall_left() {
    difference() {
        cube([bld_d, bld_h, panel_t]);
        // Window opening (through hole), centred horizontally
        translate([(bld_d - win_w) / 2, win_sill, -1])
            cube([win_w, win_h, panel_t + 2]);
    }
}

wall_left();
