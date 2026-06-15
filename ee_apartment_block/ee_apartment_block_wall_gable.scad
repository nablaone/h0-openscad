/*
 * PROMPT: H0 scale (1:87) Eastern European prefab apartment block — gable (side/end) wall panel, flat for FDM printing. Spans building depth, five floors tall with parapet. Two narrow stairwell windows per floor at 1/3 and 2/3 of the depth. Horizontal floor-line grooves. Used for both left and right gable ends. Panel lies flat, exterior face up.
 */

$fn = 32;

S          = 1/87;
panel_t    = 1.0;

floors     = 5;
bld_d      = 12000 * S;   // 137.9 mm
floor_h    = 2800  * S;   //  32.2 mm
bld_h      = floors * floor_h;
parapet_h  = 600   * S;   //   6.9 mm
wall_panel_h = bld_h + parapet_h;

gwin_w     = 400  * S;   //  4.6 mm
gwin_h     = 1000 * S;   // 11.5 mm

groove_w   = 0.8;
groove_d   = 0.6;

module wall_gable() {
    difference() {
        // Base slab
        cube([bld_d, wall_panel_h, panel_t]);

        // Stairwell windows at 1/3 and 2/3 depth for each floor
        for (f = [0 : floors - 1]) {
            for (pos = [1/3, 2/3]) {
                translate([
                    pos * bld_d - gwin_w / 2,
                    f * floor_h + (floor_h - gwin_h) / 2,
                    -1
                ])
                cube([gwin_w, gwin_h, panel_t + 2]);
            }
        }

        // Horizontal floor-line grooves on exterior face
        for (f = [1 : floors - 1]) {
            translate([
                0,
                f * floor_h - groove_w / 2,
                panel_t - groove_d
            ])
            cube([bld_d, groove_w, groove_d + 1]);
        }
    }
}

wall_gable();
