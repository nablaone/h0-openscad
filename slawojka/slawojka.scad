/*
 * PROMPT: Polish outdoor toilet (sławojka) in H0 scale (1:87). Small wooden outhouse
 * with gabled roof, vertical plank texture on all exterior walls, traditional circular
 * moon cutout on door panel, ventilation slot on back wall near the top, and a small
 * concrete entrance step. FDM printable hollow shell open bottom, exterior detail only.
 */

$fn = 32;
S = 1 / 87;

// ── DIMENSIONS (real-world mm → H0 mm) ────────────────────────────────────────
wall_t       = 1.5;         // wall thickness, fixed for printability

bld_w        = 1100 * S;   // exterior width    12.6 mm
bld_d        = 1100 * S;   // exterior depth    12.6 mm
bld_h        = 2000 * S;   // wall height       23.0 mm

roof_rise    = 350  * S;   // gable peak rise    4.0 mm
roof_oh      = 1.5;        // roof overhang (H0 mm)

door_w       = 550  * S;   // door width         6.3 mm
door_h       = 1800 * S;   // door height       20.7 mm

moon_r       = 100  * S;   // moon cutout radius 1.15 mm
moon_z       = 1500 * S;   // moon centre height 17.2 mm

vent_w       = 300  * S;   // vent slot width    3.4 mm
vent_h       = 100  * S;   // vent slot height   1.15 mm
vent_z       = 1800 * S;   // vent bottom z     20.7 mm

step_w       = 700  * S;   // step width         8.0 mm
step_d       = 350  * S;   // step depth         4.0 mm
step_h       = 150  * S;   // step height        1.7 mm

plank_period = 200  * S;   // plank pitch        2.3 mm
groove_w     = 0.8;        // groove width (min feature size)
groove_d     = 0.5;        // groove depth

// ── DERIVED ───────────────────────────────────────────────────────────────────
n_planks_w = floor(bld_w / plank_period) - 1;  // interior groove count on width faces
n_planks_d = floor(bld_d / plank_period) - 1;  // interior groove count on depth faces

// ── MODULES ───────────────────────────────────────────────────────────────────

module shell() {
    difference() {
        cube([bld_w, bld_d, bld_h]);
        // hollow interior, open bottom
        translate([wall_t, wall_t, 0])
            cube([bld_w - 2*wall_t, bld_d - 2*wall_t, bld_h]);
        // door opening — front face (y = 0), horizontally centred
        translate([(bld_w - door_w)/2, -1, 0])
            cube([door_w, wall_t + 2, door_h]);
        // ventilation slot — back wall, horizontally centred, through-wall
        translate([(bld_w - vent_w)/2, bld_d - wall_t - 1, vent_z])
            cube([vent_w, wall_t + 2, vent_h]);
        // vertical plank grooves — front face
        for (i = [1 : n_planks_w]) {
            translate([i*plank_period - groove_w/2, -1, 0])
                cube([groove_w, groove_d + 1, bld_h]);
        }
        // vertical plank grooves — back face
        for (i = [1 : n_planks_w]) {
            translate([i*plank_period - groove_w/2, bld_d - groove_d, 0])
                cube([groove_w, groove_d + 1, bld_h]);
        }
        // vertical plank grooves — left face
        for (i = [1 : n_planks_d]) {
            translate([-1, i*plank_period - groove_w/2, 0])
                cube([groove_d + 1, groove_w, bld_h]);
        }
        // vertical plank grooves — right face
        for (i = [1 : n_planks_d]) {
            translate([bld_w - groove_d, i*plank_period - groove_w/2, 0])
                cube([groove_d + 1, groove_w, bld_h]);
        }
    }
}

module door_panel() {
    // flat door fill with traditional circular moon cutout
    dx = (bld_w - door_w) / 2;
    translate([dx, 0, 0]) {
        difference() {
            cube([door_w, wall_t, door_h]);
            translate([door_w/2, -1, moon_z])
                rotate([-90, 0, 0])
                    cylinder(r=moon_r, h=wall_t + 2, $fn=64);
        }
    }
}

module roof() {
    rw = bld_w + 2*roof_oh;
    rd = bld_d + 2*roof_oh;
    translate([-roof_oh, -roof_oh, bld_h])
    polyhedron(
        points = [
            [0,    0,  0],          // 0 front-left eave
            [rw,   0,  0],          // 1 front-right eave
            [rw,   rd, 0],          // 2 back-right eave
            [0,    rd, 0],          // 3 back-left eave
            [rw/2, 0,  roof_rise],  // 4 front ridge
            [rw/2, rd, roof_rise],  // 5 back ridge
        ],
        faces = [
            [0, 3, 2, 1],
            [0, 1, 4],
            [3, 5, 2],
            [1, 2, 5, 4],
            [0, 4, 5, 3],
        ]
    );
}

module entrance_step() {
    sx = (bld_w - step_w) / 2;
    translate([sx, -step_d, 0])
        cube([step_w, step_d, step_h]);
}

// ── ASSEMBLY ──────────────────────────────────────────────────────────────────
union() {
    shell();
    door_panel();
    roof();
    entrance_step();
}
