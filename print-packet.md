# Tongue Drum Capstone (TNG-001) Print Packet

Generated: 2026-05-02
Packet folder: `/sessions/busy-sleepy-volta/mnt/Career/instrument-maker-v2/build-packets/2026-05-02-tng-001-tongue-drum`

## File Map

| File | Purpose |
| --- | --- |
| `design.md` | Project intent, catalog metadata, assumptions, and validation plan. |
| `bom.csv` | Starter bill of materials with part categories, quantities, drawing refs, and notes. |
| `sourcing.csv` | Supplier/search tracker with specs, price/date fields, lead time, substitutes, and risks. |
| `cut-list.csv` | Rough/final stock sizes, material, grain/orientation, operations, yield, and offcuts. |
| `drawing-brief.md` | Manufacturing drawing and technical product sketch brief. |
| `assembly-manual.md` | Shop-facing sequence, tools, fixtures, safety, tuning, finishing, and maintenance notes. |
| `validation.csv` | Target/measured values, tolerance, environment, result, and tuning/build action log. |
| `supplier-rfq.md` | Supplier email/request-for-quote starter. |
| `visual-bom-brief.md` | Art direction for an image-forward visual BOM. |
| `wolfram-starter.wl` | Wolfram starter for physics, optimization, visualization, and validation. |

<div class="page-break"></div>

## design.md

Project intent, catalog metadata, assumptions, and validation plan.

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

<div class="page-break"></div>

## bom.csv

Starter bill of materials with part categories, quantities, drawing refs, and notes.

| Item # | Subsystem | Part / Material | Qty | Dimensions / Spec | Material | Make / Buy | Source / Supplier | Estimated Unit Cost | Extended Cost | Drawing Ref | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | Primary structure | Tongue drum body/shell/blank | 1 | Small (magazine baseline) | Steel or hardwood top | Make | TBD |  | 75 | drawings/primary-structure.pdf | Populate from design sheet and CAD model. |
| 2 | Sound system | Sound-producing element set | 1 set | D minor / A minor | TBD | Make/Buy | TBD |  |  | drawings/tongue-layout.pdf | Tongue/slot layout, kerf, bridge geometry, resonator, tuning trim, and strike zones. |
| 3 | Hardware | Hardware and fasteners | 1 set | TBD | TBD | Buy | TBD |  |  | drawings/hardware-layout.pdf | Bridge, tuning hardware, straps, pins, screws, jacks, or lacing as applicable. |
| 4 | Fixtures | Jigs, templates, and workholding | 1 set | TBD | MDF/acrylic/plywood or shop stock | Make | Shop |  |  | drawings/fixtures.pdf | Registration pins, laser templates, CNC spoilboard, bending forms, or lathe supports. |
| 5 | Finish | Finish and consumables | 1 set | TBD | Oil/wax/lacquer/adhesive/abrasives | Buy | TBD |  |  | drawings/finish-notes.md | Confirm finish is compatible with skin contact, food safety, reeds, strings, or glue. |
| 6 | Validation | Measurement and tuning supplies | 1 set | Tuner, mic, calipers, hygrometer, test fixture | TBD | Buy/Use | Shop/lab |  |  | data/measurements.csv | Record target frequency, measured frequency, cents error, humidity, and notes. |

<div class="page-break"></div>

## sourcing.csv

Supplier/search tracker with specs, price/date fields, lead time, substitutes, and risks.

