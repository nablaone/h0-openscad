# H0 Piko-like Diorama — OpenSCAD Project

## Project overview

3D printable models for an H0 scale (1:87) diorama. Models are designed to look realistic on a layout, not to be functional replicas. Interiors of buildings are irrelevant — only exterior appearance matters.

## Scale

**H0 = 1:87**. Every real-world dimension must be divided by 87.
- A 3 m door → 34.5 mm
- A 10 m building → 114.9 mm
- A 1.435 m standard gauge track → 16.5 mm

Always think in real-world mm first, then divide by 87.

## Repository layout

Each design lives in its own directory named after the model (`snake_case`):

```
<model_name>/
  Makefile                          # per-project build rules (same template)
  <model_name>.scad                 # realization: full solid reference model
  <model_name>.stl                  # mesh of full model
  <model_name>.png                  # preview of full model
  <model_name>_<part>.scad          # individual printable part (flat, lay-flat oriented)
  <model_name>_<part>.stl           # mesh of that part
  <model_name>_assembly.scad        # imports all parts, shows assembled position
  <model_name>_assembly.stl         # mesh of assembly (for GitHub 3D viewer)
  <model_name>_assembly.png         # rendered preview used in README
```

The root `Makefile` delegates to every project directory (`make all`, `make previews`, or `make <dir>`).

## Design workflow

Every model goes through two stages:

### Stage 1 — Realization (`<name>.scad`)

Model the complete object as a solid, exactly as it would look assembled. This is the
concept reference. Use it to verify proportions and details. It is **not** intended for
printing directly — it exists so the geometry is clear before splitting.

### Stage 2 — Parts (`<name>_<part>.scad`)

Split the realization into individually printable flat pieces:

- **Walls** — one file per face (front, back, left, right), laid flat on the XY plane
- **Roof** — flat panel(s) with any surface texture
- **Floor / base slab** — if present
- **Small details** — steps, signs, vents, etc. grouped into one file if tiny

Rules for part files:
- Each part must lie flat on the build plate (Z = 0 is the bottom) so it can be sliced without rotation
- **Wall and roof panels are 1 mm thick** — rigid enough for H0 scale assembly, light, and fast to print
- Each part **defines a named module** (`module wall_front() { … }`) and then calls it at top level so the file renders standalone and the assembly can `use` it
- Parts must fit the printer envelope (220 × 220 × 250 mm)
- No cross-file dependencies — part files are self-contained except for the module export pattern above

### Stage 3 — Assembly (`<name>_assembly.scad`)

One file that `use`s all part files, then `translate`s / `rotate`s each module into its
correct assembled position. This is the only file allowed to have external references.
It is used for the GitHub 3D preview and README image — **not** for printing.

```openscad
use <model_wall_front.scad>
use <model_roof.scad>

wall_front();
translate([0, depth, wall_h]) rotate([90, 0, 0]) roof();
```

## File conventions

- **Source**: `.scad` files; realization and part files are self-contained (no `include`, no `use`, no external dependencies). Assembly files may `use <>` their own project's part files.
- **Output**: every `.scad` file has a matching `.stl` exported from OpenSCAD (`openscad -o output.stl input.scad`)
- **Naming**: `snake_case` — e.g. `station_wall_front.scad` / `station_wall_front.stl`

## Required header comment

Every `.scad` file **must** start with a comment block containing the English prompt that was used to generate it:

```
/*
 * PROMPT: <fixed English prompt that describes the object>
 */
```

Keep the prompt concise and precise. It must fully describe the object so the file can be regenerated from it alone.

## Printer

**Creality K1** — build volume: **220 × 220 × 250 mm** (X × Y × Z).
Design all models to fit within this envelope.

## Printability rules

Design for FDM printing without supports wherever possible:

- Overhangs ≤ 45° from vertical (or add a chamfer/fillet)
- Wall/roof panel thickness: **1 mm** (sufficient rigidity at H0 scale; slicer fills it with 2–3 perimeters)
- Minimum feature thickness for ribs, frames, lips: 1.2 mm (2 × 0.6 mm nozzle)
- Minimum feature size: 0.8 mm (anything smaller disappears at H0 scale anyway)
- Flat bottom face — orient the object so it sits naturally on the build plate
- No floating geometry, no zero-thickness walls, no coincident faces
- Avoid deep enclosed cavities that trap resin or prevent air escape

## Visual realism guidelines

- Surface detail matters more than structural accuracy
- Windows: recess them 0.5–1 mm into the wall — do not model glass
- Doors: same recess treatment, add a simple frame lip
- Roof tiles, brick courses, siding: use repeating `for` loops with slight offsets for texture
- Chimneys, gutters, window sills: include as separate `union()` additions, keep them thin but printable
- No interior detail — the realization file can be solid; part files are flat shells printed individually and assembled by hand

## README maintenance

`README.md` lists every design in **alphabetical order** by filename. After creating or significantly modifying a design, add or update its entry in `README.md`. Each entry must contain:

1. `###` heading with a human-readable name
2. One-paragraph description (what it is, key visual features, any parameters)
3. Parameter table if the design is parametric
4. `[![](<name>_assembly.png)](<name>_assembly.stl)` — rendered PNG linked to the assembly STL (GitHub shows an interactive 3D viewer)
5. A parts table listing every `.scad` source and its `.stl`, plus the assembly files

Insert the entry in alphabetical order by filename. Then commit all new/updated files and the updated `README.md` together.

## OpenSCAD style

- Use `$fn = 32` (or 64 for prominent round features) globally at the top of each file
- Prefer `linear_extrude`, `rotate_extrude`, and `hull()` over complex polyhedra
- Use named variables for all dimensions at the top of the file (after the prompt comment)
- Keep modules short and single-purpose
- No external libraries — stdlib only (`cube`, `cylinder`, `sphere`, `hull`, `minkowski`, etc.)
