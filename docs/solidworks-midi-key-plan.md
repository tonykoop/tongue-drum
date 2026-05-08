# Tongue Drum MIDI Key Plan

This is a practical starting plan for `TNG-000_MasterLayout.SLDPRT`.

Use `t##_midi_note` as the musical target, not as proof that the current tongue
length is already correct. The real instrument still needs calibration from
prototype cuts, wood species, grain, slot width, and bridge/root behavior.

The recommended family below uses **G major pentatonic**:

```text
G A B D E
```

It is forgiving, consonant, and scales well from 6 tongues to 16 tongues without
forcing semitone neighbors onto a wood tongue layout.

## Recommended MIDI Values

| Config | Tongues | MIDI values | Notes |
|---|---:|---|---|
| `Small_Baseline_6T` | 6 | `43, 45, 47, 50, 52, 55` | G2 A2 B2 D3 E3 G3 |
| `Small_Baseline_8T` | 8 | `43, 45, 47, 50, 52, 55, 57, 59` | G2 A2 B2 D3 E3 G3 A3 B3 |
| `Medium_Bilateral_10T` | 10 | `43, 45, 47, 50, 52, 55, 57, 59, 62, 64` | G2 A2 B2 D3 E3 G3 A3 B3 D4 E4 |
| `Medium_Bilateral_12T` | 12 | `43, 45, 47, 50, 52, 55, 57, 59, 62, 64, 67, 69` | G2 A2 B2 D3 E3 G3 A3 B3 D4 E4 G4 A4 |
| `Large_Bilateral_14T` | 14 | `43, 45, 47, 50, 52, 55, 57, 59, 62, 64, 67, 69, 71, 74` | G2 A2 B2 D3 E3 G3 A3 B3 D4 E4 G4 A4 B4 D5 |
| `Large_Bilateral_16T` | 16 | `43, 45, 47, 50, 52, 55, 57, 59, 62, 64, 67, 69, 71, 74, 76, 79` | G2 A2 B2 D3 E3 G3 A3 B3 D4 E4 G4 A4 B4 D5 E5 G5 |

## Design Table Entry Pattern

Assign the MIDI values in ascending tongue order:

```text
t01_midi_note, t02_midi_note, ...
```

For inactive tongues, keep:

```text
t##_bank = 0
t##_midi_note = 0
t##_len_in = 0in
t##_wid = 0in
```

## Small Baseline Magazine Caution

The current `Small_Baseline_6T` scanned/tongue lengths imply much lower notes
than the current MIDI values if the rough beam estimate is used:

| Tongue | Current length | Current MIDI | Rough estimated note |
|---|---:|---:|---|
| `t01` | 8.524 in | 60 | F#2/G2 |
| `t02` | 6.750 in | 61 | D3 |
| `t03` | 6.000 in | 62 | F#3 |
| `t04` | 5.900 in | 64 | G3 |
| `t05` | 6.300 in | 67 | F3 |
| `t06` | 8.600 in | 70 | F#2/G2 |

So for the magazine baseline, choose one intent before cutting:

1. **Preserve the traced magazine geometry** and treat the MIDI values as
   documentation targets to revise after measurement.
2. **Use the G major pentatonic MIDI targets** and adjust tongue lengths to suit
   the target notes.

Do not expect the current C4-ish MIDI values to match the current 6T physical
lengths.
