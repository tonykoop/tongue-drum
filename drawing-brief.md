# Instrument Drawing Brief

Instrument: Tongue drum
Instrument ID: TNG-001
Variant/size: Small (magazine baseline)
Key/scale: D minor / A minor
Revision/date: REV-A / 2026-05-02
Units: inches unless noted
Scale: TBD
Source workbook/CAD/catalog ID: TBD / CAD-TONGUE-12

## Required Views

- Plan:
- Side/front:
- Section:
- Detail:
- Exploded/BOM:
- Ergonomic/player:

## Technical Product Sketch

Use a technical-leaning concept sketch when the design needs a fast shared picture of scale, resources, size, character, material choices, and interaction. It may combine a hero 3D view, small orthographic insets, material swatches, callout labels, a simple scale figure/hand reference, and resource/BOM badges.

Rules:

- Use only known dimensions from the design sheet or mark values as `TBD`.
- Include scale cues, but do not infer final geometry from the sketch.
- Show material intent clearly: wood species, metal, skin/head, strings, ceramic, finish, or hardware.
- Prefer clean information-board layouts for communication: engineering poster, magazine-style explainer, reference sheet, or storyboard/process board.
- Keep build-critical geometry in vector/CAD drawings.

## Critical Dimensions

| Feature | Dimension | Tolerance | Source | Notes |
| --- | ---: | --- | --- | --- |
| Overall envelope | TBD | TBD | Design sheet/CAD |  |
| Primary datum/centerline | TBD | TBD | CAD |  |
| Tuning-critical geometry | TBD | TBD | Formula/measurement |  |
| Workholding datum | TBD | TBD | CNC setup |  |

## Materials And Finish

| Part | Material/spec | Grain/orientation | Finish | Notes |
| --- | --- | --- | --- | --- |
| Primary structure | Steel or hardwood top | TBD | TBD |  |
| Sound-producing element | TBD | TBD | TBD |  |
| Hardware/fixtures | TBD | N/A | TBD |  |

## Manufacturing Notes

- Stock:
- Workholding:
- Tooling:
- Operation sequence:
- Kerf/bit-radius compensation:
- Trim/tuning allowance:

## Design Sheet Context

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

## Assumptions / TBDs

-
