/*
 * PROMPT: Front wall panel of the Cities-Skylines-style police station main building
 * in H0 scale (1:87). Three-bay facade: left and right bays with two large windows
 * per floor, centre bay with entrance door on ground floor and two windows on first
 * floor. Vertical siding grooves on exterior face, two full-height pilasters at bay
 * boundaries, raised sign panel above entrance. Flat 1 mm panel, exterior face up.
 */

$fn = 32;
S = 1/87;
panel_t = 1.0;

main_w_real   = 18000;
floor_h_real  = 3500;
pil_w_real    = 550;
pil_proj_real = 280;
win_w_real    = 1400;
win_h_real    = 1700;
door_w_real   = 1800;
door_h_real   = 3000;
sign_w_real   = 3500;
sign_h_real   = 700;
sign_proj     = 0.8;
siding_p_real = 500;
siding_w      = 0.8;
siding_d      = 0.3;

main_w   = main_w_real * S;
floor_h  = floor_h_real * S;
bld_h    = 2 * floor_h;
bay_w    = main_w / 3;
pil_w    = pil_w_real * S;
pil_proj = pil_proj_real * S;
win_w    = win_w_real * S;
win_h    = win_h_real * S;
door_w   = door_w_real * S;
door_h   = door_h_real * S;
sign_w   = sign_w_real * S;
sign_h   = sign_h_real * S;
siding_p = siding_p_real * S;

module wall_front() {
    difference() {
        cube([main_w, bld_h, panel_t]);

        // windows: left bay (b=0), both floors
        for (f = [0:1]) {
            wy = f * floor_h + (floor_h - win_h) / 2;
            g  = (bay_w - 2*win_w) / 3;
            for (i = [0:1])
                translate([g + i*(win_w+g), wy, -1])
                    cube([win_w, win_h, panel_t+2]);
        }

        // windows: right bay (b=2), both floors
        for (f = [0:1]) {
            wy = f * floor_h + (floor_h - win_h) / 2;
            g  = (bay_w - 2*win_w) / 3;
            for (i = [0:1])
                translate([2*bay_w + g + i*(win_w+g), wy, -1])
                    cube([win_w, win_h, panel_t+2]);
        }

        // windows: centre bay (b=1), first floor only
        {
            wy = floor_h + (floor_h - win_h) / 2;
            g  = (bay_w - 2*win_w) / 3;
            for (i = [0:1])
                translate([bay_w + g + i*(win_w+g), wy, -1])
                    cube([win_w, win_h, panel_t+2]);
        }

        // entrance door (centre bay, ground floor)
        translate([bay_w + (bay_w - door_w)/2, 0, -1])
            cube([door_w, door_h, panel_t+2]);

        // vertical siding grooves on exterior face (Z = panel_t)
        for (i = [1 : floor(main_w / siding_p)]) {
            gx = i * siding_p - siding_w/2;
            translate([gx, -1, panel_t - siding_d])
                cube([siding_w, bld_h+2, siding_d+1]);
        }
    }

    // pilasters at bay boundaries (protrude above exterior face)
    for (b = [1, 2])
        translate([b*bay_w - pil_w/2, 0, panel_t])
            cube([pil_w, bld_h, pil_proj]);

    // sign panel above entrance door
    translate([bay_w + (bay_w - sign_w)/2, door_h + 1.5, panel_t])
        cube([sign_w, sign_h, sign_proj]);
}

wall_front();
