/*
 * PROMPT: Roof panel of the Cities-Skylines-style police station garage annex in H0
 * scale (1:87). Plain flat metal panel sized to cover the garage footprint.
 * Flat 1 mm panel, exterior face up.
 */

$fn = 32;
S = 1/87;
panel_t = 1.0;

annex_w_real = 7000;
annex_d_real = 9000;

annex_w = annex_w_real * S;
annex_d = annex_d_real * S;

module garage_roof() {
    cube([annex_w, annex_d, panel_t]);
}

garage_roof();
