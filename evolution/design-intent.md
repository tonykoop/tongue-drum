# Design Intent — tongue-drum rev A

- Master CAD: `cad/TNG-000_TongueDrum.SLDASM` (sha256: 59df7300ef5db4454bb3a1fa6add57f762f1d1f5fc28645526a7674bdc8ae13b), master layout `cad/TNG-000_MasterLayout.SLDPRT` (sha256: bf650e80537b9d0641c39c58863385959014c2ceabe5374a4185dd70297b8eb4); design table `tongue-drum-design-table.xlsx` (sha256: 04353e6e4690d7a39c4508882160bf786c2a7c925d54ac774d75ffbe95b9e6aa).
- Function: Small Phase-1 tongue drum (idiophone). Struck steel/metal tongues cut into a resonating vessel produce pitched tones. **This intake preserves the packet's honesty boundary:** per `build/packet/design.md`, the Phase-1 surface deliberately makes NO claim of target notes, target frequencies, tongue layout, or CAD geometry — those remain gated behind measurement.
- Environment: indoor idiophone; tongues are struck cantilevers. Steel grade, cut process (kerf/HAZ), and final trim set pitch — all measurement-gated.
- Target qty: 1 (Phase-1 prototype). Deadline: TBD. Budget/unit ceiling: TBD.

## Critical dimensions (carry tolerances)

All function-critical geometry is intentionally `pending_measurement` in this packet
(design.md Design Authority Boundaries). No numeric values are asserted here.

| Feature | Nominal | Tolerance | Why critical | Source |
| --- | --- | --- | --- | --- |
| CAD configuration | TBD (pending_measurement) | reviewed file/rev/config/units | authority to read any dimension | design.md Authority Boundaries |
| Envelope and datums | TBD (pending_measurement) | reviewed dimension table / measured template | shell fit + resonance | design.md Authority Boundaries |
| Tongue geometry | TBD (pending_measurement) | one reviewed row per tongue ID | pitch (excluded this lane) | design.md Authority Boundaries / Non-Claims |
| CNC setup / kerf | TBD (pending_measurement) | fixture + cutter/kerf coupon + first-article | cut fidelity, crack risk | design.md Authority Boundaries |
| Tuning model | TBD (pending_measurement) | strike protocol + measured strike logs | final pitch | design.md Authority Boundaries |

## Incidental (free for DFM)

- None asserted — the packet does not publish dimensional or cosmetic geometry at this stage.

## Must-nots (DFM may never violate)

- Do NOT promote any artifact to fabrication authority without a reviewed CAD source / measured template cited in the authority register (cad/mcp-session-log.md Promotion Rule).
- Do NOT publish target notes, target frequencies, tongue layout, DXF coordinates, or CAM toolpaths from this packet — they are explicit Non-Claims (design.md).
- Do NOT copy/interpret values out of the existing SolidWorks assembly or workbook without a reviewed extraction logged in the register.

## Material intent

- Preferred: per `build/packet/bom.csv` / `sourcing.csv` (steel tongue-drum stock; spec-first, unverified prices).
- Forbidden: treating any existing reference photo as dimensional evidence (register R6-V5-008 reference_only).

## Stage status

Stage 0 intake complete 2026-07-01. Gate A (Alpha shop compile) NOT yet run. The SolidWorks assembly remains the un-promoted CAD master of record; no OpenSCAD master was authored because the design surface withholds tongue geometry (authoring would fabricate excluded dimensions). Nothing presented as shippable.