| Item # | Category | Component | Required Spec | Qty Estimate | Unit | Search Terms | Supplier Candidate | Current Unit Price | Date Checked | Lead Time | Acceptable Substitutes | Risk / Notes | Status |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | Primary material | Main body/shell/blank stock | Small (magazine baseline) | TBD | ea/bd ft/sheet | Tongue drum Steel or hardwood top stock lumber blank shell | TBD |  |  |  | Equivalent material with matching acoustic, structural, and machining requirements. | Confirm dimensions, grade, moisture, defects, and shipping size. | Needs sourcing |
| 2 | Hardware | Instrument-specific hardware set | TBD from drawing and assembly method | 1 | set | Tongue drum hardware parts kit | TBD |  |  |  | Compatible hardware with same critical dimensions. | Do not buy until drawings identify hole spacing, thread, and clearances. | Needs sourcing |
| 3 | Consumables | Adhesives, abrasives, finish, and shop supplies | Skin/contact-safe finish where applicable | 1 | set | instrument finish adhesive sandpaper wax oil lacquer | TBD |  |  |  | Equivalent finish compatible with material and player contact. | Confirm finish does not inhibit tuning, glue, reeds, or skin contact. | Needs sourcing |
| 4 | Validation | Measurement and tuning tools | Tuner, microphone, calipers, hygrometer, scale | 1 | set | instrument tuner measurement microphone calipers hygrometer | Shop/lab |  |  |  | Existing shop tools acceptable if calibrated enough for the task. | Record tool/model in validation notes. | Check inventory |
| 5 | Sound plate | Tongue plate or soundboard | Material, thickness, kerf, tuning allowance | TBD | TBD | steel tongue drum blank hardwood tongue drum soundboard | TBD |  |  |  | TBD after spec review | Frequency depends strongly on thickness, slot geometry, and material batch. | Needs sourcing |
| 6 | Resonator | Box, shell, or resonant body stock | Envelope, wall thickness, port/cavity requirements | TBD | TBD | tongue drum resonator box hardwood shell steel shell | TBD |  |  |  | TBD after spec review | Confirm coupling and access before final glue/weld. | Needs sourcing |
| 7 | Shop service | Laser/CNC cutting or routing | Kerf, minimum slot width, tab/fixture method | TBD | TBD | laser cut steel tongue drum CNC route tongue slots | TBD |  |  |  | TBD after spec review | Cut quality affects tuning and crack initiation. | Needs sourcing |
| 8 | Accessories | Feet, mallets, pads, or dampers | Hardness, contact-safe material, size | TBD | TBD | rubber feet mallets tongue drum pads dampers | TBD |  |  |  | TBD after spec review | Small accessories affect sustain, rattle, and player experience. | Needs sourcing |

<div class="page-break"></div>

## cut-list.csv

Rough/final stock sizes, material, grain/orientation, operations, yield, and offcuts.

| Part # | Part Name | Qty | Finished Dimensions | Rough Stock Dimensions | Material | Grain / Orientation | Source Formula / Drawing | Operation | Yield / Board Ft / Sheet Use | Offcut Notes | Status |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | Primary blank or shell stock | 1 | Small (magazine baseline) | TBD plus workholding/tuning allowance | Steel or hardwood top | TBD | Design sheet and drawing-brief.md | Cut to rough size, flatten/square, mark datum | TBD | Reserve offcuts for test cuts and tuning coupons. | Needs dimensions |
| 2 | Fixture or template stock | 1 set | TBD | TBD | MDF, acrylic, plywood, or shop stock | N/A | drawing-brief.md and CAD/CNC setup | Laser/CNC/drill fixture components | TBD | Use offcuts when registration accuracy is not compromised. | Needs fixture design |
| 3 | Test coupons | TBD | Representative tuning/material samples | TBD | Steel or hardwood top | Match production orientation | validation.csv | Cut before final part when tuning or finish risk exists | TBD | Keep labeled with material batch and orientation. | Recommended |

<div class="page-break"></div>

## drawing-brief.md

Manufacturing drawing and technical product sketch brief.

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

<div class="page-break"></div>

## assembly-manual.md

Shop-facing sequence, tools, fixtures, safety, tuning, finishing, and maintenance notes.

# Assembly Manual

Instrument ID: TNG-001
Instrument: Tongue drum
Revision/date: REV-A / 2026-05-02

## Before You Start

- Confirm `design.md`, `bom.csv`, `sourcing.csv`, `cut-list.csv`, `drawing-brief.md`, and `validation.csv` agree.
- Confirm all purchased hardware dimensions against drawings before cutting irreversible features.
- Photograph each major setup and save images in `images/`.

## Tools And Fixtures

- CNC / laser / lathe / hand tools:
- Measuring tools:
- Workholding and fixtures:
- Safety equipment:

## Build Phases

1. Source and inspect materials.
2. Prepare rough stock and test coupons.
3. Build fixtures/templates and verify datums.
4. Machine or form primary parts.
5. Dry fit hardware and sound-producing elements.
6. Assemble with reversible checks where possible.
7. Tune, trim, tension, or adjust.
8. Finish, cure, and re-check tuning/fit.
9. Document final measurements and build notes.

## Photo / Diagram Placeholders

- `images/01-materials.jpg`
- `images/02-fixture-setup.jpg`
- `images/03-machining.jpg`
- `images/04-dry-fit.jpg`
- `images/05-assembly.jpg`
- `images/06-validation.jpg`

## Maintenance / Setup Notes

- Tuning/setup:
- Seasonal humidity/temperature notes:
- Replaceable wear parts:
- Storage and transport:

<div class="page-break"></div>

## validation.csv

Target/measured values, tolerance, environment, result, and tuning/build action log.

