# Wolfram Runtime Blocker Evidence (B6)

Lane: `tongue-drum` issue #4 — tongue-frequency runtime packet

## Attempted command
- `wolframscript -file build/packet/wolfram-tongue-frequency-starter.wl`
- `wolframscript -activate -file build/packet/wolfram-tongue-frequency-starter.wl`

## Exact failure text
The first command returned:

> Your Wolfram Engine installation is not activated or is experiencing a license-related problem.
>
> Please run wolframscript with the -activate option, and then try
>  your original wolframscript command again.

The second command (`-activate`) exited with code 255 and produced no runtime output in this environment.

## Evidence status
- `Wolfram runtime output artifacts were not produced` because the engine could not be activated.
- `build/data/tongue-frequency-runtime-output.csv` and `build/data/tongue-frequency-runtime-plot.png` were therefore not generated.

## Preserve intent
The Wolfram starter is additive and untouched-by-PR-#5 paths are:
- `build/packet/wolfram-tongue-frequency-starter.wl`
- `build/packet/wolfram-tongue-frequency-runtime.md`
- `build/packet/wolfram-tongue-frequency-blocker.md`
