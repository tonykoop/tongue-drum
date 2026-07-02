// MakerBench Code-CAD Arena - Tongue Drum (pitched idiophone)
// Design: Single-body Parametric Tongue Drum
// Family: Idiophone
// Acoustic Model: Cantilever Tongue Idiophone (with Helmholtz Box Coupling)
//
// DESIGN FOR MANUFACTURING (DFM) NOTES:
// 1. Stress Concentration: Base of the U-slots feature stress-relief holes to prevent splitting.
// 2. Printability: Print this part upside down (soundboard on the build plate) to get a flawless 
//    top finish and avoid internal support structures.
// 3. Acoustic Coupling: Calculated Helmholtz resonance frequency is logged to the console.
// 4. Resonance Decoupling: Four feet are integrated at the bottom to isolate the drum from surfaces.

/* [General Box Dimensions] */
// Length of the drum box (mm)
box_l = 300; // [250:350]
// Width of the drum box (mm)
box_w = 200; // [180:250]
// Height of the drum box (mm)
box_h = 100; // [80:150]
// Corner radius of the box (mm)
corner_radius = 15; // [5:25]
// Outer wall thickness (mm)
wall = 5; // [3:10]
// Top plate / soundboard thickness (mm)
top_thickness = 5; // [3:10]
// Bottom plate thickness (mm)
bottom_thickness = 5; // [3:10]

/* [Tongue Settings] */
// Number of tongues (6 to 8)
tongue_count_select = 8; // [6:8]
// Spacing between tongues (mm)
tongue_spacing = 10; // [6:20]
// Width of the slot cut / kerf (mm)
kerf = 2.5; // [1.5:4.0]
// Margin from the inner walls in the Y direction (mm)
margin_y = 20; // [10:40]
// Arrangement of the tongues
tongue_layout = "Alternating"; // [Alternating, Parallel]
// Diameter of the stress relief holes at fixed ends (mm, set 0 to disable)
relief_dia = 5; // [0:8]

/* [Material Settings] */
// Select the material to drive acoustic properties
material_choice = "Cherry"; // [Padauk, Wenge, Hard Maple, Cherry, Black Walnut, White Oak, Baltic Birch Ply, Mahogany, Western Red Cedar, PLA_3DPrint]

/* [Visual & Label Options] */
// Theme for visualization colors
visual_theme = "Classic Wood"; // [Classic Wood, Dark Mode, Sunset Glow, Arctic Mint]
// Font size for note engraving (mm)
text_size = 7; // [4:12]
// Engraving depth for labels (mm)
text_depth = 0.8; // [0.2:2.0]
// Decouple feet at bottom to allow resonance
add_feet = true;
foot_height = 5; // [2:10]
foot_radius = 8; // [4:15]

/* [Acoustic Material Data] */
// Returns metric K factor: K_metric = K_imperial * 25.4
// For PLA, a validated metric value is used directly.
function get_material_k(material) =
    (material == "Padauk")            ? 24438 * 25.4 :
    (material == "Wenge")             ? 27103 * 25.4 :
    (material == "Hard Maple")        ? 26887 * 25.4 :
    (material == "Cherry")            ? 27275 * 25.4 :
    (material == "Black Walnut")      ? 27734 * 25.4 :
    (material == "White Oak")         ? 25419 * 25.4 :
    (material == "Baltic Birch Ply")  ? 24389 * 25.4 :
    (material == "Mahogany")          ? 26314 * 25.4 :
    (material == "Western Red Cedar") ? 29013 * 25.4 :
    (material == "PLA_3DPrint")       ? 271350 : 
    27000 * 25.4; // Default fallback

K_metric = get_material_k(material_choice);

// Full C-major pentatonic scale table (8 notes)
// Format: [Note Name, Frequency (Hz), Width (mm), Length Override (mm)]
// Length override of 0 forces calculation from frequency and thickness.
tongues_table = [
    ["C4", 261.63, 22, 0],
    ["D4", 293.66, 22, 0],
    ["E4", 329.63, 22, 0],
    ["G4", 392.00, 22, 0],
    ["A4", 440.00, 22, 0],
    ["C5", 523.25, 22, 0],
    ["D5", 587.33, 22, 0],
    ["E5", 659.25, 22, 0]
];

