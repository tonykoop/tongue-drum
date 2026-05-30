# TNG-001 Tongue Drum V5 Packet

Status: L2 V5 build-packet candidate.

Authority: pending measurement. This packet is not build-ready and contains no
fabrication CAD, DXF coordinates, CNC toolpaths, measured dimensions, target
tuning frequencies, measured tuning frequencies, or validated correction
factors.

## Purpose

This packet turns issue #4 into an honest V5 surface for the Phase-1 tongue drum
prototype. The work here defines the gates that must be closed before future
CAD/CNC/tuning values can be trusted.

## Included Surfaces

- `design.md` - concept and authority boundary.
- `phase1-cad-cnc-tuning-gate-plan.md` - CAD/CNC/tuning gate overview.
- `phase1-geometry-gates.csv` - CAD gate definitions.
- `../cad/phase1-dimensions-map.csv` - feature classes that need review or
  measurement before values are accepted.
- `../cnc/phase1-cnc-gates.csv` - CNC/shop gate definitions.
- `phase1-tuning-capture.csv` - tuning capture gate definitions.
- `visual-output-register.csv` - artifact authority register.
- `validation.csv` and `validation-loop.csv` - open validation state.
- `risks.md` - blockers that prevent L3 promotion.
- `photo-shotlist.md` - future evidence-photo plan.

## Promotion Rules

- Promote a row to `fabrication` only after reviewed CAD, measured template,
  DXF source, design-table parameter, or physical build measurement evidence is
  committed.
- Promote a row to `derived_preview` only when it cites a controlling
  fabrication source.
- Keep generated or explanatory visuals at `concept_only`.
- Keep source photos at `reference_only`.
- Keep all Phase-1 geometry and tuning claims at `pending_measurement` until
  the measurement loop is complete.

## What Is Needed Next

1. Review the exact Phase-1 CAD/workbook configuration.
2. Fill the dimension map from reviewed or measured evidence only.
3. Run CNC coupon and first-article checks before any slot release.
4. Capture real strike data before entering target or measured frequencies.
5. Update the authority register one artifact at a time as evidence lands.
