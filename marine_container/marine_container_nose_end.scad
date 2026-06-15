/*
 * PROMPT: H0 scale (1:87) ISO shipping container sealed nose end panel, flat for
 * printing. 28.0 mm × 29.8 mm × 1 mm. Two horizontal rail grooves evenly spaced
 * in Y on the exterior face, 0.8 mm wide, 0.3 mm deep, running full width.
 */

$fn = 32;
S = 1 / 87;

panel_t    = 1.0;

ctnr_w     = 2438 * S;   // 28.0 mm — panel width
ctnr_h     = 2591 * S;   // 29.8 mm — panel height

nose_rails = 2;
rail_w     = 0.8;   // groove width (mm)
rail_d     = 0.3;   // groove depth (mm)

module nose_end_panel() {
    // X = panel width (ctnr_w), Y = panel height (ctnr_h), Z = thickness
    // exterior face is at Z = panel_t (face-up when printing)
    difference() {
        cube([ctnr_w, ctnr_h, panel_t]);
        // horizontal rail grooves evenly spaced along Y
        for (i = [1 : nose_rails]) {
            y = i * ctnr_h / (nose_rails + 1);
            translate([-1, y - rail_w/2, panel_t - rail_d])
                cube([ctnr_w + 2, rail_w, rail_d + 1]);
        }
    }
}

nose_end_panel();
