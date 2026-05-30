# Phase 1 CAD/CNC/Tuning Gate Packet

Status: L2 V5 build-packet candidate.

Issue scope: Refs #4.

This packet defines the Phase-1 gate surface for the small tongue-drum
prototype. It does not publish CAD geometry, DXF coordinates, toolpaths,
measured dimensions, or tuning frequencies. Every CAD, CNC, and acoustic row is
either a gate definition or a pending-measurement placeholder.

## Authority Boundary

- No artifact in this lane is fabrication authority.
- Existing CAD files and workbook references are inventory sources only until a
  human review or measurement pass promotes a specific row.
- Existing photos are reference-only and cannot be used to infer dimensions.
- Tuning rows define what evidence must be captured; they do not name target
  notes, target frequencies, measured frequencies, or correction values.
- Wolfram files are source-only stubs and have not been executed.
- No MCP, SolidWorks, OpenSCAD, Illustrator, Blender, CNC, or measurement tool
  was available in this run.

## V5 Surface

| Surface | File | Authority |
| --- | --- | --- |
| Packet status and artifact inventory | `build/packet/README.md` | concept_only |
| Visual/output authority register | `build/packet/visual-output-register.csv` | pending_measurement |
| CAD feature gate definitions | `build/packet/phase1-geometry-gates.csv` | pending_measurement |
| CAD measurement map | `build/cad/phase1-dimensions-map.csv` | pending_measurement |
| CNC readiness gates | `build/cnc/phase1-cnc-gates.csv` | pending_measurement |
| Tuning capture gates | `build/packet/phase1-tuning-capture.csv` | pending_measurement |
| Validation state | `build/packet/validation.csv` and `build/packet/validation-loop.csv` | pending_measurement |
| MCP/tool provenance stub | `build/cad/cad-mcp-session-log.md` | concept_only |

## Gate Families

### CAD Gates

CAD gates define which feature classes must be checked before a geometry row
can be trusted:

- envelope and datums;
- material thickness and top/shell interface;
- slit width, end radius, and root gap;
- tongue length, width, tip shape, and relief geometry;
- drawing-to-CAD-to-shop traceability;
- revision and configuration identity.

The gate passes only when a specific source row is reviewed or measured and the
reviewer records units, tolerance, source artifact, and evidence path.

### CNC Gates

CNC gates define shop evidence required before any cutting claim:

- stock and material-batch identification;
- fixture and datum plan;
- cutter/kerf compensation;
- coupon and first-article cut;
- tab, bridge, edge-finish, and tearout checks;
- repeatability and scrap/stop rules.

The gate passes only when the shop records fixture evidence and post-cut checks.

### Tuning Gates

Tuning gates define the measurement loop required before any acoustic authority:

- target system selection;
- strike protocol;
- microphone or tuner setup;
- environment capture;
- as-cut measurement;
- trim-pass measurement;
- cents-error calculation;
- model update or deviation note.

The gate passes only when the packet includes real strike logs and links each
result back to a specific tongue, material batch, and geometry revision.

## What Is Needed Next

1. Review the existing CAD/workbook source rows and decide which configuration
   represents the Phase-1 small drum.
2. Populate `phase1-dimensions-map.csv` with measured or reviewed values only.
3. Complete CNC coupon and first-article gates before any slot geometry release.
4. Capture real tuning data after cutting; then add target and measured values
   with evidence paths.
5. Promote individual rows to `fabrication` or `derived_preview` only after the
   evidence chain exists.
