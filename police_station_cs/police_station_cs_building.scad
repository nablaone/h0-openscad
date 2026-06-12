/*
 * PROMPT: Cities-Skylines-style small police station main building in H0 scale (1:87).
 * Two-storey block with three-bay front facade (left and right window bays, centre
 * entrance bay), vertical metal panel siding grooves on all walls, two prominent
 * pilasters at front bay boundaries full building height, two large windows per bay
 * per floor, centre entrance with two concrete steps and raised sign panel above door,
 * corrugated flat metal roof with overhang and four dome ventilation units on top.
 * FDM printable hollow shell open bottom.
 */

$fn = 32;
S = 1 / 87;

wall_t = 1.5;

// ── MAIN BUILDING ─────────────────────────────────────────────────────────────
main_w_real  = 18000;
main_d_real  = 13000;
floor_h_real = 3500;

pil_w_real    = 550;
pil_proj_real = 280;

win_w_real = 1400;
win_h_real = 1700;
win_recess = 0.8;

door_w_real = 1800;
door_h_real = 3000;

n_steps     = 2;
step_h_real = 150;
step_d_real = 400;

sign_w_real = 3500;
sign_h_real = 700;
sign_proj   = 0.8;

siding_p_real = 500;
siding_w      = 0.8;
siding_d      = 0.3;

// ── CORRUGATED ROOF ───────────────────────────────────────────────────────────
roof_t  = 3.0;
roof_oh = 2.5;
corr_p  = 2.5;
corr_w  = 0.8;
corr_d  = 0.5;

dome_r     = 1.5;
dome_cyl_h = 1.5;

// ── DERIVED ───────────────────────────────────────────────────────────────────
main_w  = main_w_real * S;
main_d  = main_d_real * S;
floor_h = floor_h_real * S;
bld_h   = 2 * floor_h;
bay_w   = main_w / 3;

pil_w    = pil_w_real * S;
pil_proj = pil_proj_real * S;

win_w = win_w_real * S;
win_h = win_h_real * S;

door_w = door_w_real * S;
door_h = door_h_real * S;
step_h = step_h_real * S;
step_d = step_d_real * S;

sign_w = sign_w_real * S;
sign_h = sign_h_real * S;

siding_p = siding_p_real * S;

// ── MODULES ───────────────────────────────────────────────────────────────────

module two_wins_front(bx, wz) {
    g = (bay_w - 2 * win_w) / 3;
    for (i = [0:1]) {
        translate([bx + g + i * (win_w + g), -1, wz])
            cube([win_w, win_recess + 1, win_h]);
    }
}

module two_wins_back(bx, wz) {
    g = (bay_w - 2 * win_w) / 3;
    for (i = [0:1]) {
        translate([bx + g + i * (win_w + g), main_d - win_recess, wz])
            cube([win_w, win_recess + 1, win_h]);
    }
}

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

module main_shell() {
    difference() {
        cube([main_w, main_d, bld_h]);
        translate([wall_t, wall_t, 0])
            cube([main_w - 2*wall_t, main_d - 2*wall_t, bld_h]);

        for (f = [0:1]) {
            wz = f * floor_h + (floor_h - win_h) / 2;
            two_wins_front(0,       wz);
            two_wins_front(2*bay_w, wz);
        }
        two_wins_front(bay_w, floor_h + (floor_h - win_h) / 2);
        translate([bay_w + (bay_w - door_w)/2, -1, 0])
            cube([door_w, wall_t + 2, door_h]);
        siding_x(0, 0, main_w, bld_h, true);

        for (f = [0:1]) {
            wz = f * floor_h + (floor_h - win_h) / 2;
            two_wins_back(0,       wz);
            two_wins_back(bay_w,   wz);
            two_wins_back(2*bay_w, wz);
        }
        siding_x(0, main_d, main_w, bld_h, false);

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

// ── ASSEMBLY ──────────────────────────────────────────────────────────────────
union() {
    main_shell();
    front_pilasters();
    entrance_steps();
    sign_panel();
    corrugated_roof();
    roof_domes();
}
