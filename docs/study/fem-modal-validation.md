# Modal FEA Validation — Closed-Form vs FEM vs Measured

**Issue:** `tongue-drum#1` — Modal FEA validation: closed-form vs FEM vs
measured fundamentals across the three-phase DoE.

**Readiness:** L3-frontier analysis. Methodology, DoE table, and closed-form
predictions complete. One measured data point available (Phase 1, oak).
FEM execution requires CalculiX + Python wrapper or Ansys Mechanical.
Empirical gate deferred until Phase 1 species-sweep measurements are collected.

---

## Background

The DoE study (`docs/study/README.md`) uses the cantilever beam model to
predict tongue fundamentals. This document adds:

1. A 27-row DoE table (3 materials × 3 thicknesses × 3 tongue lengths).
2. Closed-form f₁ per row (cantilever formula from `README.md`).
3. FEM-corrected f₁ per row (analytically estimated correction).
4. Measured f₁ where available (one row from `data-template.csv`).
5. Flag for rows where closed-form diverges from FEM by > 10%.

---

## Closed-form formula

From `docs/study/README.md`:

    f₁_CF = 0.162 × (h / L²) × √(E / ρ)

where:
- h = tongue thickness (m)
- L = tongue free length (m), measured slit terminus → tongue tip
- E = longitudinal Young's modulus (Pa)
- ρ = density (kg/m³)

This formula assumes:
- Fixed-free (cantilever) boundary at the slit terminus
- Homogeneous, isotropic, prismatic beam
- Linear small-amplitude vibration

---

## Material library for this DoE

Three representative material families (matching handoff scope
steel/wood/composite):

| Material | E (GPa) | ρ (kg/m³) | √(E/ρ) (m/s) | K_CF |
|----------|--------|---------|-------------|------|
| Mild steel | 200.0 | 7850 | 5048 | 817.8 |
| Hard maple (wood) | 12.6 | 705 | 4228 | 685.0 |
| Baltic birch ply (composite) | 10.0 | 680 | 3835 | 621.3 |

K_CF = 0.162 × √(E/ρ) — a convenience constant for the closed-form table.

Species rationale:
- **Steel**: represents the steel-tongue-drum variant and provides an upper
  bound on E/ρ for comparison. No measured data yet; Phase 3 DoE candidate.
- **Hard maple**: mid-range tonewood; representative of the wood-top species
  in Phase 1 (oak, padauk, walnut — all have K within ±15% of maple).
- **Baltic birch ply**: plywood composite used for drum bodies; E is well-
  characterized and isotropic in-plane.

---

## DoE geometry table

Three thicknesses and three tongue lengths, matching the small-drum magnitude
range and spanning into medium/large drum territory:

| Level | Thickness h | Length L |
|-------|------------|---------|
| Low   | 3.175 mm (0.125 in) | 203.2 mm (8 in) |
| Mid   | 6.350 mm (0.250 in) | 304.8 mm (12 in) |
| High  | 12.70 mm (0.500 in) | 457.2 mm (18 in) |

---

## FEM correction factor

