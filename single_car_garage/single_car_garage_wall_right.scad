/*
 * PROMPT: H0 scale (1:87) single-car garage right side wall panel, 63.2 mm wide x 27.6 mm tall x 1 mm thick, plain with no openings.
 */

$fn = 32;

panel_t = 1.0;

bld_d = 63.2;
bld_h = 27.6;

module wall_right() {
    cube([bld_d, bld_h, panel_t]);
}

wall_right();
