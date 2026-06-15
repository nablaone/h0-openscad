/*
 * PROMPT: H0 scale (1:87) Eastern European prefab apartment block — back wall panel, flat for FDM printing. Five bays wide, five floors tall with parapet, regular windows on all bays and all floors (no door). Vertical panel-joint grooves at bay boundaries, horizontal floor-line grooves. Panel lies flat, exterior face up.
 */

$fn = 32;

S          = 1/87;
panel_t    = 1.0;

floors     = 5;
bld_w      = 18000 * S;   // 206.9 mm
floor_h    = 2800  * S;   //  32.2 mm
bld_h      = floors * floor_h;
parapet_h  = 600   * S;   //   6.9 mm
wall_panel_h = bld_h + parapet_h;

n_bays     = 5;
bay_w      = bld_w / n_bays;   // 41.4 mm

win_w      = 1200 * S;   // 13.8 mm
win_h      = 1400 * S;   // 16.1 mm

groove_w   = 0.8;
groove_d   = 0.6;

module wall_back() {
    difference() {
        // Base slab
        cube([bld_w, wall_panel_h, panel_t]);

        // Windows: all floors, all bays
        for (f = [0 : floors - 1]) {
            for (b = [0 : n_bays - 1]) {
                translate([
                    b * bay_w + (bay_w - win_w) / 2,
                    f * floor_h + (floor_h - win_h) / 2,
                    -1
                ])
                cube([win_w, win_h, panel_t + 2]);
            }
        }

        // Vertical panel-joint grooves on exterior face (Z = panel_t - groove_d)
        for (b = [1 : n_bays - 1]) {
            translate([
                b * bay_w - groove_w / 2,
                0,
                panel_t - groove_d
            ])
            cube([groove_w, wall_panel_h, groove_d + 1]);
        }

        // Horizontal floor-line grooves on exterior face
        for (f = [1 : floors - 1]) {
            translate([
                0,
                f * floor_h - groove_w / 2,
                panel_t - groove_d
            ])
            cube([bld_w, groove_w, groove_d + 1]);
        }
    }
}

wall_back();
