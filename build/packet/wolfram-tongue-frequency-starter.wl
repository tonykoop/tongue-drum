(* Instrument-maker build-packet sidecar Wolfram starter for tongue frequency.
   Scope: computational evidence only. Not a fabrication-ready validation. *)

ClearAll["Global`*"];

$scriptDir = DirectoryName[$InputFileName];
$outputDir = ExpandFileName[FileNameJoin[{ $scriptDir, "..", "data" }]];
If[!DirectoryQ[$outputDir], CreateDirectory[$outputDir]];

inch = 0.0254;
metadata = <|
  "InstrumentID" -> "TNG-001",
  "InstrumentType" -> "Tongue drum",
  "Readiness" -> "prototype",
  "Lane" -> "Round24 B6"
|>;

materialLibrary = {
  <|"Material" -> "Padauk", "E_GPa" -> 11.72, "Rho" -> 745|>,
  <|"Material" -> "Hard maple", "E_GPa" -> 12.62, "Rho" -> 705|>,
  <|"Material" -> "Cherry", "E_GPa" -> 10.55, "Rho" -> 560|>
};

kModel = 0.162;

frequencyFromMidi[midi_Integer, a4_: 440.] := a4*2^((midi - 69)/12.);

cantileverFrequency[thicknessIn_, lengthIn_, material_Association] := Module[
  {h, l, ePa, rho},
  h = thicknessIn*inch;
  l = lengthIn*inch;
  ePa = material["E_GPa"]*10^9;
  rho = material["Rho"];
  kModel*(h/l^2)*Sqrt[ePa/rho]
];

requiredLengthIn[targetHz_, thicknessIn_, material_Association] := Module[
  {h, ePa, rho},
  h = thicknessIn*inch;
  ePa = material["E_GPa"]*10^9;
  rho = material["Rho"];
  Sqrt[kModel*h*Sqrt[ePa/rho]/targetHz]/inch
];

lengthModes = {{"Nominal", 1.0}, {"Short-1%", 0.99}, {"Long-1%", 1.01}};
noteRows = {
  <|"Note" -> "D4", "Midi" -> 62, "Target_Hz" -> frequencyFromMidi[62]|>,
  <|"Note" -> "E4", "Midi" -> 64, "Target_Hz" -> frequencyFromMidi[64]|>,
  <|"Note" -> "F4", "Midi" -> 65, "Target_Hz" -> frequencyFromMidi[65]|>,
  <|"Note" -> "G4", "Midi" -> 67, "Target_Hz" -> frequencyFromMidi[67]|>,
  <|"Note" -> "A4", "Midi" -> 69, "Target_Hz" -> frequencyFromMidi[69]|>,
  <|"Note" -> "B4", "Midi" -> 71, "Target_Hz" -> frequencyFromMidi[71]|>,
  <|"Note" -> "C5", "Midi" -> 72, "Target_Hz" -> frequencyFromMidi[72]|>
};

runRows = Flatten@Table[
  Module[{materialName = material["Material"], midi = tone["Midi"], targetHz = tone["Target_Hz"], note = tone["Note"]},
    Flatten@Table[
      Module[{baseLength = requiredLengthIn[targetHz, thickness, material]},
        Table[
          Module[{modeName = mode[[1]], scale = mode[[2]], tunedLength, predicted},
            tunedLength = baseLength*scale;
            predicted = cantileverFrequency[thickness, tunedLength, material];
            <|
              "Material" -> materialName,
              "Thickness_in" -> thickness,
              "Length_Mode" -> modeName,
              "Note" -> note,
              "Midi" -> midi,
              "Target_Hz" -> targetHz,
              "Length_in" -> tunedLength,
              "Predicted_Hz" -> predicted,
              "Cents_Error" -> 1200*Log2[predicted/targetHz]
            |>
          ],
          {mode, lengthModes}
        ]
      ],
      {thickness, {0.25, 0.375}}
    ]
  ],
  {material, materialLibrary},
  {tone, noteRows}
];

runRows = Map[Join[metadata, #]&, runRows];

csvPath = FileNameJoin[{$outputDir, "tongue-frequency-runtime-output.csv"}];
If[Length[runRows] > 0,
  headers = Keys[runRows[[1]]];
  table = Prepend[Lookup[runRows, headers], headers];
  Export[csvPath, table, "CSV"];

  Print["WOLFRAM_RUNTIME_SUCCESS=TRUE"];
  Print["WOLFRAM_RUNTIME_OUTPUT_DIR=" <> $outputDir];
  Print["WOLFRAM_RUNTIME_CSV=" <> csvPath];
  Print["WOLFRAM_RUNTIME_ROW_COUNT=" <> ToString[Length[runRows]]];
,
  Print["WOLFRAM_RUNTIME_SUCCESS=FALSE"];
  Print["WOLFRAM_RUNTIME_ERROR=NO_ROWS"];
];
