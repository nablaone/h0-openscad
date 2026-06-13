/*
 * PROMPT: Entrance step of the Polish outdoor toilet (sławojka) in H0 scale (1:87).
 * Small flat concrete slab placed in front of the door. Printed flat.
 */

$fn = 32;
S = 1/87;

step_w_real = 700;
step_d_real = 350;
step_h_real = 150;

step_w = step_w_real * S;
step_d = step_d_real * S;
step_h = step_h_real * S;

module step() {
    cube([step_w, step_d, step_h]);
}

step();