// Slice the table to the user-selected count
tongues = [
    for (i = [0 : tongue_count_select - 1]) tongues_table[i]
];

// Pre-calculate tongue lengths: L = sqrt(K_metric * t / f)
function calc_length(freq, override, t, K) =
    (override > 0) ? override : sqrt(K * t / freq);

lengths = [
    for (i = [0 : len(tongues)-1]) calc_length(tongues[i][1], tongues[i][3], top_thickness, K_metric)
];

// Recursive sum function
function sum(list, idx=0) = 
    (idx >= len(list)) ? 0 : list[idx] + sum(list, idx + 1);

// Calculate total width and layout centering
widths = [ for (t = tongues) t[2] ];
total_tongues_width = sum(widths) + (len(tongues) - 1) * tongue_spacing;
start_x = (box_l - total_tongues_width) / 2 + tongues[0][2]/2;

// Recursive width summing helper
function sum_widths(i) = (i <= 0) ? 0 : tongues[i-1][2] + sum_widths(i-1);

// Compute center X of tongue i
function get_center_x(i) = 
    (i == 0) ? start_x : 
    start_x + sum_widths(i) - tongues[0][2]/2 + tongues[i][2]/2 + i * tongue_spacing;

// Helmholtz Chamber Analysis
box_cavity_volume = (box_l - 2*wall) * (box_w - 2*wall) * (box_h - bottom_thickness - top_thickness);
V_m3 = box_cavity_volume / 1e9;
slot_areas = [ 
    for (i = [0 : len(tongues)-1]) 
    let(L = lengths[i], W = tongues[i][2]) 
    (2 * L + W + 2 * kerf) * kerf 
];
total_slot_area = sum(slot_areas);
A_m2 = total_slot_area / 1e6;
L_eff_m = (top_thickness + 0.6 * kerf) / 1000;
c = 343; // Speed of sound in m/s
f_helmholtz = (c / (2 * 3.14159265)) * sqrt(A_m2 / (V_m3 * L_eff_m));

// Output acoustic metrics to console
echo("========================================");
echo("MAKERSBENCH TONGUE DRUM REPORT");
echo("Selected Material: ", material_choice);
echo("Effective K-constant: ", K_metric);
echo("Box Cavity Volume (cm^3): ", box_cavity_volume / 1000);
echo("Total Vent Area (mm^2): ", total_slot_area);
echo("Calculated Helmholtz Frequency (Hz): ", f_helmholtz);
echo("Acoustically Coupled (200-600Hz): ", (f_helmholtz >= 200 && f_helmholtz <= 600) ? "✓ Yes" : "✗ No (Adjust box height/thickness)");
echo("========================================");

// Theme Palette Setup
function get_theme_colors(theme) =
    (theme == "Dark Mode")   ? ["#222222", "#333333", "#00ffcc", "#ffffff"] :
    (theme == "Sunset Glow") ? ["#4a154b", "#e01e5a", "#ecb22e", "#ffffff"] :
    (theme == "Arctic Mint") ? ["#2d3748", "#e2e8f0", "#38b2ac", "#1a202c"] :
    ["#5c4033", "#e8d3a7", "#2b1e17", "#4e3629"]; // Default "Classic Wood"

theme_colors = get_theme_colors(visual_theme);
color_box    = theme_colors[0];
color_plate  = theme_colors[1];
color_slots  = theme_colors[2];
color_text   = theme_colors[3];

// 2D Rounded Box Module
module rounded_box(size, r) {
    x = size[0];
    y = size[1];
    z = size[2];
    hull() {
        translate([r, r, 0]) cylinder(h=z, r=r, $fn=64);
        translate([x-r, r, 0]) cylinder(h=z, r=r, $fn=64);
        translate([r, y-r, 0]) cylinder(h=z, r=r, $fn=64);
        translate([x-r, y-r, 0]) cylinder(h=z, r=r, $fn=64);
    }
}

