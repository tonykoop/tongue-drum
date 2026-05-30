# Instrument Drawing Brief

Instrument: Tongue drum

Status: L2 V5 build-packet candidate.

Authority: drawing requirements only. No drawing, DXF coordinate set, or CAD
geometry in this packet is fabrication authority.

## Required Views

Future reviewed drawings should include:

- plan view with datum scheme;
- side/front views with envelope references;
- section view for top/shell stack;
- tongue/slit detail view;
- fixture/datum view;
- assembly or exploded reference view.

## Critical Drawing Gates

| Gate | Definition | Evidence needed before values are allowed |
| --- | --- | --- |
| Configuration identity | Drawing names the exact CAD/workbook configuration and revision. | Source file path, revision, and reviewer note. |
| Units and tolerances | Drawing declares units and tolerance policy. | Reviewed drawing title block or shop standard reference. |
| Datum scheme | Drawing declares primary and secondary datums. | Fixture/setup review and measured reference. |
| Tongue IDs | Drawing maps every physical tongue ID to one geometry row. | Reviewed tongue layout table. |
| Slit geometry | Drawing defines slot width, end radius, root relief, and edge-finish requirements. | CAD review plus same-material kerf coupon evidence. |
| Material stack | Drawing defines top/shell stock thickness and orientation evidence. | Measured stock record and material batch note. |
| Tuning interface | Drawing links geometry revision to tuning capture rows. | Strike protocol and measurement log after prototype cut. |

## Visual Rules

- Concept sketches may communicate form and workflow but are `concept_only`.
- Existing images are `reference_only` and cannot supply dimensions.
- SVG/PDF/PNG previews remain `derived_preview` only after they cite a
  controlling CAD/DXF/design-table/measured-template source.
- No drawing should be marked `fabrication` until every gate above has evidence.

## Manufacturing Notes To Resolve

- Stock preparation method.
- Workholding and datum setup.
- Tooling and kerf compensation.
- Coupon and first-article plan.
- Tuning and trim allowance.
- Finish, edge cleanup, and crack-prevention checks.
