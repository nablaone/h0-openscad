/*
 * PROMPT: H0 scale (1:87) single-car garage gable roof assembly: two flat slope panels (20.4 mm x 66.2 mm x 1 mm each) and two triangular gable end panels (37.5 mm base x 8.0 mm rise x 1 mm thick), plus a 3D assembled roof polyhedron with 1.5 mm overhang on all sides.
 */

$fn = 32;

panel_t    = 1.0;

bld_w      = 34.5;
bld_h      = 27.6;
bld_d      = 63.2;
roof_oh    = 1.5;
roof_rise  = 8.0;

rw         = bld_w + 2 * roof_oh;   // 37.5
rd         = bld_d + 2 * roof_oh;   // 66.2
slope_w    = sqrt((rw / 2) * (rw / 2) + roof_rise * roof_rise); // ≈ 20.4

module roof_slope() {
    cube([slope_w, rd, panel_t]);
}

module roof_gable() {
    linear_extrude(panel_t)
        polygon([[0, 0], [rw, 0], [rw / 2, roof_rise]]);
}

module roof_assembled() {
    translate([-roof_oh, -roof_oh, bld_h])
        polyhedron(
            points = [
                [0,      0,          0],          // 0 front-left eave
                [rw,     0,          0],          // 1 front-right eave
                [rw,     rd,         0],          // 2 back-right eave
                [0,      rd,         0],          // 3 back-left eave
                [rw / 2, 0,          roof_rise],  // 4 front ridge
                [rw / 2, rd,         roof_rise]   // 5 back ridge
            ],
            faces = [
                [0, 3, 2, 1],   // eave soffit (bottom)
                [0, 1, 4],      // front gable
                [3, 5, 2],      // back gable
                [1, 2, 5, 4],   // right slope
                [0, 4, 5, 3]    // left slope
            ]
        );
}

// Print layout: two slope panels side by side, two gable triangles below
roof_slope();
translate([slope_w + 2, 0, 0]) roof_slope();
translate([0, rd + 2, 0]) roof_gable();
translate([rw + 2, rd + 2, 0]) roof_gable();
