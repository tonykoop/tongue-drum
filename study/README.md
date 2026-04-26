# Tongue Drum Key-Tuning Study — Design of Experiments Protocol

> *A design-of-experiments framework for characterizing what actually controls the musical key (and tonal quality) of each tongue on a slit-drum-style tongue drum. Documentation only — no data collected yet.*

## Purpose

For a tongue drum to be "in tune" each tongue must produce a target fundamental frequency with reasonable harmonic content and decay character. Magazine plans (and most DIY guides) prescribe **geometry only**: cut a tongue this long, this wide, on a panel this thick. They are silent on **what to do when the same plan in cherry vs. walnut produces a different key**, which it does — sometimes by a full semitone or more.

This study is the framework for sorting out *which* of the many plausibly-influential variables actually drive the response, so a future tongue drum can be **designed to a target key** rather than tuned by ear after the fact.

## Research questions

**Primary**

- **Q1.** For a fixed tongue geometry, how much fundamental-frequency variance is attributable to wood-property variation alone — within and between species?
- **Q2.** Which controllable geometric factors (length, width, thickness, undercut radius) are the dominant tuning levers, and what are their effect sizes?
- **Q3.** Can a simple cantilever-scaling model `f₁ = k·(h/L²)·√(E/ρ)` predict tongue fundamental frequency to within ±10 cents (1/10 of a semitone) given measured material properties and finished geometry?

**Secondary**

- **Q4.** Cavity volume + sound-port geometry — how much do they shift the *radiated* frequency from the tongue's purely-mechanical resonance? (Same Helmholtz physics as the djembe bass-tone study in the [`djembe`](https://github.com/tonykoop/djembe) sister repo.)
- **Q5.** Mallet hardness and strike force — how much do they shift *perceived* pitch (via overtone content) without shifting the mechanical fundamental?
- **Q6.** Day-to-day environmental drift — across what range of temperature/humidity does the drum need re-tuning?

## Theoretical background

### Tongue mechanics

Each tongue approximates a cantilever beam fixed at one end (the slit terminus / undercut radius) and free at the other (the tongue tip). For a prismatic cantilever the fundamental flexural frequency is:

$$f_1 = \frac{1.875^2}{2\pi L^2}\sqrt{\frac{EI}{\rho A}}$$

For a rectangular cross-section (width *b*, thickness *h*) this simplifies to:

$$f_1 \approx 0.162 \cdot \frac{h}{L^2}\sqrt{\frac{E}{\rho}}$$

So the fundamental scales:

- **Linearly with thickness** *h* (twice as thick → twice the frequency)
- **Inversely with L²** (twice as long → quarter the frequency — the dominant tuning lever)
- **With √(E/ρ)** — the **specific stiffness** of the wood, roughly constant within a species, varying ~3–5× across common tonewood species

The slit-cut tongue is **not** a clean cantilever — the boundary at the slit terminus is somewhere between fully clamped and partially clamped, the cross-section can vary along the length if undercut, and adjacent tongues are weakly coupled through the panel. Treat the cantilever formula as a scaling guide, not a precise predictor. Empirical correction factors will fall out of Phase 2.

### Cavity coupling

The drum body is a **Helmholtz resonator** — closed cavity plus open port — whose own resonance can shift the radiated frequency a few cents from the tongue's purely-mechanical resonance, especially for low-frequency tongues whose fundamentals approach the cavity resonance:

$$f_H = \frac{c}{2\pi}\sqrt{\frac{A_{\text{port}}}{V_0 \cdot L_{\text{eff}}}}$$

