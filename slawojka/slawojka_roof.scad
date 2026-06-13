/*
 * PROMPT: Roof parts and assembled roof of the Polish outdoor toilet (sławojka) in H0
 * scale (1:87). Gabled roof with 1.5 mm overhang on all sides. Provides flat printable
 * panels (two slope rectangles + two gable triangles) and an assembled polyhedron
 * module for use in the assembly file. Print layout: all four panels laid flat.
 */

$fn = 32;
S = 1/87;
panel_t = 1.0;

bld_w_real   = 1100;
bld_d_real   = 1100;
bld_h_real   = 2000;
roof_oh      = 1.5;
roof_rise    = 350 * S;

bld_w = bld_w_real * S;
bld_d = bld_d_real * S;
bld_h = bld_h_real * S;

rw       = bld_w + 2*roof_oh;
rd       = bld_d + 2*roof_oh;
slope_w  = sqrt(pow(rw/2, 2) + pow(roof_rise, 2));

// One slope panel printed flat (both slopes are identical rectangles)
module roof_slope() {
    cube([slope_w, rd, panel_t]);
}

// One gable triangle panel printed flat
module roof_gable() {
    linear_extrude(panel_t)
        polygon([[0, 0], [rw, 0], [rw/2, roof_rise]]);
}

// Full assembled roof as polyhedron — used by the assembly file, not for printing
module roof_assembled() {
    translate([-roof_oh, -roof_oh, bld_h])
        polyhedron(
            points = [
                [0,    0,         0],
                [rw,   0,         0],
                [rw,   rd,        0],
                [0,    rd,        0],
                [rw/2, 0,  roof_rise],
                [rw/2, rd, roof_rise],
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

// ── PRINT LAYOUT ──────────────────────────────────────────────────────────────
// Two slope panels side by side, two gable triangles below
roof_slope();
translate([slope_w + 2, 0, 0])
    roof_slope();
translate([0, rd + 2, 0])
    roof_gable();
translate([rw + 2, rd + 2, 0])
    roof_gable();
