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
- **Q7.** **Bilateral tongue coupling** (medium drum, original design): when two tongue banks share one cavity from opposite ends of the body, do they couple — i.e. does damping or striking one bank shift the resting frequency of the other — and if so, how strongly?

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

## Planned drum series

Three drums in the build queue, each becoming a phase of this study:

1. **Small — magazine baseline.** Six tongues in a paired-slit pattern, ~7½" × 12" × 6" rectangular box body, ~12" tongue length. Built to the *Tones-of-Fun Tongue Drum* plan from *WOOD magazine*, October 2008, pages 58–61 + full-size pattern page 76.[^source] Multiple iterations planned in different wood species (padauk, oak, walnut, hard maple, cherry, others TBD) so material-property variation can be bounded against a single fixed geometry.
2. **Medium — original design, bilateral tongues.** Original design with tongues extending from **both** the left and the right ends of the drum body. Doubles the playable tongue count without enlarging the body envelope, and introduces a question this study can answer: do the two opposed tongue banks **couple through the shared cavity** (so striking one bank pulls the pitch of the resting bank), or do they behave as two independent unilateral drums sharing a Helmholtz volume?
3. **Large — original design, extended range.** Original design with more tongues spanning a wider tonal range (lower bass tongue + higher treble tongue) than either smaller drum. Form factor TBD; the design constraint is that the longest bass tongue must remain strikeable and the cavity must be large enough that the lowest tongue's fundamental sits cleanly above the cavity's Helmholtz frequency rather than fighting it.

With three form factors rather than the 12+ builds a classical screening DoE would require, this is structured as a **case-study series with built-in within-drum variation** (six or more tongues per drum, each at a different design length). The within-drum tongue-length variation is what gives the cantilever scaling model `f₁ ∝ h/L²` its statistical leverage from this small a build budget.

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

The study unfolds across the three planned drums (above). Each drum is its own phase of data collection; cross-drum synthesis happens at the end. Within each drum, the **six-or-more tongues at different design lengths give built-in within-subject variation** that drives the cantilever-scaling fit — this is what makes a small build budget statistically usable.

### Phase 1 — Small drum: noise floor + species variation

**Purpose:** establish measurement repeatability, fit the basic cantilever scaling, and bound the wood-species effect.

**Method:**
- **First build:** one small drum (magazine plan, single wood species). Strike each of the 6 tongues with 3 mallet hardnesses × 3 strike forces × 3 strike locations × 3 repeats = **81 strikes per tongue × 6 tongues = ~486 strikes** in a single 1–2 hour session at constant T, RH, P. This anchors σ_meas and isolates the mallet/force/location effects.
- **Subsequent builds:** repeat the small drum in 2–4 additional wood species (varying ρ and E). Lighter strike protocol per build — ~10 strikes per tongue with one mallet, one strike location — sufficient to nail down f₁ for each tongue. Each build also feeds the Helmholtz cavity check (Q4).

**Output:** σ_meas; cantilever-scaling fit `f₁ ≈ 0.162 · (h/L²) · √(E/ρ)` with measured E and ρ per species; mallet/force/location effect sizes from the deep first build.

### Phase 2 — Medium drum (bilateral original): does the model still hold?

**Purpose:** characterize the original bilateral design and answer the new physics questions it introduces (Q4 cavity coupling at scale, Q7 tongue-bank coupling across the cavity).

**Method:**
- One build of the medium bilateral design.
- Standard ~10-strike-per-tongue characterization across all tongues on both banks.
- **Coupling test:** for each tongue on bank A, measure f₁ twice — once with bank B free (resting), once with bank B fully damped (e.g. light foam pressed on all tongues). Any pitch shift between the two conditions is evidence of cross-cavity coupling. Repeat reversing roles.

**Output:** does the Phase 1 cantilever fit predict bilateral-bank f₁ within Phase 1 σ_meas, or does the bilateral form factor introduce a measurable correction term? Magnitude of cross-bank coupling (Q7).

### Phase 3 — Large drum (extended range): does the model extrapolate?

**Purpose:** test the model's extrapolation to longer tongues (lower fundamentals) and a larger cavity, and produce a final design rule.

