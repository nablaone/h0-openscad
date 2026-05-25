/*
 * PROMPT: Single car standalone garage in H0 scale (1:87). Gabled roof with slight
 * overhang, sectional garage door on front facade, one small window on left side wall.
 * FDM printable hollow shell, open bottom, exterior surface detail only.
 */

$fn = 32;

S = 1 / 87;  // H0 scale factor

// Building dimensions (real-world mm → H0 mm)
wall_t    = 1.5;          // wall thickness, fixed for printability

bld_w     = 3000 * S;    // exterior width   34.5 mm
bld_d     = 5500 * S;    // exterior depth   63.2 mm
bld_h     = 2400 * S;    // eave height      27.6 mm

roof_rise = 700  * S;    // gable peak rise   8.0 mm
roof_oh   = 1.5;         // roof overhang (H0 mm)

gd_w      = 2400 * S;    // garage door width    27.6 mm
gd_h      = 2100 * S;    // garage door height   24.1 mm

win_w     = 600  * S;    // side window width     6.9 mm
win_h     = 600  * S;    // side window height    6.9 mm
win_sill  = 1200 * S;    // sill height          13.8 mm

// --- modules ---

module shell() {
    difference() {
        cube([bld_w, bld_d, bld_h]);
        // hollow interior, open bottom
        translate([wall_t, wall_t, 0])
            cube([bld_w - 2*wall_t, bld_d - 2*wall_t, bld_h]);
        // garage door opening — front face (y = 0), horizontally centred
        translate([(bld_w - gd_w) / 2, -1, 0])
            cube([gd_w, wall_t + 2, gd_h]);
        // side window opening — left face (x = 0), centred in depth
        translate([-1, (bld_d - win_w) / 2, win_sill])
            cube([wall_t + 2, win_w, win_h]);
    }
}

module garage_door() {
    // Sectional door: flat fill + 3 raised horizontal rails dividing 4 panels
    sections  = 4;
    sec_h     = gd_h / sections;  // height of each panel section
    rail_h    = 0.8;              // rail height (meets min feature size)
    rail_proud = 0.8;             // how far rails protrude from door surface

    translate([(bld_w - gd_w) / 2, 0, 0]) {
        // flat door panel — fills the opening
        cube([gd_w, wall_t, gd_h]);
        // raised rails at each section boundary
        for (i = [1 : sections - 1]) {
            translate([0.3, wall_t, i * sec_h - rail_h / 2])
                cube([gd_w - 0.6, rail_proud, rail_h]);
        }
    }
}

module left_window() {
    // Window frame on left wall (x = 0 face), centred in depth
    frame_t = 0.8;  // frame border width (meets min feature size)
    translate([0, (bld_d - win_w) / 2, win_sill]) {
        difference() {
            cube([wall_t, win_w, win_h]);
            translate([-1, frame_t, frame_t])
                cube([wall_t + 2, win_w - 2*frame_t, win_h - 2*frame_t]);
        }
    }
}

module roof() {
    rw = bld_w + 2 * roof_oh;  // total roof width
    rd = bld_d + 2 * roof_oh;  // total roof depth

    translate([-roof_oh, -roof_oh, bld_h])
    polyhedron(
        points = [
            [0,    0,  0],          // 0 front-left eave
            [rw,   0,  0],          // 1 front-right eave
            [rw,   rd, 0],          // 2 back-right eave
            [0,    rd, 0],          // 3 back-left eave
            [rw/2, 0,  roof_rise],  // 4 front ridge point
            [rw/2, rd, roof_rise],  // 5 back ridge point
        ],
        faces = [
            [0, 3, 2, 1],  // bottom (eave plane)
            [0, 1, 4],     // front gable
            [3, 5, 2],     // back gable
            [1, 2, 5, 4],  // right slope
            [0, 4, 5, 3],  // left slope
        ]
    );
}

// --- assembly ---
union() {
    shell();
    garage_door();
    left_window();
    roof();
}
