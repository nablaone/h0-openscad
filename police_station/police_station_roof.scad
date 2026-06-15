/*
 * PROMPT: H0 scale (1:87) PRL-era police station flat roof panel, plain slab.
 * Parapet is integrated into the wall panels; roof is a plain flat rectangle.
 */

$fn = 32;

S       = 1/87;
panel_t = 1.0;

bld_w   = 18000*S;   // 206.9 mm
bld_d   = 9000*S;    // 103.4 mm

module roof_panel() {
    cube([bld_w, bld_d, panel_t]);
}

roof_panel();