| Check # | Feature / Test | Target | Unit | Tolerance | Source | Measured 1 | Measured 2 | Measured 3 | Environment | Result | Action / Notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | A4 frequency reference | 440 | Hz | Exact formula sanity check | acoustic-models.md |  |  |  | TBD |  |  |
| 2 | Overall envelope | Small (magazine baseline) | in | TBD | drawing-brief.md |  |  |  | TBD |  |  |
| 3 | Tongue drum tuning targets | D minor / A minor | Hz/cents | TBD | design sheet |  |  |  | Temp/humidity TBD |  |  |
| 4 | Critical fit hardware | All purchased/made parts fit | pass/fail | No forced fit | bom.csv and drawings |  |  |  | Shop |  |  |
| 5 | Finish and contact safety | Compatible with use | pass/fail | No tack/odor/skin issue | sourcing.csv |  |  |  | Shop |  |  |

<div class="page-break"></div>

## supplier-rfq.md

Supplier email/request-for-quote starter.

# Supplier RFQ Draft

Subject: RFQ for Tongue drum prototype components - TNG-001

Hello,

I am sourcing components for a musical-instrument prototype:

- Instrument: Tongue drum
- Variant/size: Small (magazine baseline)
- Key/scale: D minor / A minor
- Primary material: Steel or hardwood top

Could you quote the items listed in `sourcing.csv` or recommend compatible alternatives?

Please include:

- Unit price and any volume breaks
- Minimum order quantity
- Current stock status
- Lead time
- Shipping estimate to my location
- Material/spec sheet or drawing if available
- Notes on acceptable substitutions or constraints

Thank you,

Tony

<div class="page-break"></div>

## visual-bom-brief.md

Art direction for an image-forward visual BOM.

# Visual BOM Brief

Instrument ID: TNG-001
Instrument: Tongue drum
Revision/date: REV-A / 2026-05-02

## Reference Style

Use Tony's Ashiko visual BOM as the preferred pattern:

```text
C:/Users/Tony/Documents/GitHub/ashiko-drum-workshop/images/figure-bom-v2.png
/mnt/c/Users/Tony/Documents/GitHub/ashiko-drum-workshop/images/figure-bom-v2.png
```

## Layout

- Header: assembly name, quote date, estimated cost, revision.
- Hero image: finished assembly or best current render/photo.
- Main table columns: Part #, Part Name, Description, Qty, Units, Picture, Cost Each, Total.
- Alternating row fills for readability.
- Bottom notes: supplier assumptions, material species, discounts, substitutions, and TBDs.

## Image Rules

- Prefer real part photos, supplier images, CAD renders, or shop photos.
- Generated part images are allowed as placeholders, but label them as concept/placeholder.
- Keep image thumbnails consistent in crop and scale where possible.
- Do not infer dimensions from generated images.

## Needed Images

- Finished assembly / hero:
- Primary material:
- Sound-producing elements:
- Hardware:
- Rope/lacing/strings/reeds/skin/head:
- Finish/consumables:
- Fixtures/templates:

## Output Targets

- `images/visual-bom.png`
- `images/visual-bom.pdf`
- Source workbook/sheet or editable design file:

<div class="page-break"></div>

## wolfram-starter.wl

Wolfram starter for physics, optimization, visualization, and validation.

```wolfram
(* Instrument-maker build-packet Wolfram starter. *)

ClearAll["Global`*"];

design = <|
  "InstrumentID" -> "TNG-001",
  "Family" -> "Drums",
  "InstrumentType" -> "Tongue drum",
  "VariantSize" -> "Small (magazine baseline)",
  "KeyScale" -> "D minor / A minor",
  "PrimaryMaterial" -> "Steel or hardwood top",
  "DesignSheet" -> "Tongue Drum",
  "DesignWorkbook" -> "/sessions/busy-sleepy-volta/mnt/Career/flutes-staging/Flutes-AI.xlsx",
  "Units" -> "Imperial",
  "A4" -> 440,
  "SpeedOfSoundInPerSec" -> 13552
|>;

frequencyFromMidi[midi_, a4_: 440] := a4*2^((midi - 69)/12);
centsError[measured_, target_] := 1200*Log2[measured/target];
openPipeLengthIn[freq_, c_: 13552, radius_: 0] := c/(2*freq) - 2*0.6*radius;
stoppedPipeLengthIn[freq_, c_: 13552, radius_: 0] := c/(4*freq) - 0.6*radius;
cantileverLengthIn[freq_, thickness_, k_] := Sqrt[k*thickness/freq];

CreateDocument[
  {
    TextCell[design["InstrumentID"] <> " - " <> design["InstrumentType"], "Title"],
    TextCell["Build-packet computational design notebook", "Subtitle"],
    ExpressionCell[design, "Input"],
    TextCell["Add imported design rows, Manipulate controls, plots, audio, 3D geometry, and validation cells below.", "Text"]
  },
  WindowTitle -> design["InstrumentID"]
]
```
