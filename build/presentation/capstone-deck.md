# Tongue Drum Capstone (TNG-001)
- Musical instrument documentation capstone
- Build packet: 2026-05-02-tng-001-tongue-drum
- Generated: 2026-05-02

---

# Project Intent
- Create a traceable build packet for `TNG-001` that connects the master catalog row, design sheet, BOM, sourcing, stock prep, validation, assembly, drawing brief, visual BOM brief, Wolfram starter, and CAD/CNC placeholder paths.

_Speaker notes:_ Read ../packet/design.md before committing to dimensions or sourcing decisions.

---

# How To Use This Packet
- Start with ../packet/design.md for intent and assumptions.
- Use ../packet/bom.csv, ../packet/sourcing.csv, and ../packet/cut-list.csv before buying or cutting.
- Use ../packet/drawing-brief.md and CAD/CNC folders before machining.
- Print the packet for shopping, shop work, and validation.

---

# File Map
- ../packet/design.md: Project intent, catalog metadata, assumptions, and validation plan.
- ../packet/bom.csv: Starter bill of materials with part categories, quantities, drawing refs, and notes.
- ../packet/sourcing.csv: Supplier/search tracker with specs, price/date fields, lead time, substitutes, and risks.
- ../packet/cut-list.csv: Rough/final stock sizes, material, grain/orientation, operations, yield, and offcuts.
- ../packet/drawing-brief.md: Manufacturing drawing and technical product sketch brief.
- ../packet/assembly-manual.md: Shop-facing sequence, tools, fixtures, safety, tuning, finishing, and maintenance notes.
- ../packet/validation.csv: Target/measured values, tolerance, environment, result, and tuning/build action log.
- ../packet/supplier-rfq.md: Supplier email/request-for-quote starter.

---

# Build Workflow
- Design and assumptions
- Source materials and hardware
- Prepare stock, fixtures, and CNC/laser/lathe setup
- Assemble, tune, finish, and validate

---

# Sourcing And BOM
- BOM gives part categories and drawing references.
- Sourcing tracks search terms, supplier candidates, price/date, lead time, substitutions.
- Visual BOM brief turns the parts list into a presentation-ready image board.

---

# Shop Packet
- Cut list for lumber/sheet/blank planning.
- Assembly manual for away-from-keyboard work.
- Validation sheet for measured dimensions, tuning, pass/fail checks.

---

# Drawings, CAD, CNC
- ../packet/drawing-brief.md defines required views, dimensions, datums, sketch intent.
- ../cad/ holds models and design tables.
- ../cnc/ holds CAM, toolpaths, setup sheets, dry-run notes.
- ../drawings/ holds PDFs, SVGs, DXFs, drawing exports.

---

# Images And Screenshots
- Add hero render/photo, visual BOM, shop screenshots, drawing previews, validation photos in ../../assets/images/.

---

# Validation Plan
- A4 = 440 Hz reference check.
- Tuning targets logged in validation.csv.
- Critical dimensions verified against design sheet and CAD.
- Photos and revision notes after each major step.

---

# Open Risks / Decisions
- TBDs in design sheet and BOM.
- Supplier price/availability not yet verified.
- Generated images marked as concept placeholders.
- Empirical corrections await measured prototype data.

---

# Next Actions
- Replace TBDs with measured/source-backed values.
- Verify live supplier price and availability before buying.
- Export final drawings and visual BOM images.
- Regenerate this deck and print packet after final edits.

---
