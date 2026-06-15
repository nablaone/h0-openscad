/*
 * PROMPT: H0 scale (1:87) PRL-era police station side wall panel, flat for FDM printing.
 * Two windows per floor at 1/3 and 2/3 of building depth.
 * Horizontal cornice groove at floor line. Used for both left and right sides (identical).
 */

$fn = 32;

S          = 1/87;
panel_t    = 1.0;

bld_d      = 9000*S;    // 103.4 mm
floor_h    = 3000*S;    //  34.5 mm
bld_h      = 2*floor_h; //  69.0 mm
parapet_h  = 600*S;     //   6.9 mm
wall_panel_h = bld_h + parapet_h; // 75.9 mm

side_win_w = 1200*S;    // 13.8 mm
side_win_h = 1800*S;    // 20.7 mm

cornice_w  = 1.5;
cornice_d  = 0.8;

module wall_side() {
    difference() {
        // Base slab, exterior face at Z = panel_t (face up)
        cube([bld_d, wall_panel_h, panel_t]);

        // --- Windows: 2 per floor, at 1/3 and 2/3 depth ---
        for (f = [0:1]) {
            for (pos = [1/3, 2/3]) {
                wx = pos*bld_d - side_win_w/2;
                wy = f*floor_h + (floor_h - side_win_h)/2;
                translate([wx, wy, -1])
                    cube([side_win_w, side_win_h, panel_t+2]);
            }
        }

        // --- Horizontal cornice groove at floor line ---
        cy = floor_h - cornice_w/2;
        translate([0, cy, panel_t - cornice_d])
            cube([bld_d, cornice_w, cornice_d+1]);
    }
}

wall_side();
