/*
 * PROMPT: H0 scale (1:87) single-car garage door panel, 27.6 mm wide x 24.1 mm tall x 1 mm thick, with 3 raised horizontal rails dividing the door into 4 equal sections, each rail 0.8 mm tall protruding 0.8 mm above the exterior face.
 */

$fn = 32;

panel_t  = 1.0;
rail_h   = 0.8;
rail_proud = 0.8;

gd_w = 27.6;
gd_h = 24.1;

sections = 4;

module garage_door() {
    // Base panel
    cube([gd_w, gd_h, panel_t]);

    // 3 raised horizontal rails at section boundaries (i = 1, 2, 3)
    for (i = [1 : sections - 1]) {
        y = i * gd_h / sections;
        translate([0.3, y - rail_h / 2, 1])
            cube([gd_w - 0.6, rail_proud, rail_h]);
    }
}

garage_door();
