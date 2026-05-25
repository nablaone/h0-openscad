/*
 * PROMPT: Polish PRL-era police station (posterunek milicji) in H0 scale (1:87).
 * Two-storey standalone building, flat roof with parapet, regular window grid on
 * front and back facades, two windows per floor on side walls, recessed entrance
 * door at ground floor centre with concrete steps and canopy above, horizontal
 * floor cornice groove and vertical concrete panel joint grooves.
 * FDM printable hollow shell open bottom, exterior detail only.
 */

$fn = 32;
S = 1 / 87;

// ── DIMENSIONS (real-world mm → H0 mm) ────────────────────────────────────────
wall_t      = 1.5;

bld_w_real  = 18000;         // building width (real-world mm)
bld_d_real  = 9000;          // building depth (real-world mm)

floor_h     = 3000 * S;      // floor-to-floor height   34.5 mm
bld_h       = 2 * floor_h;   // two storeys             69.0 mm
parapet_h   = 600  * S;      // parapet                  6.9 mm

bay_w_real  = 3600;          // bay width, real mm — gives 5 bays

win_w       = 1500 * S;      // front/back window width  17.2 mm
win_h       = 1800 * S;      // front/back window height 20.7 mm
win_recess  = 0.8;

side_win_w  = 1200 * S;      // side window width        13.8 mm
side_win_h  = 1800 * S;      // side window height       20.7 mm

door_w      = 1800 * S;      // entrance door width      20.7 mm
door_h      = 2500 * S;      // entrance door height     28.7 mm

n_steps     = 3;             // entrance steps
step_h      = 150 * S;       // step riser               1.7 mm
step_d      = 300 * S;       // step going               3.4 mm

cornice_w   = 1.5;           // floor cornice groove width
cornice_d   = 0.8;           // floor cornice groove depth

groove_w    = 0.8;           // panel joint groove width
groove_d    = 0.6;           // panel joint groove depth

canopy_proj = 4.0;           // canopy projection (H0 mm)
canopy_t    = 2.0;           // canopy slab thickness (H0 mm)

// ── DERIVED ───────────────────────────────────────────────────────────────────
bld_w      = bld_w_real * S;
bld_d      = bld_d_real * S;
n_bays     = floor(bld_w_real / bay_w_real);   // 5
bay_w      = bld_w / n_bays;
center_bay = floor(n_bays / 2);                // 2

// ── MODULES ───────────────────────────────────────────────────────────────────

module front_cuts() {
    // windows — every bay both floors, except entrance bay on ground floor
    for (f = [0 : 1]) {
        for (b = [0 : n_bays - 1]) {
            if (!(f == 0 && b == center_bay)) {
                translate([b*bay_w + (bay_w - win_w)/2,
                           -1,
                           f*floor_h + (floor_h - win_h)/2])
                    cube([win_w, win_recess + 1, win_h]);
            }
        }
    }
    // entrance — through-wall
    translate([center_bay*bay_w + (bay_w - door_w)/2, -1, 0])
        cube([door_w, wall_t + 2, door_h]);
    // vertical panel joints at bay boundaries
    for (b = [1 : n_bays - 1]) {
        translate([b*bay_w - groove_w/2, -1, 0])
            cube([groove_w, groove_d + 1, bld_h]);
    }
}

module back_cuts() {
    for (f = [0 : 1]) {
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

module side_cuts() {
    // two windows per floor per side at 1/3 and 2/3 depth
    for (f = [0 : 1]) {
        wz = f * floor_h + (floor_h - side_win_h) / 2;
        for (pos = [1/3, 2/3]) {
            wy = pos * bld_d - side_win_w / 2;
            translate([-1, wy, wz])
                cube([win_recess + 1, side_win_w, side_win_h]);
            translate([bld_w - win_recess, wy, wz])
                cube([win_recess + 1, side_win_w, side_win_h]);
        }
    }
}

module cornice_groove() {
    // pronounced horizontal groove at floor line, full perimeter
    gz = floor_h - cornice_w / 2;
    translate([0,                 -1,              gz]) cube([bld_w,        cornice_d + 1, cornice_w]);
    translate([0,                 bld_d-cornice_d, gz]) cube([bld_w,        cornice_d + 1, cornice_w]);
    translate([-1,                0,              gz]) cube([cornice_d + 1, bld_d,         cornice_w]);
    translate([bld_w - cornice_d, 0,              gz]) cube([cornice_d + 1, bld_d,         cornice_w]);
}

module shell() {
    difference() {
        cube([bld_w, bld_d, bld_h + parapet_h]);
        // hollow interior — stops at bld_h, leaving solid roof + parapet
        translate([wall_t, wall_t, 0])
            cube([bld_w - 2*wall_t, bld_d - 2*wall_t, bld_h]);
        front_cuts();
        back_cuts();
        side_cuts();
        cornice_groove();
    }
}

module entrance_steps() {
    sw = door_w + 8;
    sx = center_bay * bay_w + (bay_w - sw) / 2;
    for (i = [0 : n_steps - 1]) {
        // slab i: progressively closer to building, progressively taller
        translate([sx, -(n_steps - i) * step_d, 0])
            cube([sw, step_d, (i + 1) * step_h]);
    }
}

module entrance_canopy() {
    cw = door_w + 6;
    cx = center_bay * bay_w + (bay_w - door_w) / 2 - 3;
    translate([cx, -canopy_proj, door_h])
        cube([cw, canopy_proj + wall_t, canopy_t]);
}

// ── ASSEMBLY ──────────────────────────────────────────────────────────────────
union() {
    shell();
    entrance_steps();
    entrance_canopy();
}
