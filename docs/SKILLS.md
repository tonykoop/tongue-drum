# Skills demonstrated in this repo

> *A human-readable agent-skill index — personal-wiki entries for the engineering methodologies this repository uses. Each entry is a self-contained `.md` written to be readable by both humans and CLI or robotic agents that may want to load my skills as context. Inspired by Karpathy's [LLM Wiki](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f) and [autoresearch](https://github.com/karpathy/autoresearch) ideas, applied to hardware engineering practice.*

## Acoustics

- **[helmholtz-cavity-resonator](https://github.com/tonykoop/djembe/blob/main/skills/helmholtz-cavity-resonator.md)** *(canonical: `tonykoop/djembe/skills/`)* — Predict bass-tone fundamentals of a closed cavity coupled to a port. Used in this repo for **Phase 2** of the [key-tuning study](study/README.md): the bilateral tongue-bank cavity-coupling test (Q4 + Q7) is built directly on this model.

## Design of experiments

- **`design-of-experiments-for-key-tuning`** *(stub — defined inline in [`study/README.md`](study/README.md))* — A three-phase characterization framework for tongue drum key tuning: noise-floor + species sweep on the small drum, bilateral coupling on the medium drum, predict-and-validate on the large drum. Methodological cousin to **[astm-e8-tensile-testing](https://github.com/tonykoop/tensile-testing/blob/main/skills/astm-e8-tensile-testing.md)** in the tensile-testing repo: different physics, same habit of deciding variables, responses, and validation criteria before the data starts landing.

## Cantilever-beam mechanics (stub)

- **`cantilever-flexural-frequency`** *(stub — currently inline in `study/README.md`)* — `f₁ ≈ 0.162 · (h/L²) · √(E/ρ)` for a prismatic cantilever's fundamental flexural frequency. The dominant model for tongue drum tongue tuning. Will be extracted on first cross-repo use (likely whichever instrument repo next uses cantilever-like tongues or reeds).

---

## How this index works

Each skill is a self-contained `.md` file under `skills/` (or in another repo's `skills/`, if canonical there) with:

- **YAML frontmatter** — name, description, status, canonical location, provenance, audience. Designed to be loadable by an agent.
- **When-to-use / when-not-to-use** sections.
- **Method** — the procedure, formulas, and step ordering.
- **Worked examples** — concrete numbers from my repos.
- **Failure modes** — the wrong turns I've taken and what they cost.
- **Provenance + cross-references** — where the skill was derived, which other repos use it.

A skill's **canonical location** is one repo — typically where it was first derived or is most deeply documented. The Helmholtz cavity resonator above lives canonically in [`tonykoop/djembe`](https://github.com/tonykoop/djembe) because that's where the undergrad derivation happened; this repo links to it rather than duplicating. The convention is *don't extract a skill into its own file until reuse actually forces it* — premature abstraction is worse than inline documentation.

If a `tonykoop-skills` meta-repo emerges later, canonical files will migrate there and these per-repo `SKILLS.md` indexes will continue to point at them.