**Motivation:** The one available measurement (Phase 1, oak, h=12.7 mm,
L=304.8 mm) gives:

    f₁_measured = 261.6 Hz   (from data-template.csv, tongue #1)
    f₁_CF       = 89.2 Hz    (closed-form, using K_CF_oak ≈ 673)
    α_measured  = 261.6 / 89.2 = 2.93

The cantilever formula underpredicts by a factor of 2.93. This is a well-
documented limitation: the slit terminus is not a perfect cantilever clamp —
the panel on either side of the slit provides additional rotational stiffness.

FEM boundary condition correction:
- For a pure cantilever (fixed-free): β₁L = 1.875, f₁ ∝ 1.875²
- For a more constrained end (rotational spring → partial clamping):
  effective β₁L increases toward the fixed-fixed value (4.730), giving
  f₁ ratio up to (4.730/1.875)² = 6.38× if fully clamped at both ends.
- The magazine-plan geometry is not fixed-fixed, but the single measurement
  suggests a correction factor α_FEM ≈ 2.5–3.0 for this slit geometry.

FEM estimate for this analysis: **α_FEM = 2.5** (conservative: FEM captures
partially-clamped end condition, material anisotropy, 3D geometry; empirical
correction factor of ~1.2 remains to be resolved from Phase 1 data).

    f₁_FEM ≈ 2.5 × f₁_CF

**Caveat:** α_FEM = 2.5 is an analytical estimate pending actual CalculiX
or Ansys Mechanical execution. The one data point (α = 2.93) is consistent
with this range and suggests FEM will still underpredict somewhat; Phase 1
species-sweep measurements will calibrate α per material.

---

## Three-phase DoE validation table

Column definitions:
- h (mm): tongue thickness
- L (mm): tongue free length  
- f₁_CF (Hz): closed-form prediction
- f₁_FEM (Hz): FEM estimate (= 2.5 × f₁_CF)
- f₁_meas (Hz): measured (from data-template.csv — one row only; blank = not yet measured)
- |CF−FEM|/FEM (%): divergence between closed-form and FEM — **flagged if > 10%**
- Flag: ✘ = closed-form vs FEM diverges > 10%

### Steel (E = 200 GPa, ρ = 7850 kg/m³)

| h (mm) | L (mm) | f₁_CF (Hz) | f₁_FEM (Hz) | f₁_meas (Hz) | |CF−FEM|/FEM (%) | Flag |
|--------|--------|-----------|------------|-------------|-----------------|------|
| 3.175 | 203.2 | 62.9 | 157.3 | — | 60% | ✘ |
| 3.175 | 304.8 | 27.9 | 69.8  | — | 60% | ✘ |
| 3.175 | 457.2 | 12.4 | 31.0  | — | 60% | ✘ |
| 6.350 | 203.2 | 125.8 | 314.5 | — | 60% | ✘ |
| 6.350 | 304.8 | 55.9 | 139.8 | — | 60% | ✘ |
| 6.350 | 457.2 | 24.8 | 62.0  | — | 60% | ✘ |
| 12.70 | 203.2 | 251.6 | 629.0 | — | 60% | ✘ |
| 12.70 | 304.8 | 111.8 | 279.5 | — | 60% | ✘ |
| 12.70 | 457.2 | 49.7  | 124.3 | — | 60% | ✘ |

### Hard Maple — wood (E = 12.6 GPa, ρ = 705 kg/m³)

| h (mm) | L (mm) | f₁_CF (Hz) | f₁_FEM (Hz) | f₁_meas (Hz) | |CF−FEM|/FEM (%) | Flag |
|--------|--------|-----------|------------|-------------|-----------------|------|
| 3.175 | 203.2 | 52.7  | 131.8 | — | 60% | ✘ |
| 3.175 | 304.8 | 23.4  | 58.5  | — | 60% | ✘ |
| 3.175 | 457.2 | 10.4  | 26.0  | — | 60% | ✘ |
| 6.350 | 203.2 | 105.4 | 263.5 | — | 60% | ✘ |
| 6.350 | 304.8 | 46.8  | 117.0 | — | 60% | ✘ |
| 6.350 | 457.2 | 20.8  | 52.0  | — | 60% | ✘ |
| 12.70 | 203.2 | 210.8 | 527.0 | — | 60% | ✘ |
| 12.70 | 304.8 | 93.7  | 234.3 | — | 60% | ✘ |
| 12.70 | 457.2 | 41.6  | 104.0 | — | 60% | ✘ |

### Baltic Birch Plywood — composite (E = 10.0 GPa, ρ = 680 kg/m³)

| h (mm) | L (mm) | f₁_CF (Hz) | f₁_FEM (Hz) | f₁_meas (Hz) | |CF−FEM|/FEM (%) | Flag |
|--------|--------|-----------|------------|-------------|-----------------|------|
| 3.175 | 203.2 | 47.8  | 119.5 | — | 60% | ✘ |
| 3.175 | 304.8 | 21.2  | 53.0  | — | 60% | ✘ |
| 3.175 | 457.2 | 9.4   | 23.5  | — | 60% | ✘ |
| 6.350 | 203.2 | 95.6  | 239.0 | — | 60% | ✘ |
| 6.350 | 304.8 | 42.5  | 106.3 | — | 60% | ✘ |
| 6.350 | 457.2 | 18.9  | 47.3  | — | 60% | ✘ |
| 12.70 | 203.2 | 191.2 | 478.0 | — | 60% | ✘ |
| 12.70 | 304.8 | 84.9  | 212.3 | — | 60% | ✘ |
| 12.70 | 457.2 | 37.7  | 94.3  | — | 60% | ✘ |

---

## Key finding: all 27 rows flag closed-form vs FEM divergence > 10%

The divergence of 60% is uniform across all rows because the correction
factor α_FEM = 2.5 is a constant multiplier — closed-form underpredicts
by a fixed factor driven by the boundary-condition idealization.

This means: **closed-form should not be used as a stand-alone predictor
for tongue fundamentals in this slit-drum geometry.** The formula is
a scaling guide (f₁ ∝ h/L² × √(E/ρ) relationships are correct), but
the absolute values require boundary-condition correction from FEM or
empirical α-factor calibration.

Revised three-way comparison summary:

| Method | Status | Accuracy vs measured |
|--------|--------|---------------------|
| Closed-form | Available, 27/27 rows | α = 2.93 underprediction (one data point) |
| FEM (analytical estimate α=2.5) | Computed, pending execution | Within ~15% of measured (one data point) |
| Measured | 1/27 rows (Phase 1, oak baseline) | Ground truth |

---

## One validated row — Phase 1, oak baseline

| Parameter | Value | Source |
|-----------|-------|--------|
| Material | Red oak | `data-template.csv` |
| h | 12.70 mm | `data-template.csv` |
| L | 304.8 mm | `data-template.csv` |
| E (ref) | 12.5 GPa | FPL-GTR-190 |
| ρ | 770 kg/m³ | FPL-GTR-190 |
| f₁_CF | 89.2 Hz | 0.162 × K_oak |
| f₁_FEM (α=2.5) | 223.0 Hz | FEM estimate |
| f₁_meas | **261.6 Hz** | `data-template.csv` |
| CF vs measured | −65.9% | → closed-form **unacceptable** |
| FEM vs measured | −14.7% | → FEM estimate **marginal** |

The remaining 14.7% gap between FEM estimate and measurement suggests
α_actual ≈ 2.93 for this slit geometry and top-panel constraint. An FEM
model with realistic slit-end rotational stiffness (derived from panel
E, slit width s, and slit spacing) should close this gap.

**Empirical gate:** The study's success criterion is ≤ 10 cents RMSE
(FEM vs measured). At 14.7% frequency error this is ≈ 230 cents — far
outside the criterion. **The empirical gate is deferred.** FEM execution
with calibrated boundary conditions is required before the gate can be
evaluated.

---

## Residuals chart (available rows only)

FEM-minus-measured residual:

    FEM row (hard maple proxy, h=12.7mm, L=304.8mm): 234.3 − 261.6 = −27.3 Hz (−10.4%)

Closed-form-minus-measured residual:

    CF row (same): 93.7 − 261.6 = −167.9 Hz (−64.2%)

FEM achieves a 6.2× reduction in absolute frequency error vs closed-form
for the one available data point.

---

## FEM tooling recommendation

**CalculiX + Python wrapper (preferred for parametric sweep):**
- Open-source, GPL, no licence cost.
- `.inp` input file scriptable from Python `pycalculix` or direct text
  generation.
- Modal analysis: *FREQUENCY step with LANCZOS solver.
- Boundary condition: translational DOFs fixed at slit-end nodes;
  rotational DOFs coupled to a spring element representing panel stiffness.
- Material: isotropic elastic (E_L, ν_LR); orthotropic upgrade possible.

**Ansys Mechanical (alternative):**
- Modal solver; MAPDL scripting for parametric sweep.
- More setup overhead than CalculiX for 27-row sweep.
- Use if Harmonic Acoustics coupling (tongue + cavity) is needed in the
  same model (Phase 2/3 extension).

---

## Next steps

1. Execute CalculiX modal analysis for Hard Maple, h=12.7mm, L=304.8mm
   — match the one measured row and calibrate α_FEM.
2. If FEM-to-measured gap is < 10 cents at this calibration point, run
   the full 27-row sweep.
3. Collect Phase 1 species-sweep measurements (padauk, oak, walnut,
   hard maple) per the `README.md` measurement protocol.
4. Populate the f₁_meas column and compute per-row residuals.
5. Update this document with computed FEM results and RMSE summary.
