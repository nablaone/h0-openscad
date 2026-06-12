/*
 * PROMPT: Cities-Skylines-style police station parking lot in H0 scale (1:87).
 * Flat concrete slab in front of the main building (garage has its own vehicle
 * entrance), painted parking space divider lines running front-to-back and a
 * front boundary line. FDM printable flat slab.
 */

$fn = 32;
S = 1 / 87;

// ── PARKING LOT ───────────────────────────────────────────────────────────────
// width matches the main building only (garage has its own vehicle entrance)
park_total_w_real = 18000;  // 206.9 mm H0
park_d_real       =  7000;  //  80.5 mm H0
park_space_real   =  2500;  //  28.7 mm H0 (one parking space width)

slab_t       = 1.0;
park_line_w  = 0.8;
park_line_h  = 0.4;

// ── DERIVED ───────────────────────────────────────────────────────────────────
park_total_w = park_total_w_real * S;
park_d       = park_d_real * S;
park_space_w = park_space_real * S;

// ── MODULES ───────────────────────────────────────────────────────────────────

module parking_lot() {
    // concrete slab
    cube([park_total_w, park_d, slab_t]);

    // space divider lines (run Y direction)
    n_lines = floor(park_total_w / park_space_w) - 1;
    for (i = [1 : n_lines]) {
        translate([i * park_space_w - park_line_w/2, 0, slab_t])
            cube([park_line_w, park_d, park_line_h]);
    }

    // front boundary line
    translate([0, park_d - park_line_w, slab_t])
        cube([park_total_w, park_line_w, park_line_h]);
}

// ── ASSEMBLY ──────────────────────────────────────────────────────────────────
parking_lot();