// 2D Tongue Cut Profile (U-slot and stress reliefs)
module tongue_cut(cx, base_y, L, W, direction, kerf, relief_dia) {
    if (direction == 1) {
        // Slots
        translate([cx - W/2 - kerf, base_y]) square([kerf, L]);
        translate([cx + W/2, base_y]) square([kerf, L]);
        translate([cx - W/2 - kerf, base_y + L]) square([W + 2*kerf, kerf]);
        // Stress Relief Holes at fixed ends
        if (relief_dia > 0) {
            translate([cx - W/2 - kerf/2, base_y]) circle(d = relief_dia, $fn=32);
            translate([cx + W/2 + kerf/2, base_y]) circle(d = relief_dia, $fn=32);
        }
    } else {
        // Slots
        translate([cx - W/2 - kerf, base_y - L]) square([kerf, L]);
        translate([cx + W/2, base_y - L]) square([kerf, L]);
        translate([cx - W/2 - kerf, base_y - L - kerf]) square([W + 2*kerf, kerf]);
        // Stress Relief Holes at fixed ends
        if (relief_dia > 0) {
            translate([cx - W/2 - kerf/2, base_y]) circle(d = relief_dia, $fn=32);
            translate([cx + W/2 + kerf/2, base_y]) circle(d = relief_dia, $fn=32);
        }
    }
}

// 2D Cuts Wrapper
module 2d_cuts() {
    for (i = [0 : len(tongues)-1]) {
        cx = get_center_x(i);
        dir = (tongue_layout == "Alternating") ? ((i % 2 == 0) ? 1 : -1) : 1;
        base_y = (dir == 1) ? (wall + margin_y) : (box_w - wall - margin_y);
        L = lengths[i];
        W = tongues[i][2];
        tongue_cut(cx, base_y, L, W, dir, kerf, relief_dia);
    }
}

// Engraved Labels Module
module tongue_label(cx, base_y, direction, L, note_name, text_depth, text_size) {
    y_pos = direction == 1 ? base_y + L * 0.25 : base_y - L * 0.25;
    translate([cx, y_pos, box_h - text_depth])
        linear_extrude(height = text_depth + 0.1)
            text(note_name, size = text_size, font = "Liberation Sans:style=Bold", halign = "center", valign = "center");
}

module labels() {
    for (i = [0 : len(tongues)-1]) {
        cx = get_center_x(i);
        dir = (tongue_layout == "Alternating") ? ((i % 2 == 0) ? 1 : -1) : 1;
        base_y = (dir == 1) ? (wall + margin_y) : (box_w - wall - margin_y);
        note_name = tongues[i][0];
        L = lengths[i];
        tongue_label(cx, base_y, dir, L, note_name, text_depth, text_size);
    }
}

// Main 3D Model Assembly
difference() {
    union() {
        // Main Hollow Box Body
        color(color_box)
            difference() {
                // Outer box envelope
                rounded_box([box_l, box_w, box_h], corner_radius);
                // Internal cavity
                translate([wall, wall, bottom_thickness])
                    rounded_box(
                        [box_l - 2*wall, box_w - 2*wall, box_h - bottom_thickness - top_thickness + 0.01], 
                        max(1, corner_radius - wall)
                    );
            }
        
        // Decoupling Feet
        if (add_feet) {
            color(color_box) {
                translate([corner_radius, corner_radius, -foot_height])
                    cylinder(h=foot_height, r=foot_radius, $fn=64);
                translate([box_l - corner_radius, corner_radius, -foot_height])
                    cylinder(h=foot_height, r=foot_radius, $fn=64);
                translate([corner_radius, box_w - corner_radius, -foot_height])
                    cylinder(h=foot_height, r=foot_radius, $fn=64);
                translate([box_l - corner_radius, box_w - corner_radius, -foot_height])
                    cylinder(h=foot_height, r=foot_radius, $fn=64);
            }
        }
    }
    
    // Extrude and subtract the 2D tongue slots from the top plate
    color(color_slots)
        translate([0, 0, box_h - top_thickness - 1])
            linear_extrude(height = top_thickness + 2)
                2d_cuts();
                
    // Subtract engraved note labels
    color(color_text)
        labels();
}