# Tongue Drum — Engineering Documentation for Slit-Drum Builds

> *Three planned tongue drums — one to a published magazine plan, two original designs — and a design-of-experiments protocol for predicting each tongue's musical key from the geometry, material, and excitation.*

![Hero — magazine cover photo of a six-tongue tongue drum being struck by mallets](images/img20260426_00430913.png)
*The reference instrument: a six-tongue paired-slit tongue drum from "Tones-of-Fun Tongue Drum," WOOD magazine, October 2008 (project design Steve Roberts; written by Owen Duvall; illustrated by Roxanne LeMoine and Lorna Johnson). The small drum in this study's planned three-drum series is built directly to this plan.*

## What this is

Engineering documentation for a small series of tongue drum (slit drum) builds, plus the design-of-experiments framework that makes them a proper acoustics study. The repository combines:

1. **Three planned drums** — small (magazine baseline), medium (original bilateral-tongue design), large (original extended-range design). Each one becomes a phase of the study; together they bound material, geometric, and form-factor effects on the bass tone.
2. **A DoE protocol** for predicting each tongue's fundamental frequency from the cantilever-scaling model `f₁ ≈ 0.162 · (h/L²) · √(E/ρ)`, validated empirically against tongue-by-tongue strike measurements. Full protocol at [`study/README.md`](study/README.md).
3. **A skill index** ([`SKILLS.md`](SKILLS.md)) listing the engineering methodologies this repo demonstrates, including the cross-repo Helmholtz cavity resonator skill canonically defined in [`tonykoop/djembe`](https://github.com/tonykoop/djembe/blob/main/skills/helmholtz-cavity-resonator.md).

Sister repos: [`djembe`](https://github.com/tonykoop/djembe) (where the cavity-resonance physics was originally derived for the bass-tone analysis), [`tensile-testing`](https://github.com/tonykoop/tensile-testing) (where the same DoE methodology drove material characterization at Uniformity Labs), and [`cnc`](https://github.com/tonykoop/cnc) (the CAM/Haas operator skill that may be used for the original-design body fabrication).

## Background — what makes a tongue drum different

A tongue drum (also called a slit drum or log drum) is an idiophone: a hollow body whose top surface has slits cut in it, leaving "tongues" of material that vibrate when struck. Each tongue is approximately a fixed-free cantilever beam — clamped at the slit terminus, free at the tongue tip — and its fundamental frequency is set primarily by length, thickness, and the wood's specific stiffness `√(E/ρ)`. The body's air cavity provides bass-end coupling via Helmholtz resonance.

Tongue drums span an enormous range of cultures and forms: African log slit drums (the **lokole**, **mukoma**, **ekwe**), Mesoamerican slit drums (the **teponaztli**), modern steel-tongue handpans, and the contemporary wooden box-style drum the magazine plan documents. This study focuses on the **box-style wooden tongue drum** as the most reproducible form factor for engineering characterization — but the same physics applies across the family.

## The three planned drums

### 1. Small — magazine baseline
Built to the **WOOD magazine** plan (Oct 2008): six tongues in a paired-slit pattern (two tongues sharing each slit), ~7½" × 12" × 6" rectangular box body, ~12" tongue length. Wood will be **varied across iterations** — padauk, oak, walnut, hard maple, cherry, others TBD — so material-property variation can be bounded against a single fixed geometry. Magazine pages scanned in [`images/`](images/) (cover, full-size pattern, exploded view, assembly, mallets/finish/cutting-diagram/materials list).

### 2. Medium — original design with bilateral tongues
Original design with **tongues extending from both the left and the right ends** of the drum body. Doubles the playable tongue count without enlarging the body envelope, and introduces a question this study can directly answer: do the two opposed tongue banks **couple through the shared cavity** (so striking one bank pulls the resting pitch of the other), or do they behave as two independent unilateral drums sharing a Helmholtz volume?

### 3. Large — original design with extended range
Original design with **more tongues spanning a wider tonal range** than either smaller drum — a lower bass tongue and a higher treble tongue. Form factor TBD; constraint is that the longest bass tongue must remain strikeable and the cavity must be sized so its Helmholtz frequency sits cleanly below the lowest tongue's mechanical fundamental.

## The key-tuning DoE study

Three phases mapping to the three drums:

- **Phase 1** — Small drum: noise-floor characterization (~486 strikes on the first build) plus a species sweep of 2–4 lighter builds in different woods.
- **Phase 2** — Medium drum (bilateral): standard characterization plus the cross-cavity coupling test.
- **Phase 3** — Large drum: predict each tongue's f₁ from the Phase 1+2 model *before* building, then build, then validate. Success criterion: ≤ 10 cents RMSE.

Full protocol — research questions, variable tables, instrumentation list, analysis plan, and scope notes — is in [`study/README.md`](study/README.md). The data schema (one row per strike) is in [`study/data-template.csv`](study/data-template.csv); raw measurement data will live in [`study/data/`](study/) (forthcoming, after Phase 1 first build).

## Skills demonstrated

See [`SKILLS.md`](SKILLS.md) — a "human-take agent skill" index. Three skills surface here:

- **[helmholtz-cavity-resonator](https://github.com/tonykoop/djembe/blob/main/skills/helmholtz-cavity-resonator.md)** *(canonical: djembe)* — bass-tone prediction for a cavity coupled to a port. Phase 2 (bilateral coupling) is built on this model.
- **`design-of-experiments-for-key-tuning`** *(stub — defined inline in `study/README.md`)* — three-phase characterization framework.
- **`cantilever-flexural-frequency`** *(stub — currently inline in `study/README.md`)* — `f₁ ≈ 0.162 · (h/L²) · √(E/ρ)` for tongue tuning.

## Repository structure

```
tongue-drum/
├── README.md                  ← you are here
├── LICENSE                    ← CC-BY 4.0
├── SKILLS.md                  ← personal-wiki skill index for this repo
├── images/                    ← magazine pages (page 58 cover, page 76 pattern,
│                                pp 59-61 exploded view + assembly + mallets +
│                                cutting diagram + materials list)
└── study/
    ├── README.md              ← full DoE protocol (10 sections, Q1-Q7,
    │                            three-phase design)
    ├── data-template.csv      ← 43-column strike-level data schema
    └── data/                  ← raw measurement CSVs (forthcoming)
```

## Status

| Section | Status |
|---|---|
| Repo description, license | ✓ done |
| Magazine baseline scanned + attributed | ✓ done (5 pages) |
| DoE protocol | ✓ done (`study/README.md`) |
| Data schema | ✓ done (`study/data-template.csv`) |
| Skills index + cross-repo helmholtz link | ✓ done (`SKILLS.md`) |
| Small drum first build | forthcoming |
| Medium drum CAD | forthcoming (SolidWorks pending) |
| Large drum CAD | forthcoming (SolidWorks pending) |
| Phase 1 measurement data | forthcoming |

## License

Released under [CC-BY 4.0](LICENSE) — original written content, photographs, study protocol, and skill files in this repository are mine, free to reuse and adapt with credit. The magazine plan attributed above remains under WOOD magazine's copyright; pages are reproduced here under fair-use for portfolio-context-and-attribution purposes.