**Method:**
- One build of the large extended-range design, with the cavity volume picked to land its lowest tongue's Helmholtz frequency well below the lowest tongue's mechanical fundamental (so cavity coupling is a small correction, not a fight).
- Standard characterization.
- **Validation pre-step:** before building, *predict* each tongue's f₁ from the Phase 1+2 model. Record predictions, then build, then compare to measurement. This is the live test of Q3.

**Output:** RMSE of predicted vs. measured f₁ across all tongues. **Success criterion: ≤ 10 cents RMSE.** If achieved, the cantilever-scaling-plus-corrections model is usable as a forward design tool — input target key, get geometry.

## Data collection schema

One row per strike, denormalized — easy for hand entry, normalize later if it grows. See [`data-template.csv`](data-template.csv) for the empty schema and one example row.

## Analysis plan

| Phase | Method | Output |
|---|---|---|
| 1 (deep build) | Nested ANOVA (strike within tongue within drum) | σ_meas; mallet/force/location main effects |
| 1 (species sweep) | Linear regression of measured f₁ against (h/L²)·√(E/ρ) per species | Slope coefficient (theoretical = 0.162); residuals indicate species or grain effects |
| 2 (bilateral) | Paired t-test of f₁ with opposite bank free vs. damped | Cross-cavity coupling magnitude (Q7); residuals against Phase 1 model |
| 3 (large + validation) | Predicted-vs-measured scatter; RMSE in cents | Pass/fail on Q3 (≤ 10 cents) |

**Suggested visualizations:**
- Phase 1: box-and-whisker of f₁ per (tongue × mallet) cell; cantilever scaling line `f₁ vs (h/L²)·√(E/ρ)` with one point per tongue × species
- Phase 2: bar chart of f₁ shift (in cents) for each tongue when the opposite bank is damped vs free
- Phase 3: predicted vs. measured f₁ scatter with ±10-cent prediction band; spectrogram waterfall comparing same tongue across mallet hardnesses

## Scope and what's deliberately *not* included

- **No FEA.** The cantilever scaling model plus empirical phase-by-phase corrections is targeted to be sufficient for ~10-cent prediction. If it isn't, FEA becomes the next study, not part of this one.
- **No psychoacoustic listener panel.** "Tonal quality" is reduced to inharmonicity + decay metrics, not subjective ratings.
- **Mechanical fundamental is the response of interest.** Perceived-pitch-from-overtones effects (Q5) are a secondary question; the cleanest data is f₁ from FFT.
- **Three rectangular-box form factors.** All planned builds are box-style slit tongue drums (small magazine baseline + medium bilateral + large extended-range). Other forms — steel-tongue handpans, hollowed-log slit drums, ceramic udu-style — would be separate studies.

## Cross-references

- **Acoustic-cavity physics** — the Helmholtz model is the same one used for the djembe bass-tone study: [`djembe/README.md`](https://github.com/tonykoop/djembe)
- **DoE methodology** — same screening-then-focused approach used in my AM tensile-testing R&D work (powder-recipe and laser-parameter studies on SLM 125/280)

## Status

Documentation only — no data collected yet. Next steps:

1. Build the **first small drum** to the magazine plan (wood TBD — first iteration will pick from species on hand; subsequent iterations vary intentionally per Phase 1 *species sweep*)
2. Acquire the moisture meter, durometer, and USB measurement mic
3. Run Phase 1 first build (the deep ~486-strike characterization)
4. CAD for the medium and large original designs — incoming once SolidWorks is back online (ETA a few weeks)

## References

[^source]: ***Tones-of-Fun Tongue Drum.*** Project design by **Steve Roberts**, written by **Owen Duvall**, illustrated by **Roxanne LeMoine** and **Lorna Johnson**. ***WOOD magazine*, October 2008**, pages 58–61 plus full-size pattern on page 76. Six-tongue paired-slit design (paired tongues sharing a common slit at one end), ~12" tongue length, ~7½ × 12 × 6" rectangular box body. Materials list specifies padauk top with oak ends/sides/bottom/handles/feet, ¼" oak dowel mallet handles with 1" rubber-ball heads. Magazine page scans are in [`images/`](../images/) (`img20260426_00430913.png` cover, `img20260426_00455146.png` full-size pattern, `img20260426_01041622.png` exploded view + drilling, `img20260426_01045871.png` assembly + handles + feet, `img20260426_01061547.png` mallets + finish + sidebar + cutting diagram + materials list). This article forms the small-drum baseline for the study; the medium bilateral and large extended-range designs are original work building forward from it.
