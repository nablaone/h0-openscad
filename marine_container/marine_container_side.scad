/*
 * PROMPT: H0 scale (1:87) ISO shipping container long side panel, flat for printing.
 * 69.6 mm × 29.8 mm × 1 mm. Vertical corrugation grooves on exterior face (Z=1),
 * spaced every 2 mm along length, 0.8 mm wide, 0.3 mm deep, running full height.
 */

$fn = 32;
S = 1 / 87;

panel_t     = 1.0;
container_m = 6;

ctnr_l      = (container_m == 6 ? 6058 : 12192) * S;  // 69.6 mm
ctnr_h      = 2591 * S;                                //  29.8 mm

corr_period = 2.0;   // groove pitch (mm)
corr_w      = 0.8;   // groove width (mm)
corr_d      = 0.3;   // groove depth (mm)

module side_panel() {
    // X = panel width (ctnr_l), Y = panel height (ctnr_h), Z = thickness
    // exterior face is at Z = panel_t (face-up when printing)
    difference() {
        cube([ctnr_l, ctnr_h, panel_t]);
        // vertical corrugation grooves cut from the exterior face downward
        n = floor(ctnr_l / corr_period) - 1;
        for (i = [1 : n]) {
            x = i * corr_period;
            translate([x - corr_w/2, -1, panel_t - corr_d])
                cube([corr_w, ctnr_h + 2, corr_d + 1]);
        }
    }
}

side_panel();
