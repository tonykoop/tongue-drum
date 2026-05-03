(* Instrument-maker build-packet Wolfram starter. *)

ClearAll["Global`*"];

design = <|
  "InstrumentID" -> "TNG-001",
  "Family" -> "Drums",
  "InstrumentType" -> "Tongue drum",
  "VariantSize" -> "Small (magazine baseline)",
  "KeyScale" -> "D minor / A minor",
  "PrimaryMaterial" -> "Steel or hardwood top",
  "DesignSheet" -> "Tongue Drum",
  "DesignWorkbook" -> "/sessions/busy-sleepy-volta/mnt/Career/flutes-staging/Flutes-AI.xlsx",
  "Units" -> "Imperial",
  "A4" -> 440,
  "SpeedOfSoundInPerSec" -> 13552
|>;

frequencyFromMidi[midi_, a4_: 440] := a4*2^((midi - 69)/12);
centsError[measured_, target_] := 1200*Log2[measured/target];
openPipeLengthIn[freq_, c_: 13552, radius_: 0] := c/(2*freq) - 2*0.6*radius;
stoppedPipeLengthIn[freq_, c_: 13552, radius_: 0] := c/(4*freq) - 0.6*radius;
cantileverLengthIn[freq_, thickness_, k_] := Sqrt[k*thickness/freq];

CreateDocument[
  {
    TextCell[design["InstrumentID"] <> " - " <> design["InstrumentType"], "Title"],
    TextCell["Build-packet computational design notebook", "Subtitle"],
    ExpressionCell[design, "Input"],
    TextCell["Add imported design rows, Manipulate controls, plots, audio, 3D geometry, and validation cells below.", "Text"]
  },
  WindowTitle -> design["InstrumentID"]
]
