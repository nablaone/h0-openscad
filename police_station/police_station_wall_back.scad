/*
 * PROMPT: H0 scale (1:87) PRL-era police station back wall panel, flat for FDM printing.
 * Five bays, windows in all five bays on both floors (no door).
 * Horizontal cornice groove at floor line, vertical panel-joint grooves at bay boundaries.
 */

$fn = 32;

S          = 1/87;
panel_t    = 1.0;

bld_w      = 18000*S;   // 206.9 mm
floor_h    = 3000*S;    //  34.5 mm
bld_h      = 2*floor_h; //  69.0 mm
parapet_h  = 600*S;     //   6.9 mm
wall_panel_h = bld_h + parapet_h; // 75.9 mm

n_bays     = 5;
bay_w      = bld_w / n_bays;  // 41.4 mm

win_w      = 1500*S;    // 17.2 mm
win_h      = 1800*S;    // 20.7 mm

cornice_w  = 1.5;
cornice_d  = 0.8;
groove_w   = 0.8;
groove_d   = 0.6;

module wall_back() {
    difference() {
        // Base slab, exterior face at Z = panel_t (face up)
        cube([bld_w, wall_panel_h, panel_t]);

        // --- Windows: all 5 bays, both floors ---
        for (f = [0:1]) {
            for (b = [0:n_bays-1]) {
                wx = b*bay_w + (bay_w - win_w)/2;
                wy = f*floor_h + (floor_h - win_h)/2;
                translate([wx, wy, -1])
                    cube([win_w, win_h, panel_t+2]);
            }
        }

        // --- Vertical panel-joint grooves on exterior face ---
        for (b = [1:n_bays-1]) {
            gx = b*bay_w - groove_w/2;
            translate([gx, 0, panel_t - groove_d])
                cube([groove_w, wall_panel_h, groove_d+1]);
        }

        // --- Horizontal cornice groove at floor line ---
        cy = floor_h - cornice_w/2;
        translate([0, cy, panel_t - cornice_d])
            cube([bld_w, cornice_w, cornice_d+1]);
    }
}

wall_back();
