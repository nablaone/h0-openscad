/*
 * PROMPT: H0 scale (1:87) PRL-era police station entrance steps, flat print layout.
 * Three concrete step slabs laid side by side with 2 mm gaps for printing.
 * Step 0 is thinnest (one riser height), step 2 is thickest (three riser heights).
 */

$fn = 32;

S       = 1/87;

door_w  = 1800*S;    //  20.7 mm
step_h  = 150*S;     //   1.7 mm
step_d  = 300*S;     //   3.4 mm

sw      = door_w + 8; // step width = 28.7 mm

module steps() {
    for (i = [0:2]) {
        translate([i*(sw+2), 0, 0])
            cube([sw, step_d, (i+1)*step_h]);
    }
}

steps();
