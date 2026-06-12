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
  Makefile                 # per-project build rules (same template for every project)
  <model_name>.scad        # OpenSCAD source
  <model_name>.stl         # exported mesh
  <model_name>.png         # preview render
```

A multi-part design (e.g. `police_station_cs`) keeps all its parts in one directory:

```
police_station_cs/
  Makefile
  police_station_cs_building.scad / .stl
  police_station_cs_garage.scad   / .stl
  police_station_cs_parking.scad  / .stl
```

The root `Makefile` delegates to every project directory (`make all`, `make previews`, or `make <dir>`).

## File conventions

- **Source**: `.scad` files, one object per file, self-contained (no `include`, no `use`, no external dependencies)
- **Output**: `.stl` files exported from OpenSCAD (`openscad -o output.stl input.scad`)
- **Naming**: `snake_case` for both — e.g. `station_building.scad` / `station_building.stl`

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
- Minimum wall thickness: 1.2 mm (2 × 0.6 mm nozzle)
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
- No interior detail — buildings can be solid or have an open bottom shell (hollow box)

## README maintenance

`README.md` lists every design in **alphabetical order** by filename. After creating or significantly modifying a design, add or update its entry in `README.md`. Each entry must contain:

1. `###` heading with a human-readable name
2. One-paragraph description (what it is, key visual features, any parameters)
3. Parameter table if the design is parametric
4. `**[View 3D model →](file.stl)**` link (GitHub renders STL files as an interactive 3D viewer)
5. A two-row table with links to the `.scad` source and the `.stl` output

Insert the entry in alphabetical order by filename. Then commit both the new `.scad` / `.stl` and the updated `README.md` together.

## OpenSCAD style

- Use `$fn = 32` (or 64 for prominent round features) globally at the top of each file
- Prefer `linear_extrude`, `rotate_extrude`, and `hull()` over complex polyhedra
- Use named variables for all dimensions at the top of the file (after the prompt comment)
- Keep modules short and single-purpose
- No external libraries — stdlib only (`cube`, `cylinder`, `sphere`, `hull`, `minkowski`, etc.)
