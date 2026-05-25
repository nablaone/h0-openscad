/*
 * PROMPT: Cities-Skylines-style small police station in H0 scale (1:87). Two-storey
 * main block with three-bay front facade (left and right window bays, centre entrance
 * bay), vertical metal panel siding grooves on all walls, two prominent pilasters at
 * front bay boundaries full building height, two large windows per bay per floor,
 * centre entrance with two concrete steps and raised sign panel above door, corrugated
 * flat metal roof with overhang and four dome ventilation units on top. Single-storey
 * garage annex attached to right side with large vehicle bay opening on front face.
 * FDM printable hollow shell open bottom.
 */

$fn = 32;
S = 1 / 87;

wall_t = 1.5;

// ── MAIN BUILDING ─────────────────────────────────────────────────────────────
main_w_real  = 18000;   // building width (real mm)   206.9 mm H0
main_d_real  = 13000;   // building depth (real mm)   149.4 mm H0
floor_h_real = 3500;    // floor-to-floor height       40.2 mm H0

pil_w_real   = 550;     // pilaster width               6.3 mm H0
pil_proj_real = 280;    // pilaster projection          3.2 mm H0

win_w_real   = 1400;    // window width                16.1 mm H0
win_h_real   = 1700;    // window height               19.5 mm H0
win_recess   = 0.8;

door_w_real  = 1800;    // entrance door width         20.7 mm H0
door_h_real  = 3000;    // entrance door height        34.5 mm H0

n_steps      = 2;       // entrance steps
step_h_real  = 150;
step_d_real  = 400;

sign_w_real  = 3500;    // raised sign panel width     40.2 mm H0
sign_h_real  = 700;     // raised sign panel height     8.0 mm H0
sign_proj    = 0.8;     // sign panel projection from wall

siding_p_real = 500;    // vertical siding panel pitch  5.7 mm H0
siding_w      = 0.8;    // siding groove width (min feature)
siding_d      = 0.3;    // siding groove depth

// ── CORRUGATED ROOF ───────────────────────────────────────────────────────────
roof_t     = 3.0;    // roof slab thickness (H0 mm)
roof_oh    = 2.5;    // overhang beyond walls (H0 mm)
corr_p     = 2.5;    // corrugation pitch, grooves run front-to-back (H0 mm)
corr_w     = 0.8;    // corrugation groove width
corr_d     = 0.5;    // corrugation groove depth (roof_t − corr_d = 2.5 ≥ 1.2 ✓)

dome_r     = 1.5;    // HVAC dome radius (H0 mm)
dome_cyl_h = 1.5;    // HVAC dome cylinder height (H0 mm)

// ── PARKING LOT ───────────────────────────────────────────────────────────────
park_d_real   = 7000;   //  80.5 mm H0  (depth in front of building)
park_space_real = 2500; //  28.7 mm H0  (parking space width)
slab_t        = 1.0;    // concrete slab thickness
park_line_w   = 0.8;    // parking space divider line width
park_line_h   = 0.4;    // parking space divider line height above slab

// ── ANNEX ─────────────────────────────────────────────────────────────────────
annex_w_real  = 7000;   //  80.5 mm H0
annex_d_real  = 9000;   // 103.4 mm H0
annex_h_real  = 4000;   //  46.0 mm H0
garage_w_real = 4500;   //  51.7 mm H0  (vehicle bay opening width)
garage_h_real = 3600;   //  41.4 mm H0  (vehicle bay opening height)

// ── DERIVED ───────────────────────────────────────────────────────────────────
main_w   = main_w_real * S;
main_d   = main_d_real * S;
floor_h  = floor_h_real * S;
bld_h    = 2 * floor_h;
bay_w    = main_w / 3;

pil_w    = pil_w_real * S;
pil_proj = pil_proj_real * S;

win_w    = win_w_real * S;
win_h    = win_h_real * S;

door_w   = door_w_real * S;
door_h   = door_h_real * S;
step_h   = step_h_real * S;
step_d   = step_d_real * S;

sign_w   = sign_w_real * S;
sign_h   = sign_h_real * S;

siding_p = siding_p_real * S;

annex_w  = annex_w_real * S;
annex_d  = annex_d_real * S;
annex_h  = annex_h_real * S;
garage_w = garage_w_real * S;
garage_h = garage_h_real * S;

park_d       = park_d_real * S;
park_space_w = park_space_real * S;
park_total_w = main_w + annex_w;

// ── MODULES ───────────────────────────────────────────────────────────────────

// 2 windows centred in a bay, on the front face (y = 0)
module two_wins_front(bx, wz) {
    g = (bay_w - 2 * win_w) / 3;
    for (i = [0:1]) {
        translate([bx + g + i * (win_w + g), -1, wz])
            cube([win_w, win_recess + 1, win_h]);
    }
}

// 2 windows centred in a bay, on the back face (y = main_d)
module two_wins_back(bx, wz) {
    g = (bay_w - 2 * win_w) / 3;
    for (i = [0:1]) {
        translate([bx + g + i * (win_w + g), main_d - win_recess, wz])
            cube([win_w, win_recess + 1, win_h]);
    }
}

// vertical siding grooves along X, cutting into front face (-y) or back face (+y)
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

// vertical siding grooves along Y, cutting into left face (-x) or right face (+x)
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

