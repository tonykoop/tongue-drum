(* Instrument-maker build-packet sidecar Wolfram starter for tongue frequency.
   Scope: computational evidence only. Not a fabrication-ready validation. *)

ClearAll["Global`*"];

$scriptDir = DirectoryName[$InputFileName];
$outputDir = FileNameNormalize[FileNameJoin[{ $scriptDir, "..", "data" }]];
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

(* Cantilever-style heuristic used by this packet.
   This is a sidecar modeling slice and should not be treated as finalized build truth. *)
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

lengthModes = <|"Nominal" -> 1.0, "Short-1%" -> 0.99, "Long-1%" -> 1.01|>;

noteRows = {
  <|"Note" -> "D4", "Midi" -> 62, "Target_Hz" -> frequencyFromMidi[62]|>,
  <|"Note" -> "E4", "Midi" -> 64, "Target_Hz" -> frequencyFromMidi[64]|>,
  <|"Note" -> "F4", "Midi" -> 65, "Target_Hz" -> frequencyFromMidi[65]|>,
  <|"Note" -> "G4", "Midi" -> 67, "Target_Hz" -> frequencyFromMidi[67]|>,
  <|"Note" -> "A4", "Midi" -> 69, "Target_Hz" -> frequencyFromMidi[69]|>,
  <|"Note" -> "B4", "Midi" -> 71, "Target_Hz" -> frequencyFromMidi[71]|>,
  <|"Note" -> "C5", "Midi" -> 72, "Target_Hz" -> frequencyFromMidi[72]|>
};

runTable = Flatten@Map[
  Function[mat,
    Flatten@Map[
      Function[tone,
        Module[{thicknesses = {0.25, 0.375}, baseLength},
          baseLength = requiredLengthIn[tone["Target_Hz"], #, mat] & /@ thicknesses;
          Join @@ MapIndexed[
            Function[{lengthIn, idx},
              Module[{toneMode = #2[[1]], modeName = Keys[lengthModes][[toneMode]], scale = #1},
                <|
                  "Material" -> mat["Material"],
                  "Thickness_in" -> thicknesses[[idx[[1]]]],
                  "Length_Mode" -> modeName,
                  "Note" -> tone["Note"],
                  "Midi" -> tone["Midi"],
                  "Target_Hz" -> tone["Target_Hz"],
                  "Length_in" -> baseLength[[idx[[1]]]]*scale,
                  "Predicted_Hz" -> cantileverFrequency[
                    thicknesses[[idx[[1]]]],
                    baseLength[[idx[[1]]]]*scale,
                    mat
                  ],
                  "Cents_Error" -> 1200*Log2[
                    cantileverFrequency[
                      thicknesses[[idx[[1]]]],
                      baseLength[[idx[[1]]]]*scale,
                      mat
                    ]/tone["Target_Hz"]
                |>
              ]
            ,
            lengthModes
          ]
        ]
      ],
      noteRows
    ]
  ],
  materialLibrary
];

runTable = Map[Prepend[metadata, #]&, runTable];

csvPath = FileNameJoin[{$outputDir, "tongue-frequency-runtime-output.csv"}];
plotPath = FileNameJoin[{$outputDir, "tongue-frequency-runtime-plot.png"}];

Export[csvPath, runTable, "CSV"];

nominalRows = Select[runTable, #Length_Mode == "Nominal"&];
byMaterial = GroupBy[nominalRows, #Material&];
plotData = Values @ Map[Function[rows, rows[[All, {"Thickness_in", "Predicted_Hz"}]]], byMaterial];

plot = ListPlot[
  plotData,
  PlotLegends -> Keys[byMaterial],
  AxesLabel -> {"Thickness (in)", "Predicted f (Hz)"},
  PlotLabel -> "Tongue frequency model sensitivity to material and thickness",
  ImageSize -> 900,
  Joined -> True,
  PlotMarkers -> Automatic
];
Export[plotPath, plot];

Print["WOLFRAM_RUNTIME_SUCCESS=TRUE"];
Print["WOLFRAM_RUNTIME_OUTPUT_DIR=" <> $outputDir];
Print["WOLFRAM_RUNTIME_CSV=" <> csvPath];
Print["WOLFRAM_RUNTIME_PLOT=" <> plotPath];
Print["WOLFRAM_RUNTIME_ROW_COUNT=" <> ToString[Length[runTable]]];
