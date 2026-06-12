/*
 * PROMPT: Cities-Skylines-style police station garage annex in H0 scale (1:87).
 * Single-storey building with large vehicle bay opening on front face, vertical metal
 * panel siding grooves on all four walls, closed flat roof. FDM printable hollow
 * shell open bottom.
 */

$fn = 32;
S = 1 / 87;

wall_t = 1.5;

// ── GARAGE ────────────────────────────────────────────────────────────────────
annex_w_real  = 7000;   //  80.5 mm H0
annex_d_real  = 9000;   // 103.4 mm H0
annex_h_real  = 4000;   //  46.0 mm H0
garage_w_real = 4500;   //  51.7 mm H0  (vehicle bay opening width)
garage_h_real = 3600;   //  41.4 mm H0  (vehicle bay opening height)

siding_p_real = 500;
siding_w      = 0.8;
siding_d      = 0.3;

// ── DERIVED ───────────────────────────────────────────────────────────────────
annex_w  = annex_w_real * S;
annex_d  = annex_d_real * S;
annex_h  = annex_h_real * S;
garage_w = garage_w_real * S;
garage_h = garage_h_real * S;

siding_p = siding_p_real * S;

// ── MODULES ───────────────────────────────────────────────────────────────────

module siding_x(ox, oy, fw, h, neg_y) {
    n = floor(fw / siding_p);
    for (i = [1 : n]) {
        gx = ox + i * siding_p - siding_w / 2;
        if (neg_y) {
            translate([gx, oy - 1, 0]) cube([siding_w, siding_d + 1, h]);
        } else {
            translate([gx, oy - siding_d, 0]) cube([siding_w, siding_d + 1, h]);
        }
    }
}

module siding_y(ox, oy, fd, h, neg_x) {
    n = floor(fd / siding_p);
    for (i = [1 : n]) {
        gy = oy + i * siding_p - siding_w / 2;
        if (neg_x) {
            translate([ox - 1, gy, 0]) cube([siding_d + 1, siding_w, h]);
        } else {
            translate([ox - siding_d, gy, 0]) cube([siding_d + 1, siding_w, h]);
        }
    }
}

module garage_shell() {
    difference() {
        cube([annex_w, annex_d, annex_h]);
        // hollow, wall_t solid at top forms the roof
        translate([wall_t, wall_t, 0])
            cube([annex_w - 2*wall_t, annex_d - 2*wall_t, annex_h - wall_t]);
        // vehicle bay opening centred on front face
        translate([(annex_w - garage_w)/2, -1, 0])
            cube([garage_w, wall_t + 2, garage_h]);
        // siding on all four faces
        siding_x(0,       0,       annex_w, annex_h, true);
        siding_x(0,       annex_d, annex_w, annex_h, false);
        siding_y(0,       0,       annex_d, annex_h, true);
        siding_y(annex_w, 0,       annex_d, annex_h, false);
    }
}

// ── ASSEMBLY ──────────────────────────────────────────────────────────────────
garage_shell();