(Same model used in the djembe bass-tone study — see [`djembe/README.md`](https://github.com/tonykoop/djembe) for the full derivation.)

## Variables

### Factors — geometric (controllable, primary tuning levers)

| Variable | Symbol | Units | How to measure |
|---|---|---|---|
| Tongue length | L | mm | Calipers, slit terminus → tongue tip |
| Tongue width | b | mm | Calipers, mid-tongue |
| Tongue thickness | h | mm | Calipers at base, mid, tip — record all three |
| Tongue aspect ratio | L/b | — | Derived |
| Tongue volume | V_t | mm³ | Derived (L · b · h_avg) |
| Slit width | s | mm | Feeler gauge or pin gauge |
| Undercut radius at slit terminus | r | mm | Optical calipers or pin gauge |

### Factors — material (semi-controllable: pick the wood)

| Variable | Symbol | Units | How to measure |
|---|---|---|---|
| Wood species | — | — | Recorded; reference [Wood Database](https://www.wood-database.com/) for canonical properties |
| Wood density | ρ | g/cm³ | Mass / volume of a representative cutoff (kitchen scale + calipers) |
| Wood hardness | H_Janka | lbf | Janka rating from species reference (or pin-press indentation if measured locally) |
| Wood moisture content | MC | % | Pin-type moisture meter |
| Grain orientation | — | radial / tangential / longitudinal | Visual + recorded — affects E by 3–10× |
| Young's modulus (estimated) | E | GPa | From species reference tables (modulus along grain) |

### Factors — cavity (controllable, body geometry)

| Variable | Symbol | Units | How to measure |
|---|---|---|---|
| Internal cavity volume | V_0 | in³ | Calculated from internal dimensions; verify by water-fill (sealed cavity) or rice-fill (open cavity) |
| Sound port area | A_port | in² | Direct measurement |
| Sound port effective length | L_eff | in | Port wall thickness + 0.85 × port radius end correction |
| Body wall thickness | t_wall | mm | Calipers |
| Body wood species | — | — | Often differs from top panel |

### Factors — excitation (controllable per strike)

| Variable | Symbol | Units | How to measure |
|---|---|---|---|
| Mallet head material | — | — | Recorded (hard rubber, soft felt, hard maple, yarn-wrapped, etc.) |
| Mallet hardness | H_mallet | Shore A | Durometer if available; ordinal 1 (very soft) → 5 (very hard) otherwise |
| Mallet head mass | m_mallet | g | Kitchen scale |
| Strike force (peak) | F_peak | N | Force-sensing resistor under strike point, OR controlled drop from fixed height (drop-test rig) |
| Strike location on tongue | x_strike | mm from tip | Marked on tongue with masking tape |

### Covariates — environmental (record but don't control)

| Variable | Symbol | Units | How to measure |
|---|---|---|---|
| Air temperature | T | °C | Thermometer/hygrometer combo |
| Relative humidity | RH | % | Same |
| Barometric pressure | P | hPa | Phone barometer or wall weather station |

### Response variables (what we actually measure)

| Variable | Symbol | Units | How to measure |
|---|---|---|---|
| Fundamental frequency | f₁ | Hz | FFT of recorded strike (USB measurement mic); peak picker or autocorrelation |
| 2nd–4th overtones | f₂, f₃, f₄ | Hz | FFT peaks above f₁ |
| Inharmonicity | (f_n − n·f₁) / (n·f₁) | — | Derived; ideal harmonic = 0, sharp = positive |
| Initial sound pressure level | SPL₀ | dB | Calibrated mic at 1 m |
| Decay time | T₆₀ | s | RT60 from impulse response (Schroeder back-integration) |
| Spectral centroid | f_c | Hz | FFT-weighted mean frequency — perceived "brightness" |
| Quality factor | Q | — | f₁ / Δf at −3 dB |
| Perceived pitch error | Δf_cents | cents | Tuner app cross-check (Da Tuner, Insight) — cents from target |

## Instrumentation

**Have / cheap:**
- Digital calipers (0.01 mm)
- Kitchen scale (0.1 g)
- Smartphone with mic + tuner app + barometer

**To acquire:**
- Pin-type wood moisture meter (~$20–40)
- Shore A durometer for mallet heads (~$15)
- USB measurement microphone, flat response (Dayton UMM-6 or equivalent, ~$80)
- Free analysis software: Audacity + REW (Room EQ Wizard) for SPL/RT60, or Python + librosa
- Thermometer / hygrometer combo (~$15)
- FlexiForce A201 force sensor + Arduino, optional (~$30) — for strike-force measurement

**Optional / research-grade:**
- Modal-analysis hammer (PCB Piezotronics 086C03, ~$1k) for clean mechanical-only tongue characterization
- Laser vibrometer for non-contact mode-shape mapping

## Experimental design

Given ~25 plausibly-relevant factors and a constrained build budget, this is a **screening-then-focused** study in three phases:

### Phase 1 — Single-drum within-subject characterization

**Purpose:** establish measurement repeatability and bound the noise floor so Phase 2 effect sizes can be interpreted.

**Method:** build one tongue drum to the magazine plan (oak or walnut). For each of the 6 tongues:

- 3 mallet hardnesses × 3 strike forces × 3 strike locations × 3 repeats = **81 strikes per tongue × 6 tongues = ~486 strikes total**
- All recorded in a single 1–2 hour session (constant T, RH, P)
- Auto-trigger recording on strike attack to reduce dead-air

**Output:** σ_meas (within-tongue strike-to-strike variance in f₁, T₆₀, etc.); main effect of mallet hardness, strike force, and strike location *isolated* from geometry/material variation.

### Phase 2 — Between-drums geometric DoE

**Purpose:** identify which controllable geometric factors are the dominant tuning levers.

**Method:** **12-run Plackett-Burman** screening design over 7 main effects at 2 levels each. Each "run" = build one tongue drum (6 tongues per drum; pool tongue-level responses). Suggested factors:

| Factor | Low (−) | High (+) |
|---|---|---|
| Tongue length range | short (8") | long (12") |
| Tongue width | narrow (1.0") | wide (1.5") |
| Top panel thickness | 3/8" | 1/2" |
| Undercut radius | sharp (≈ slit width) | rounded (≥ 3 mm) |
| Cavity volume | small body | large body |
| Sound port size | small | large |
| Top panel wood | low specific stiffness (e.g. walnut) | high specific stiffness (e.g. hard maple) |

**Output:** Pareto bar chart of main effects; identify top 3–4 drivers for Phase 3.

### Phase 3 — Predictive model + validation build

**Purpose:** produce a usable design tool — input target key, get geometry.

**Method:**
1. Fit cantilever scaling model `f₁ = k · (h/L²) · √(E/ρ)` to the Phase 2 data with empirical correction terms for the dominant non-geometric factors found in Phase 2
2. Predict the geometry needed to hit a chosen target key in a new wood species
3. Build that drum; validate predicted vs. measured f₁ across all 6 tongues

**Success criterion:** Q3 — RMSE prediction error ≤ 10 cents.

## Data collection schema

One row per strike, denormalized — easy for hand entry, normalize later if it grows. See [`data-template.csv`](data-template.csv) for the empty schema and one example row.

## Analysis plan

| Phase | Method | Output |
|---|---|---|
| 1 | Nested ANOVA (strike within tongue within drum) | σ_meas; mallet/force/location main effects |
| 2 | Plackett-Burman main-effects analysis; check residuals against Phase 1 σ_meas | Effect-size Pareto chart; ranked tuning levers |
| 3 | Nonlinear least-squares fit of cantilever model + Phase 2 corrections | f₁ predictor with reported R² and prediction interval |

**Suggested visualizations:**
- Phase 1: box-and-whisker of f₁ per (tongue × mallet) cell
- Phase 2: Pareto bar chart of standardized main effects; half-normal plot to identify significant factors
- Phase 3: predicted vs. measured f₁ scatter with ±10-cent prediction band; spectrogram waterfall comparing same tongue across mallet hardnesses

## Scope and what's deliberately *not* included

- **No FEA.** The cantilever scaling model plus Phase 2 empirical corrections is targeted to be sufficient for ~10-cent prediction. If it isn't, FEA becomes the next study, not part of this one.
- **No psychoacoustic listener panel.** "Tonal quality" is reduced to inharmonicity + decay metrics, not subjective ratings.
- **Mechanical fundamental is the response of interest.** Perceived-pitch-from-overtones effects (Q5) are a secondary question; the cleanest data is f₁ from FFT.
- **One drum form factor.** All builds in Phases 1–2 follow the magazine plan (six paired tongues, ~12" tongue length, rectangular box body). Other forms (steel-tongue handpan, log slit drum, etc.) would be separate studies.

## Cross-references

- **Acoustic-cavity physics** — the Helmholtz model is the same one used for the djembe bass-tone study: [`djembe/README.md`](https://github.com/tonykoop/djembe)
- **DoE methodology** — same screening-then-focused approach used in my AM tensile-testing R&D work (powder-recipe and laser-parameter studies on SLM 125/250)

## Status

Documentation only — no data collected yet. Next steps:

1. Build the magazine-plan drum (oak top, walnut sides — wood already on hand)
2. Acquire the moisture meter, durometer, and USB measurement mic
3. Run Phase 1
