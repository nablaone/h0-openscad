/*
 * PROMPT: Eastern European prefabricated concrete panel apartment block in H0 scale
 * (1:87). Parametric: number of floors, real-world width, real-world depth. Flat roof
 * with parapet, regular grid of recessed windows on front and back facades, two narrow
 * stairwell windows per floor on gable ends, horizontal and vertical concrete panel joint
 * grooves, recessed entrance door at ground floor centre, canopy above entrance.
 * FDM printable hollow shell open bottom, exterior detail only.
 */

$fn = 32;
S = 1 / 87;

// ── PARAMETERS ────────────────────────────────────────────────────────────────
floors     = 5;      // number of floors
bld_w_real = 18000;  // building width (real-world mm)
bld_d_real = 12000;  // building depth (real-world mm)

// ── FIXED DIMENSIONS (real-world mm → H0 mm) ──────────────────────────────────
wall_t     = 1.5;           // wall thickness, fixed for printability

floor_h    = 2800 * S;      // floor-to-floor height      32.2 mm
parapet_h  = 600  * S;      // parapet above roof line      6.9 mm
bay_w_real = 3600;          // apartment bay width, real mm

win_w      = 1200 * S;      // window width               13.8 mm
win_h      = 1400 * S;      // window height              16.1 mm
win_recess = 0.8;           // window recess depth

gwin_w     = 400  * S;      // gable stairwell window width  4.6 mm
gwin_h     = 1000 * S;      // gable stairwell window height 11.5 mm

door_w     = 1000 * S;      // entrance door width        11.5 mm
door_h     = 2200 * S;      // entrance door height       25.3 mm

balc_t     = 1.5;           // canopy slab thickness, fixed

groove_w   = 0.8;           // panel joint groove width
groove_d   = 0.6;           // panel joint groove depth

// ── DERIVED ───────────────────────────────────────────────────────────────────
bld_w      = bld_w_real * S;
bld_d      = bld_d_real * S;
bld_h      = floors * floor_h;
n_bays     = floor(bld_w_real / bay_w_real);
bay_w      = bld_w / n_bays;
center_bay = floor(n_bays / 2);

// ── MODULES ───────────────────────────────────────────────────────────────────

module front_cuts() {
    // recessed windows — every bay every floor, skip entrance bay on ground floor
    for (f = [0 : floors - 1]) {
        for (b = [0 : n_bays - 1]) {
            if (!(f == 0 && b == center_bay)) {
                translate([b*bay_w + (bay_w - win_w)/2,
                           -1,
                           f*floor_h + (floor_h - win_h)/2])
                    cube([win_w, win_recess + 1, win_h]);
            }
        }
    }
    // entrance — through-wall opening
    translate([center_bay*bay_w + (bay_w - door_w)/2, -1, 0])
        cube([door_w, wall_t + 2, door_h]);
    // vertical panel joint grooves at bay boundaries
    for (b = [1 : n_bays - 1]) {
        translate([b*bay_w - groove_w/2, -1, 0])
            cube([groove_w, groove_d + 1, bld_h]);
    }
}

module back_cuts() {
    for (f = [0 : floors - 1]) {
        for (b = [0 : n_bays - 1]) {
            translate([b*bay_w + (bay_w - win_w)/2,
                       bld_d - win_recess,
                       f*floor_h + (floor_h - win_h)/2])
                cube([win_w, win_recess + 1, win_h]);
        }
    }
    for (b = [1 : n_bays - 1]) {
        translate([b*bay_w - groove_w/2, bld_d - groove_d, 0])
            cube([groove_w, groove_d + 1, bld_h]);
    }
}

module gable_cuts() {
    // two stairwell windows per floor per gable, at 1/3 and 2/3 of depth
    for (f = [0 : floors - 1]) {
        wz = f * floor_h + (floor_h - gwin_h) / 2;
        for (pos = [1/3, 2/3]) {
            wy = pos * bld_d - gwin_w / 2;
            translate([-1, wy, wz])
                cube([win_recess + 1, gwin_w, gwin_h]);           // left gable
            translate([bld_w - win_recess, wy, wz])
                cube([win_recess + 1, gwin_w, gwin_h]);           // right gable
        }
    }
}

module floor_grooves() {
    // horizontal panel joint grooves at every floor boundary, all four walls
    for (f = [1 : floors - 1]) {
        gz = f * floor_h - groove_w / 2;
        translate([0,              -1,              gz]) cube([bld_w,        groove_d + 1, groove_w]);
        translate([0,              bld_d - groove_d, gz]) cube([bld_w,       groove_d + 1, groove_w]);
        translate([-1,             0,              gz]) cube([groove_d + 1, bld_d,        groove_w]);
        translate([bld_w - groove_d, 0,            gz]) cube([groove_d + 1, bld_d,        groove_w]);
    }
}

module shell() {
    difference() {
        cube([bld_w, bld_d, bld_h + parapet_h]);
        // hollow interior, open bottom
        translate([wall_t, wall_t, 0])
            cube([bld_w - 2*wall_t, bld_d - 2*wall_t, bld_h + parapet_h]);
        front_cuts();
        back_cuts();
        gable_cuts();
        floor_grooves();
    }
}

module entrance_canopy() {
    cw  = door_w + 4;
    cp  = 3;                // canopy projection
    cx  = center_bay * bay_w + (bay_w - door_w) / 2 - 2;
    translate([cx, -cp, door_h])
        cube([cw, cp + wall_t, balc_t]);
}

// ── ASSEMBLY ──────────────────────────────────────────────────────────────────
union() {
    shell();
    entrance_canopy();
}
