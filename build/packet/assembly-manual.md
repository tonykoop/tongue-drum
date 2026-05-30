# Assembly Manual

Status: L2 gate scaffold only.

This is not a build-ready assembly manual. It lists the evidence gates that
must close before irreversible shop work.

## Before Any Build Step

- Confirm `README.md`, `design.md`, `bom.csv`, `sourcing.csv`, `cut-list.csv`,
  `drawing-brief.md`, and `validation.csv` agree on pending-measurement
  authority.
- Confirm no CAD, DXF, CAM, dimension, or tuning value is being used without
  reviewed or measured evidence.
- Photograph future setup evidence according to `photo-shotlist.md`.

## Gate Phases

1. Review Phase-1 CAD/workbook configuration.
2. Record material and stock evidence.
3. Define and document fixture datums.
4. Cut and measure same-material coupons.
5. Run first-article or sacrificial slot checks.
6. Capture as-cut strike data.
7. Capture post-trim strike data.
8. Update model and authority register from real evidence.

## Stop Rules

- Stop before cutting if fixture datum or material evidence is missing.
- Stop before slot release if kerf coupon evidence is missing.
- Stop before tuning claims if strike protocol or measurement setup is missing.
- Stop before L3 promotion if any visual-output register row remains
  `pending_measurement` for a build-critical artifact.
