/*
 * PROMPT: H0 scale (1:87) Eastern European prefab apartment block — flat roof panel with five chimneys, one per bay centred in X at 2/3 depth from front face. Flat slab sized to building footprint, chimneys are solid rectangular protrusions on top. Flat for FDM printing, exterior face up.
 */

$fn = 32;

S          = 1/87;
panel_t    = 1.0;

bld_w      = 18000 * S;   // 206.9 mm
bld_d      = 12000 * S;   // 137.9 mm

n_bays     = 5;
bay_w      = bld_w / n_bays;   // 41.4 mm

chimney_w  = 400 * S;   //  4.6 mm
chimney_d  = 400 * S;   //  4.6 mm
chimney_h  = 700 * S;   //  8.0 mm

module roof_panel() {
    // Flat roof slab
    cube([bld_w, bld_d, panel_t]);

    // Chimneys: one per bay, centred in X, at 2/3 depth from front face
    for (b = [0 : n_bays - 1]) {
        translate([
            b * bay_w + (bay_w - chimney_w) / 2,
            bld_d * 2/3 - chimney_d / 2,
            panel_t
        ])
        cube([chimney_w, chimney_d, chimney_h]);
    }
}

roof_panel();
