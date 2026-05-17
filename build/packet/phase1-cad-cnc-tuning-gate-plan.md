# Phase 1 CAD/CNC/Tuning Gate Packet (Issue #4)

Status: L2 packet scaffold for prototype planning.

This packet maps the phase-1 Small_Baseline_6T CAD geometry to explicit shop and tuning gates. It preserves prototype readiness by separating planning rows from fabrication authority.

## Scope and non-claims

- Phase-1 scope is the magazine-baseline small drum only (`Small_Baseline_6T` config).
- Medium/large designs remain future work and are not used for fabrication gates in this lane.
- No file added here is treated as build-ready CAD/CNC authority.
- Geometry rows are named and traceable, but cutting dimensions remain **gated** until shop and tuning evidence are completed.

## Phase-1 CAD authority map

- `build/cad/phase1-dimensions-map.csv` records the Small_Baseline_6T geometry rows used for review.
- `build/packet/phase1-geometry-gates.csv` records per-feature control gates.
- `build/packet/visual-output-register.csv` tracks artifact authority intent.
- `build/packet/validation-loop.csv` tracks status of CAD/CNC/tuning gates.

## Preserved prototype readiness rules

1. Keep the prototype path open: no closed-loop release is inferred from CAD placeholders.
2. Require evidence rows before moving from review to release-level execution.
3. Use captured shop gates as the bridge from `reference_only` CAD/CAD/CNC planning to controlled prototype cuts.
4. Add measured tuning evidence before declaring any tuned geometry authoritative.

## Required gate rows (live)

- CAD: geometry table values from `cad/TNG-000_TongueDrum_ALL_CONFIGS_dimensions.csv` are listed in `phase1-dimensions-map.csv`.
- CNC: shop/fixture/gauge gates live in `build/cnc/phase1-cnc-gates.csv`.
- Tuning: measured capture rows in `phase1-tuning-capture.csv` are seeded from `docs/study/data-template.csv` and remain open.

## Readiness boundary

This packet remains L2-style evidence scaffolding until the following are true:

- Every open CAD gate in `validation-loop.csv` is complete or closed with evidence.
- `build/packet/phase1-tuning-capture.csv` includes post-cut measurement data for at least the phase-1 target tongue set.
- `build/cnc/phase1-cnc-gates.csv` records fixture/workholding and bit-compensation passes.
- `validation.csv` reflects no unchecked fabrication claims.

## Update plan

### Immediate next steps

1. Fill `build/packet/phase1-tuning-capture.csv` from live strike logs.
2. Complete `build/cnc/phase1-cnc-gates.csv` with kerf/workholding/first-article actions.
3. Promote one reviewed CAD/CNC sheet/row into a future fabrication-authority register only after all `phase-1` gates pass.
4. Keep `validation.csv` and `validation-loop.csv` as the governing state surface.
