/*
 * PROMPT: ISO dry-cargo shipping container in H0 scale (1:87). Parametric length:
 * 6 m (≈ 20 ft) or 12 m (≈ 40 ft). Vertical corrugation grooves on both long side
 * walls, three horizontal panel rail grooves on door end with vertical centre groove
 * between the two door leaves, two horizontal rail grooves on sealed nose end.
 * Open bottom hollow shell, closed roof.
 */

$fn = 32;
S = 1 / 87;

// ── PARAMETER ─────────────────────────────────────────────────────────────────
container_m = 6;   // container length in metres: 6 (≈ 20 ft) or 12 (≈ 40 ft)

// ── DIMENSIONS (real-world mm → H0 mm) ────────────────────────────────────────
wall_t      = 1.5;            // shell thickness, fixed for printability

// ISO external dimensions — width and height identical for both lengths
ctnr_l      = (container_m == 6 ? 6058 : 12192) * S;  // 69.6 mm or 140.1 mm
ctnr_w      = 2438 * S;       //  28.0 mm
ctnr_h      = 2591 * S;       //  29.8 mm

// vertical corrugations on long sides (grooves in Z, spaced along X)
corr_period = 2.0;            // groove pitch (H0 mm)
corr_w      = 0.8;            // groove width  (minimum feature size)
corr_d      = 0.3;            // groove depth  (wall_t − corr_d ≥ 1.2 mm minimum)

// end wall panel rails (horizontal grooves in Y, spaced in Z)
door_rails  = 3;              // grooves on door end
nose_rails  = 2;              // grooves on sealed nose end
rail_w      = 0.8;
rail_d      = 0.3;            // same constraint as corr_d

door_gap_w  = 0.8;            // width of vertical centre groove on door end

// ── MODULES ───────────────────────────────────────────────────────────────────

module side_corrugations() {
    // vertical grooves running full height, spaced along container length
    n = floor(ctnr_l / corr_period) - 1;
    for (i = [1 : n]) {
        x = i * corr_period;
        translate([x - corr_w/2, -1, 0])
            cube([corr_w, corr_d + 1, ctnr_h]);         // front long side (y = 0)
        translate([x - corr_w/2, ctnr_w - corr_d, 0])
            cube([corr_w, corr_d + 1, ctnr_h]);         // back long side (y = ctnr_w)
    }
}

module door_end_cuts() {
    // horizontal rails, evenly spaced in Z
    for (i = [1 : door_rails]) {
        z = i * ctnr_h / (door_rails + 1) - rail_w/2;
        translate([-1, 0, z])
            cube([rail_d + 1, ctnr_w, rail_w]);
    }
    // vertical centre groove separating the two door leaves
    translate([-1, ctnr_w/2 - door_gap_w/2, 0])
        cube([rail_d + 1, door_gap_w, ctnr_h]);
}

module nose_end_cuts() {
    for (i = [1 : nose_rails]) {
        z = i * ctnr_h / (nose_rails + 1) - rail_w/2;
        translate([ctnr_l - rail_d, 0, z])
            cube([rail_d + 1, ctnr_w, rail_w]);
    }
}

// ── ASSEMBLY ──────────────────────────────────────────────────────────────────
difference() {
    cube([ctnr_l, ctnr_w, ctnr_h]);
    // hollow shell — open bottom, closed roof (wall_t thick)
    translate([wall_t, wall_t, 0])
        cube([ctnr_l - 2*wall_t, ctnr_w - 2*wall_t, ctnr_h - wall_t]);
    side_corrugations();
    door_end_cuts();
    nose_end_cuts();
}
