// license Jonas Immanuel Frey GPL

// --- parameters ---
text_content   = "Hello";
font_size      = 20;       // mm
extrude_depth  = 3;        // mm — how tall/thick the letters are
font_name      = "Liberation Sans:style=Bold";
add_base_plate = true;     // flat plate underneath the text
base_thickness = 2;        // mm — thickness of base plate
base_padding   = 3;        // mm — extra space around text on base plate

// --- text object ---
linear_extrude(height = extrude_depth)
    text(text_content, size = font_size, font = font_name, halign = "center", valign = "center");

// --- optional base plate ---
if (add_base_plate) {
    text_width  = len(text_content) * font_size * 0.65;  // rough estimate
    text_height = font_size;

    translate([0, 0, -base_thickness])
        translate([- text_width / 2 - base_padding, -text_height / 2 - base_padding, 0])
            cube([text_width + base_padding * 2, text_height + base_padding * 2, base_thickness]);
}
