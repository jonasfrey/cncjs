# How to Set Work Zero on the 3018

Work zero (X0 Y0 Z0) tells the machine where your job starts.
You set it by jogging to the right position and pressing the Zero buttons in CNCjs.

---

## Step 1 — Zero X and Y

1. Jog the toolhead to the point on your material where X0 Y0 should be
   - For centered designs (like the spiral or text): jog to the **center** of your workpiece
   - For corner-based designs: jog to the **bottom-left corner**
2. Press **XoYo** in the CNCjs Axes widget

---

## Step 2 — Zero Z

1. Lower Z slowly until the bit **just barely touches** the material surface
   - Paper test: slide a piece of paper under the bit, lower until it drags slightly
2. Press **Zo** in the CNCjs Axes widget

---

## Step 3 — Lift to safe height

After zeroing Z, immediately lift the tool away from the surface:

```gcode
G0 Z5
```

Type this in the MDI console and press Enter.

---

## Step 4 — Turn spindle on

Type this in the MDI console before starting the job:

```gcode
M3
```

---

## Step 5 — Run the job

Load your `.nc` or `.gcode` file and press **Cycle Start**.

---

## Setting zero with gcode (MDI console)

If you prefer typing gcode directly instead of clicking buttons:

```gcode
G10 L20 P1 X0 Y0 Z0   ( zero all axes at once )
G10 L20 P1 X0 Y0      ( zero X and Y only )
G10 L20 P1 Z0         ( zero Z only )
```

Type these in the CNCjs MDI console and press Enter.
`G10 L20 P1` writes to the G54 work coordinate system and is saved permanently.

---

## Notes

- The Zero buttons in CNCjs send `G10 L20 P1` — this is saved to the machine and survives a reset
- Do **not** use `G92` for zeroing — it is lost if the machine resets mid-job
- Z zero = top surface of your material, not the wasteboard underneath
- If the bit is too high when you zero Z, the job cuts air. Too low, and it cuts deeper than expected.
