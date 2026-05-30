# TNG-001 Tongue Drum Design Surface

Status: L2 V5 build-packet candidate.

Authority: concept-only for design intent; pending measurement for CAD/CNC and
tuning claims.

## Intent

Create an honest V5 packet surface for the Phase-1 small tongue drum. The
packet preserves the planned CAD/CNC/tuning workflow but does not publish
fabrication geometry, DXF coordinates, tuning frequencies, measured dimensions,
or correction factors.

## Phase-1 Scope

- Instrument family: idiophone / tongue drum.
- Prototype scope: small Phase-1 build only.
- Current packet authority: gate definitions and evidence checklist.
- Excluded from this lane: medium/large design authority, toolpaths, final
  tongue layout, tuning targets, measured pitch logs, and build-ready drawings.

## Design Authority Boundaries

| Area | Current state | Required promotion evidence |
| --- | --- | --- |
| CAD configuration | pending_measurement | Reviewed file path, revision, configuration, and units. |
| Envelope and datums | pending_measurement | Reviewed dimension table or measured template. |
| Tongue geometry | pending_measurement | One reviewed row per tongue ID, linked to material and revision. |
| CNC setup | pending_measurement | Fixture plan, cutter/kerf coupon, and first-article evidence. |
| Tuning model | pending_measurement | Target system, strike protocol, measurement setup, and real strike logs. |
| Visual references | reference_only or concept_only | Reviewed drawing or measured template before any dimensional use. |
| Wolfram/runtime work | concept_only | Execution log and exported results before computational claims. |

## Required Packet Files

- `README.md`
- `design.md`
- `bom.csv`
- `sourcing.csv`
- `cut-list.csv`
- `validation.csv`
- `risks.md`
- `drawing-brief.md`
- `photo-shotlist.md`
- `visual-output-register.csv`
- `phase1-cad-cnc-tuning-gate-plan.md`
- `phase1-geometry-gates.csv`
- `phase1-tuning-capture.csv`
- `../cad/phase1-dimensions-map.csv`
- `../cad/cad-mcp-session-log.md`
- `../cnc/phase1-cnc-gates.csv`

## Validation Plan

1. Close CAD configuration and revision gates.
2. Populate dimension rows only from reviewed CAD, measured templates, or
   physical build measurements.
3. Close CNC fixture, cutter, coupon, and first-article gates.
4. Capture real as-cut and post-trim tuning data.
5. Promote artifacts one at a time in `visual-output-register.csv`.

## Non-Claims

- This packet is not L3/build-ready.
- This packet does not claim any target notes or target frequencies.
- This packet does not claim any measured pitch, cents error, or tuning
  correction.
- This packet does not provide CAD geometry, DXF coordinates, or CAM toolpaths.
- This packet does not certify any existing photo as dimensional evidence.
