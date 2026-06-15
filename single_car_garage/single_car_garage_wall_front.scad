/*
 * PROMPT: H0 scale (1:87) single-car garage front wall panel, 34.5 mm wide x 27.6 mm tall x 1 mm thick, with a centred through-hole for the garage door opening 27.6 mm wide x 24.1 mm tall at the bottom.
 */

$fn = 32;

panel_t = 1.0;

bld_w = 34.5;
bld_h = 27.6;
gd_w  = 27.6;
gd_h  = 24.1;

module wall_front() {
    difference() {
        cube([bld_w, bld_h, panel_t]);
        // Garage door opening (through hole), centred horizontally, from y=0
        translate([(bld_w - gd_w) / 2, 0, -1])
            cube([gd_w, gd_h, panel_t + 2]);
    }
}

wall_front();
