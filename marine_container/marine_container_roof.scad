/*
 * PROMPT: H0 scale (1:87) ISO shipping container roof panel, flat for printing.
 * 69.6 mm × 28.0 mm × 1 mm. Plain flat panel, no surface detail.
 */

$fn = 32;
S = 1 / 87;

panel_t     = 1.0;
container_m = 6;

ctnr_l      = (container_m == 6 ? 6058 : 12192) * S;  // 69.6 mm
ctnr_w      = 2438 * S;                                //  28.0 mm

module roof_panel() {
    // X = panel width (ctnr_l), Y = panel depth (ctnr_w), Z = thickness
    cube([ctnr_l, ctnr_w, panel_t]);
}

roof_panel();
