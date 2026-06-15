/*
 * PROMPT: H0 scale (1:87) ISO shipping container door end panel, flat for printing.
 * 28.0 mm × 29.8 mm × 1 mm. Three horizontal rail grooves evenly spaced in Y on the
 * exterior face, 0.8 mm wide, 0.3 mm deep, running full width. One vertical centre
 * groove 0.8 mm wide, 0.3 mm deep, running full height, representing the door split.
 */

$fn = 32;
S = 1 / 87;

panel_t    = 1.0;

ctnr_w     = 2438 * S;   // 28.0 mm — panel width
ctnr_h     = 2591 * S;   // 29.8 mm — panel height

door_rails = 3;
rail_w     = 0.8;   // groove width (mm)
rail_d     = 0.3;   // groove depth (mm)
door_gap_w = 0.8;   // centre groove width (mm)

module door_end_panel() {
    // X = panel width (ctnr_w), Y = panel height (ctnr_h), Z = thickness
    // exterior face is at Z = panel_t (face-up when printing)
    difference() {
        cube([ctnr_w, ctnr_h, panel_t]);
        // horizontal rail grooves evenly spaced along Y
        for (i = [1 : door_rails]) {
            y = i * ctnr_h / (door_rails + 1);
            translate([-1, y - rail_w/2, panel_t - rail_d])
                cube([ctnr_w + 2, rail_w, rail_d + 1]);
        }
        // vertical centre groove (door split)
        translate([ctnr_w/2 - door_gap_w/2, -1, panel_t - rail_d])
            cube([door_gap_w, ctnr_h + 2, rail_d + 1]);
    }
}

door_end_panel();
