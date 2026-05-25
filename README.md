# H0 Piko-like Diorama — OpenSCAD Models

3D printable models for an **H0 scale (1:87)** diorama. All objects are designed for visual realism on a layout — exteriors only, no interior detail. Sources are self-contained OpenSCAD files; outputs are STL files ready to slice.

Click any STL link to open GitHub's interactive 3D viewer.

---

## Models

### Eastern European Apartment Block

Prefabricated concrete panel apartment block ("blok"), typical of Eastern European post-war housing estates. Parametric: number of floors, building width, and depth are configurable at the top of the source file.

Features: flat roof with parapet, regular window grid on all facades, narrow stairwell windows on gable ends, horizontal and vertical concrete panel joint grooves, recessed ground-floor entrance with canopy.

| Parameter | Default | Note |
|-----------|---------|------|
| `floors` | 5 | number of floors |
| `bld_w_real` | 18000 mm | real-world building width |
| `bld_d_real` | 12000 mm | real-world building depth |

**[View 3D model →](ee_apartment_block.stl)**

| | File |
|-|------|
| OpenSCAD source | [ee_apartment_block.scad](ee_apartment_block.scad) |
| STL | [ee_apartment_block.stl](ee_apartment_block.stl) |

---

### Single Car Garage

Standalone single car garage with a gabled roof, four-section sectional door on the front facade, and a small window on the left side wall.

| Dimension | Real | H0 |
|-----------|------|----|
| Footprint | 3 m × 5.5 m | 34.5 × 63.2 mm |
| Eave height | 2.4 m | 27.6 mm |

**[View 3D model →](single_car_garage.stl)**

| | File |
|-|------|
| OpenSCAD source | [single_car_garage.scad](single_car_garage.scad) |
| STL | [single_car_garage.stl](single_car_garage.stl) |

---

### Sławojka (Polish Outdoor Toilet)

Traditional Polish outhouse, mandated across rural Poland in the 1930s by minister Składkowski — hence the name. A small wooden plank box with a gabled roof, sized for one person.

Features: vertical plank texture on all four walls, door panel with a traditional circular moon cutout, through-wall ventilation slot on the back wall near the top, small concrete entrance step.

| Dimension | Real | H0 |
|-----------|------|----|
| Footprint | 1.1 m × 1.1 m | 12.6 × 12.6 mm |
| Wall height | 2.0 m | 23.0 mm |

**[View 3D model →](slawojka.stl)**

| | File |
|-|------|
| OpenSCAD source | [slawojka.scad](slawojka.scad) |
| STL | [slawojka.stl](slawojka.stl) |

---

## Printing notes

- All models print flat on the build plate with no required supports
- Recommended nozzle: 0.4 mm; minimum layer height: 0.1 mm
- Scale: 1:87 — do **not** resize in the slicer
