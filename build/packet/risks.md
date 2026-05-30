# TNG-001 V5 Risk Register

Status: L2 concept risk surface.

## Blocking Risks

| risk_id | Risk | Current authority | Required closure evidence |
| --- | --- | --- | --- |
| RISK-001 | CAD/workbook configuration may not match the intended Phase-1 prototype. | pending_measurement | Reviewed configuration ID and revision path. |
| RISK-002 | Tongue layout may be copied from a source that has not been measured or reviewed. | pending_measurement | One reviewed geometry row per physical tongue ID. |
| RISK-003 | Kerf and end-radius assumptions can change tuning and stress concentration. | pending_measurement | Same-material coupon measurement and edge-condition review. |
| RISK-004 | Fixture datum error can make repeated tuning cuts non-comparable. | pending_measurement | Fixture setup sheet, photos, and first-article result. |
| RISK-005 | Material batch, thickness, moisture, and grain/orientation are unknown. | pending_measurement | Stock record with measurement method and environment note. |
| RISK-006 | Tuning model may not predict the real build until strike logs exist. | pending_measurement | As-cut and post-trim capture logs linked to geometry revision. |
| RISK-007 | Existing images may tempt dimensional inference. | reference_only | Keep photos out of fabrication authority unless replaced by measured templates. |
| RISK-008 | Computational stubs could be mistaken for executed analysis. | concept_only | Add execution logs and exported results only after a real run. |

## L3 Promotion Blocker

This packet cannot be called build-ready until CAD configuration, geometry,
CNC, material, and tuning gates are closed with evidence paths.
