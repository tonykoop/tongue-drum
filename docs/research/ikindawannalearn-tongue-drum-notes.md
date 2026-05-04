# I Kinda Wanna Learn Tongue-Drum Research Notes

Researched: 2026-05-04

This note distills the practical build/tuning advice from Colin Sticksl / IKindaWannaLearn's tongue-drum posts, Scratch calculators, and linked YouTube feeds, then maps it against this repo's current cantilever/DoE plan.

## Source Map

| Source | What It Adds |
| --- | --- |
| [How to Make and Tune a Tongue Drum Part 1 of 3](https://ikindawannalearn.wordpress.com/2018/05/09/how-to-make-and-tune-a-tongue-drum-part-1-of-2/) | First-build lessons: tongue thickness by drum size, end-cap stiffness, clamping methods, tuner choice, wood selection, and the original 6% length heuristic. |
| [How to make a "tuned" tongue drum! Step by Step!](https://ikindawannalearn.wordpress.com/2018/05/22/how-to-make-a-tuned-tongue-drum-step-by-step/) | Build sequence: choose notes/frequencies, calculate tongue lengths, leave the bottom open, cut tongues to the inner end-cap line, tune before final closure. |
| [Making A Tongue Drum Musical! The Design Process](https://ikindawannalearn.wordpress.com/2018/06/14/making-a-tongue-drum-musical-the-design-process/) | Musical design process: arrange tongues so small groups form useful chords, keep all notes in one scale, and bias the initial cuts slightly sharp because lowering pitch has more tuning range. |
| [Ultimate Tongue Drum Tuner/Length Calculator](https://scratch.mit.edu/projects/222112099/) | Imperial Scratch calculator using the clamped-bar formula and material presets for padauk, cherry, hard maple, and wenge. |
| [Tongue Drum Tuner/Length Calculator Metric](https://scratch.mit.edu/projects/222700494/) | Metric companion calculator; its instructions explicitly warn to size tongues slightly short so final tuning can lower pitch. |
| [Older pentatonic length calculator](https://scratch.mit.edu/projects/219005959/) | Earlier heuristic calculator based on a planned shortest tongue and ~6% length increase per whole step. |
| [YouTube playlist: How To Design, Build, and Tune Tongue Drums](https://www.youtube.com/playlist?list=PLa7NYjGepCG55L8Pv_FMetj24Ii19eDxC) | Five-video playlist: build/tune parts 1-3, recording setup, and mallet comparison. |
| [IKindaWannaLearnMusic](https://www.youtube.com/channel/UCXznyuIFa5mKFZYn9be6a5w) | Listening references: cherry and maple wooden tongue drums in C major / C major pentatonic, plus a 12-tone cherry demo whose title/description should be verified by ear. |
| [HyperPhysics: Bar Resonances](https://hyperphysics.phy-astr.gsu.edu/hbase/Music/barres.html) | Source for clamped-bar modal ratios; f2 and f3 are much higher and lower amplitude than the fundamental in the idealized clamped-bar model. |
| [Krtwood: Sculpted Tongue Drum](https://www.youtube.com/watch?v=VnK_ZYJ2tqo) | Credited by the Scratch calculator as inspiration; useful for ergonomic/organic body-shape thinking rather than a box-only drum. |
| [LumberJocks: What I learned Making Tongue Drums](https://www.lumberjocks.com/threads/what-i-learned-making-tongue-drums.346372/) | Supplemental maker thread with independently matching observations about material, mass, sympathetic coupling, detachable bottoms, feet, and tuning complexity. |

## High-Value Takeaways

### 1. Start With The Musical Layout, Not Just The Scale

Colin's part 3 post frames a tongue drum as a set of small playable chord zones, not only a row of isolated notes. His six-tongue example keeps all notes inside D major, then arranges them so one side gives a D major chord and the other side can support G and A chord functions.

For this repo: the workbook should keep a `playable_group` or `chord_zone` field next to each tongue. Target pitch alone is not enough; the physical position of the root, third, and fifth matters because players strike neighboring tongues together.

### 2. The 6% Rule Is A Reasonable First Heuristic, But The Physics Calculator Is Better

The early calculator assumes each whole step needs about a 6% increase in tongue length. That is not random: if `f proportional 1/L^2`, an equal-tempered whole step down requires `sqrt(2^(2/12)) = 2^(1/12) = 1.05946`, nearly 6%.

The later Scratch calculators use:

```text
L = sqrt(0.162 * (thickness / frequency) * sqrt(YoungsModulus / density))
```

with thickness in meters, `E` in Pa, density in kg/m^3, and length converted back to inches in the imperial version. The calculator also reports clamped-bar mode estimates `f2 = 6.27*f1` and `f3 = 17.55*f1`, matching the HyperPhysics clamped-bar mode ratios.

For this repo: keep the cantilever formula as the forward model, but use measured prototype data to fit an empirical correction by material, tongue boundary condition, kerf/end radius, and body construction.

### 3. Initial Layout Should Bias Slightly Sharp

The most useful practical tuning warning is that lowering a pitch is far easier than raising it. Colin reports lowering by removing material near the base with much more range than raising by removing tip material. His metric Scratch calculator says to make the tongue slightly shorter than the calculated length for this reason.

For this repo: add an intentional `sharp_bias_cents` or `rough_cut_scale_factor` to the design table. A safe starting point for the first experiment is to rough-cut tongues about 0.5-2% short, record the as-cut frequency, then tune down toward target. Do not treat this as final until the first build gives data.

### 4. Tune Before Closing The Box Permanently

The step-by-step post repeatedly emphasizes leaving the bottom open for tuning access. The part 1 post describes two workable construction methods: clamp a removable bottom airtight during checks, or clamp/fixture the sides so tuning can happen before final bottom attachment.

For this repo: the assembly manual should make the bottom reversible through the first tuning pass. Screws and gasket tape are preferable to glue until final validation is complete.

### 5. End-Cap And Box Stiffness Matter

Colin recommends doubling end-cap thickness during glue-up instead of adding stiffeners later. He also says the top should cap the end pieces and that the tongue slits should terminate at the inner end-cap edge for best agreement with the calculator. The LumberJocks thread independently reports that soundboard/end relationships and box depth/openings affect response.

For this repo: model the effective clamped boundary as a build variable. The first small drum should record end-cap thickness, top-over-end geometry, slit terminus location, and any added side/end stiffeners.

### 6. Wood Choice And Grain Still Need Empirical Treatment

Colin reports good results with cherry, walnut, purpleheart, and especially padauk; he recommends straight-grained hardwood and vertical grain on end caps. The Scratch calculator presets are:

| Material | Density kg/m^3 | E Pa |
| --- | ---: | ---: |
| African padauk | 745 | 11.72e9 |
| Cherry | 600 | 10.55e9 |
| Hard maple | 705 | 12.62e9 |
| Wenge | 870 | 17.59e9 |

For this repo: these values are useful priors, not finished design data. The DoE plan's density/moisture/species measurements are still necessary because board-level variation and grain orientation can swamp catalog values.

### 7. Measurement Tooling Deserves More Attention Than A Phone Tuner

Colin found cheap/free phone tuners frustrating and recommends at least a guitar tuner or mic/software. He used iSpectrum on Mac. His YouTube playlist includes a separate recording video with a Rode NT1, Behringer UMC404HD, Sony Handycam, and Reaper.

For this repo: the current USB measurement mic + Audacity/REW/Python plan is stronger than the maker baseline. Add a repeatable strike location and "sweet spot" check; Colin notes a consistent hit point can be about 1 inch from the tongue tip.

### 8. Mallets Are A Real Experimental Factor

The playlist has a dedicated mallet comparison video. The current DoE already treats mallet hardness and mass as factors, which is exactly the right direction.

For this repo: keep mallet comparison in Phase 1, but include at least one "player-preferred" soft mallet and one hard reference mallet. Record perceived brightness/spectral centroid separately from fundamental pitch.

## Local Guide Check

The local [`Tuning Planning Guide.docx`](../Tuning%20Planning%20Guide.docx) appears to contain:

- Major/minor chord construction reminders.
- Major-key and minor-key common chord progression charts.
- Major-scale note tables.
- A C3-B5 frequency/wavelength reference table.

It does not appear to include tongue geometry, build sequencing, wood selection, or tuning-removal guidance. It is best treated as a musical planning companion, while this Markdown note captures the build/tuning process.

## Candidate Repo Updates

- Add `sharp_bias_cents` or `rough_cut_length_factor` to the design table.
- Add `chord_zone`, `scale_degree`, and `play_group` columns to each tongue row.
- Add `end_cap_thickness`, `slit_terminus_reference`, and `bottom_state` fields to validation data.
- Update the assembly manual to require a reversible or clamped bottom through first tuning validation.
- Add a tuning log step: record frequency before tuning, after rough material removal, after final bottom attachment, and after finish cure.
- Treat phone/guitar tuners as rough shop aids only; keep FFT measurement as the project standard.
