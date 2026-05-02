# TNG-001 - Tongue drum

Generated: 2026-05-02

## Intent

Create a traceable build packet for `TNG-001` that connects the master catalog row, design sheet, BOM, sourcing, stock prep, validation, assembly, drawing brief, visual BOM brief, Wolfram starter, and CAD/CNC placeholder paths.

## Master Catalog Row

| Field | Value |
| --- | --- |
| Instrument ID | TNG-001 |
| Family | Drums |
| Instrument Type | Tongue drum |
| Variant/Size | Small (magazine baseline) |
| Key/Scale | D minor / A minor |
| Design Stage | Research |
| Build Status | Idea |
| Priority | High |
| CAD Design ID | CAD-TONGUE-12 |
| CNC Plan ID | CNC-TONGUE-12 |
| Primary Material | Steel or hardwood top |
| Target Price | 180 |
| Estimated Cost | 75 |
| Estimated Margin | =IF(OR(M5="",N5=""),"",M5-N5) |
| Maker Nexus Tool | Maker Nexus laser or CNC router |
| Next Step | Decide steel vs hardwood tongue approach; define tuning cuts |
| Notes | Six-tongue paired-slit design from WOOD magazine Oct 2008. Phase 1 of the key-tuning DoE study. |
| GitHub Repo | https://github.com/tonykoop/tongue-drum |

## Design Sheet Summary

- Workbook: `/sessions/busy-sleepy-volta/mnt/Career/flutes-staging/Flutes-AI.xlsx`
- Sheet: `Tongue Drum`
- Used range: `A1:W92`
- Cells/formulas/blue inputs: `514` / `222` / `52`
- Formula examples:
  - `J8`: `=SQRT($B$18*J5/(440*2^((62-69)/12)))`
  - `K8`: `=J8*25.4`
  - `N8`: `=SQRT($B$18*N5/(440*2^((55-69)/12)))`
  - `O8`: `=N8*25.4`
  - `R8`: `=SQRT($B$18*R5/(440*2^((48-69)/12)))`
  - `S8`: `=R8*25.4`
  - `J9`: `=SQRT($B$18*J5/(440*2^((64-69)/12)))`
  - `N9`: `=SQRT($B$18*N5/(440*2^((57-69)/12)))`
  - `R9`: `=SQRT($B$18*R5/(440*2^((50-69)/12)))`
  - `J10`: `=SQRT($B$18*J5/(440*2^((65-69)/12)))`
  - `N10`: `=SQRT($B$18*N5/(440*2^((59-69)/12)))`
  - `R10`: `=SQRT($B$18*R5/(440*2^((52-69)/12)))`
- First non-empty rows:
  - Row 1: Slit-Tongue Drum — CNC Design & DOE Protocol | THREE DRUM DESIGNS
  - Row 2: Cantilever Beam Model: f = K × t / L²  ·  tonykoop/tongue-drum
  - Row 3: SMALL (Magazine Baseline)
  - Row 4: MATERIAL LIBRARY | 6"×9" box, 1/4" top, 8 tongues
  - Row 5: Wood Species | E (GPa) | ρ (kg/m³) | K (imperial) | Color | Tonewoood Rating | Thickness: | 0.25
  - Row 6: Padauk | 11 | 745 | 24438 | Red-Orange | ★★★★★
  - Row 7: Wenge | 15.8 | 870 | 27103 | Dark Brown | ★★★★★ | Note | Length (in)
  - Row 8: Hard Maple | 12.6 | 705 | 26887 | Cream | ★★★★ | D4 | =SQRT($B$18*J5/(440*2^((62-69)/12)))
  - Row 9: Cherry | 10.3 | 560 | 27275 | Pink-Brown | ★★★★ | E4 | =SQRT($B$18*J5/(440*2^((64-69)/12)))
  - Row 10: Black Walnut | 11.6 | 610 | 27734 | Dark Brown | ★★★★ | F4 | =SQRT($B$18*J5/(440*2^((65-69)/12)))
  - Row 11: White Oak | 12.3 | 770 | 25419 | Tan | ★★★ | G4 | =SQRT($B$18*J5/(440*2^((67-69)/12)))
  - Row 12: Baltic Birch Ply | 10 | 680 | 24389 | Light Tan | ★★★ | A4 | =SQRT($B$18*J5/(440*2^((69-69)/12)))
  - Row 13: Mahogany | 10.1 | 590 | 26314 | Reddish | ★★★★ | B4 | =SQRT($B$18*J5/(440*2^((71-69)/12)))
  - Row 14: Western Red Cedar | 7.7 | 370 | 29013 | Red | ★★★ | C5 | =SQRT($B$18*J5/(440*2^((72-69)/12)))

## Engineering Assumptions To Resolve

- Confirm which dimensions come from formulas, measured builds, supplier drawings, or concept estimates.
- Confirm units, tuning standard, material batch, workholding strategy, and machine envelope.
- Add empirical correction factors or validation measurements before final machining.
- Mark any generated product sketches as communication artifacts unless dimensions are also backed by this packet.

## Build Package Inventory

- `design.md`: design intent, catalog metadata, assumptions, and validation plan.
- `bom.csv`: starter bill of materials with drawing references.
- `sourcing.csv`: supplier/search-term tracker with price/date/lead-time fields.
- `cut-list.csv`: stock, rough/final dimensions, yield, and offcut planning.
- `validation.csv`: target/measured values, environment, result, and action log.
- `assembly-manual.md`: phased build manual with photo placeholders.
- `supplier-rfq.md`: supplier request-for-quote draft.
- `visual-bom-brief.md`: image-forward BOM brief based on Tony's Ashiko BOM style.
- `drawing-brief.md`: manufacturing drawing and technical product sketch brief.
- `wolfram-starter.wl`: Wolfram Language starter for physics, optimization, and visualization.
- `cad/`: placeholder for CAD models and design tables.
- `cnc/`: placeholder for CAM, toolpaths, and setup sheets.
- `drawings/`: placeholder for PDFs, SVGs, DXFs, and drawing exports.
- `images/`: placeholder for product sketches, BOM plates, ergonomic views, and renderings.
- `data/`: placeholder for measurements, tuning validation, and DoE logs.

## Placeholder Paths

```text
build-packets/2026-05-02-tng-001-tongue-drum/cad/
build-packets/2026-05-02-tng-001-tongue-drum/cnc/
build-packets/2026-05-02-tng-001-tongue-drum/drawings/
build-packets/2026-05-02-tng-001-tongue-drum/images/
build-packets/2026-05-02-tng-001-tongue-drum/data/
```

## Validation Plan

- Physics sanity check:
- Critical dimensions checked against design sheet:
- CNC/laser/lathe work envelope check:
- Material and structural check:
- Ergonomic/player check:
- Tuning measurement plan:
- Build photos and revision notes:
