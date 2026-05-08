# SolidWorks Master Layout Global Variable Checklist

Use this checklist for `cad/TNG-000_MasterLayout.SLDPRT` and its design table
`cad/TNG-000_MasterLayout.xlsx`.

The design table should own independent, configuration-specific inputs. The
Equation Manager should own derived values. Child parts should reference the
master layout sketches/dimensions, not each other.

## Inputs To Add To The Design Table

These variables already exist in the master layout export, but are not currently
controlled by the design table. Add them as design-table columns when you want
each configuration to be fully table-driven.

```text
$VALUE@bottom_thk_in@Equations
$VALUE@side_thk_in@Equations
$VALUE@end_cap_thk_in@Equations
$VALUE@port_dia_in@Equations
$VALUE@foot_dia_in@Equations
$VALUE@foot_hgt_in@Equations
$VALUE@foot_inset_in@Equations
$VALUE@foot_screw_hole_dia_in@Equations
$VALUE@tongue_gap_in@Equations
$VALUE@slit_end_rad_in@Equations
$VALUE@bank_spacing_y@Equations
$VALUE@mirror_banks@Equations
$VALUE@k_imperial@Equations
$VALUE@sharp_bias_cents@Equations
$VALUE@tuning_allowance_in@Equations
```

Also add the early tongue values that are currently global variables but not
design-table columns:

```text
$VALUE@t01_bank@Equations
$VALUE@t02_bank@Equations
$VALUE@t03_bank@Equations
$VALUE@t04_bank@Equations

$VALUE@t01_midi_note@Equations
$VALUE@t02_midi_note@Equations
$VALUE@t03_midi_note@Equations
$VALUE@t04_midi_note@Equations
$VALUE@t05_midi_note@Equations
$VALUE@t06_midi_note@Equations

$VALUE@t01_len_in@Equations
```

## Rename Or Replace These Existing Variables

These are already useful, but the names should carry units so the child parts
are easier to read later.

```text
panel_top_len      -> panel_top_len_in
panel_top_wid      -> panel_top_wid_in
side_panel_len     -> side_panel_len_in
side_panel_hgt     -> side_panel_hgt_in
l_tong_bank        -> l_tong_bank_y_in
r_tong_bank        -> r_tong_bank_y_in
screw_size         -> foot_screw_nominal_dia_in
```

Also change this sketch equation:

```text
"screw_hole@SK_FEET" = "screw_size"
```

to:

```text
"screw_hole@SK_FEET" = "foot_screw_hole_dia_in"
```

That keeps the nominal screw size separate from the actual modeled hole.

## Derived Panel Variables To Add

These should usually stay in the Equation Manager, not the design table.

```text
"panel_top_len_in" = "drum_len_in"
"panel_top_wid_in" = "drum_wid_in"
"panel_top_thk_in" = "top_thk_in"

"panel_bottom_len_in" = "drum_len_in"
"panel_bottom_wid_in" = "drum_wid_in"
"panel_bottom_thk_in" = "bottom_thk_in"

"side_panel_len_in" = "drum_len_in"
"side_panel_hgt_in" = "drum_hgt_in" - "top_thk_in" - "bottom_thk_in"
"side_panel_thk_in" = "side_thk_in"

"end_panel_wid_in" = "drum_wid_in" - 2 * "side_thk_in"
"end_panel_hgt_in" = "side_panel_hgt_in"
"end_panel_thk_in" = "end_cap_thk_in"
```

If you later use rabbets, dados, lips, or proud top/bottom panels, add those as
independent inputs before changing the panel formulas.

## Tongue Cut Variables To Add Before Cutting The Top

Keep the scanned magazine pattern as reference geometry. Use these variables for
the cleaned manufacturing sketch that will become the cut feature.

```text
"slot_width_in" = "slit_kerf_in"
"slot_end_rad_in" = "slit_end_rad_in"
"tongue_side_gap_in" = "tongue_gap_in"
"tongue_tip_gap_in" = "tongue_gap_in"
"tongue_root_margin_in" = 0.75in
"tongue_tip_rad_in" = "slot_end_rad_in"
```

For each tongue, keep the measured/selected cut length separate from the physics
estimate:

```text
"t01_est_len_in" = sqr("k_imperial" * "top_thk_in" / "t01_freq_hz")
"t02_est_len_in" = sqr("k_imperial" * "top_thk_in" / "t02_freq_hz")
...
"t16_est_len_in" = sqr("k_imperial" * "top_thk_in" / "t16_freq_hz")
```

Use `t##_len_in` as the actual planned cut length for CAD and tuning, especially
for `Small_Baseline_6T`, where the magazine/traced geometry is a better starting
point than the rough beam estimate.

## Design Table Consistency Rules

For every configuration:

```text
t##_bank = 0  -> t##_len_in = 0in and t##_wid = 0in
t##_bank > 0  -> t##_len_in > 0in and t##_wid > 0in
bank_l_count  -> count of t##_bank = 1
bank_r_count  -> count of t##_bank = 2
```

Current audit findings to fix in the design table:

```text
MASTER_TEMPLATE:       t15_bank is active, but t15_wid = 0in
Large_Bilateral_16T:   t15_bank is active, but t15_wid = 0in
Large_Bilateral_14T:   t14_bank is active, but t14_wid = 0in
```

Set inactive tongue widths to `0in` in the medium and small configs so dormant
geometry does not accidentally drive future tongue sketches.

## First Child-Part Pass

Create solids in this order:

```text
TNG-101_TopSoundboard.SLDPRT
TNG-102_BottomPanel.SLDPRT
TNG-103_LongSidePanel.SLDPRT
TNG-104_EndPanel.SLDPRT
TNG-105_Foot.SLDPRT or OTS foot placeholder
```

For the first pass, make only the rectangular panel solids. Add tongue cuts,
ports, screw holes, edge treatments, and hardware after the panels rebuild
correctly from `Small_Baseline_6T`.
