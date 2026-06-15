/*
 * PROMPT: H0 scale (1:87) single-car garage back wall panel, 34.5 mm wide x 27.6 mm tall x 1 mm thick, plain with no openings.
 */

$fn = 32;

panel_t = 1.0;

bld_w = 34.5;
bld_h = 27.6;

module wall_back() {
    cube([bld_w, bld_h, panel_t]);
}

wall_back();