module main_shell() {
    difference() {
        cube([main_w, main_d, bld_h]);
        // hollow interior, open top and bottom
        translate([wall_t, wall_t, 0])
            cube([main_w - 2*wall_t, main_d - 2*wall_t, bld_h]);

        // ── front facade ──
        // windows: left bay (b=0) and right bay (b=2), all floors
        for (f = [0:1]) {
            wz = f * floor_h + (floor_h - win_h) / 2;
            two_wins_front(0,        wz);
            two_wins_front(2*bay_w,  wz);
        }
        // centre bay: entrance ground floor, windows 1st floor
        two_wins_front(bay_w, floor_h + (floor_h - win_h) / 2);
        translate([bay_w + (bay_w - door_w)/2, -1, 0])
            cube([door_w, wall_t + 2, door_h]);
        // siding on front face
        siding_x(0, 0, main_w, bld_h, true);

        // ── back facade ──
        for (f = [0:1]) {
            wz = f * floor_h + (floor_h - win_h) / 2;
            two_wins_back(0,        wz);
            two_wins_back(bay_w,    wz);
            two_wins_back(2*bay_w,  wz);
        }
        siding_x(0, main_d, main_w, bld_h, false);

        // ── side facades (2 windows per floor at 1/3 and 2/3 depth) ──
        for (f = [0:1]) {
            wz = f * floor_h + (floor_h - win_h) / 2;
            for (pos = [1/3, 2/3]) {
                wy = pos * main_d - win_w / 2;
                translate([-1, wy, wz])
                    cube([win_recess + 1, win_w, win_h]);
                translate([main_w - win_recess, wy, wz])
                    cube([win_recess + 1, win_w, win_h]);
            }
        }
        siding_y(0,      0, main_d, bld_h, true);
        siding_y(main_w, 0, main_d, bld_h, false);
    }
}

module front_pilasters() {
    // two full-height white pilasters at bay boundaries on front facade
    for (b = [1, 2]) {
        translate([b * bay_w - pil_w/2, -pil_proj, 0])
            cube([pil_w, pil_proj + wall_t, bld_h]);
    }
}

module entrance_steps() {
    sw = door_w + 6;
    sx = bay_w + (bay_w - door_w) / 2 - 3;
    for (i = [0 : n_steps - 1]) {
        translate([sx, -(n_steps - i) * step_d, 0])
            cube([sw, step_d, (i + 1) * step_h]);
    }
}

module sign_panel() {
    // raised rectangular panel above entrance door (where "POLICE" lettering goes)
    sz = door_h + 1.5;
    sx = bay_w + (bay_w - sign_w) / 2;
    translate([sx, -sign_proj, sz])
        cube([sign_w, sign_proj + wall_t, sign_h]);
}

module corrugated_roof() {
    rw = main_w + 2 * roof_oh;
    rd = main_d + 2 * roof_oh;
    n  = floor(rw / corr_p) - 1;

    difference() {
        translate([-roof_oh, -roof_oh, bld_h])
            cube([rw, rd, roof_t]);
        // grooves on top surface running front-to-back (Y direction)
        for (i = [1 : n]) {
            gx = -roof_oh + i * corr_p - corr_w / 2;
            translate([gx, -roof_oh - 1, bld_h + roof_t - corr_d])
                cube([corr_w, rd + 2, corr_d + 1]);
        }
    }
}

module hvac_dome(dx, dy) {
    translate([dx, dy, bld_h + roof_t]) {
        cylinder(r=dome_r, h=dome_cyl_h, $fn=16);
        translate([0, 0, dome_cyl_h])
            sphere(r=dome_r, $fn=16);
    }
}

module roof_domes() {
    for (xi = [0, 1]) {
        for (yi = [0, 1]) {
            hvac_dome(
                main_w * (xi == 0 ? 0.22 : 0.78),
                main_d * (yi == 0 ? 0.28 : 0.72)
            );
        }
    }
}

module annex_shell() {
    difference() {
        translate([main_w, 0, 0])
            cube([annex_w, annex_d, annex_h]);
        // hollow, closed top (wall_t solid at top = annex roof)
        translate([main_w + wall_t, wall_t, 0])
            cube([annex_w - 2*wall_t, annex_d - 2*wall_t, annex_h - wall_t]);
        // vehicle bay opening — front face, centred in annex width
        translate([main_w + (annex_w - garage_w)/2, -1, 0])
            cube([garage_w, wall_t + 2, garage_h]);
        // siding on annex front, back, and right faces
        siding_x(main_w, 0,       annex_w, annex_h, true);
        siding_x(main_w, annex_d, annex_w, annex_h, false);
        siding_y(main_w + annex_w, 0, annex_d, annex_h, false);
    }
}

module parking_lot() {
    // flat concrete slab in front of the building (y < 0)
    translate([0, -park_d, 0])
        cube([park_total_w, park_d, slab_t]);

    // parking space divider lines running front-to-back (Y direction)
    n_lines = floor(park_total_w / park_space_w) - 1;
    for (i = [1 : n_lines]) {
        translate([i * park_space_w - park_line_w/2, -park_d, slab_t])
            cube([park_line_w, park_d, park_line_h]);
    }
    // front boundary line (at y = -park_d)
    translate([0, -park_d, slab_t])
        cube([park_total_w, park_line_w, park_line_h]);
}

// ── ASSEMBLY ──────────────────────────────────────────────────────────────────
union() {
    main_shell();
    front_pilasters();
    entrance_steps();
    sign_panel();
    corrugated_roof();
    roof_domes();
    annex_shell();
    parking_lot();
}
