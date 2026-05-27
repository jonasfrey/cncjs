# G-Code Quick Reference

A practical cheat sheet for the 3018 CNC. "Feed rate" = movement speed in mm/min.

---

## Motion Commands (G-codes)

| Command | Name | What it does |
|---------|------|--------------|
| `G0 X Y Z` | Rapid move | Move at max speed (no cutting) — use for positioning |
| `G1 X Y Z F` | Linear move | Move in a straight line at the given feed rate (cutting move) |
| `G2 X Y Z I J F` | Arc clockwise | Cut a clockwise arc; I/J = arc center offset from current position |
| `G3 X Y Z I J F` | Arc counter-clockwise | Same but counter-clockwise |
| `G4 P` | Dwell | Pause for P milliseconds (e.g. `G4 P500` = wait 0.5s) |

---

## Coordinate & Unit Setup

| Command | What it does |
|---------|--------------|
| `G20` | Use inches |
| `G21` | Use millimetres — always use this on a metric machine |
| `G90` | Absolute positioning — X/Y/Z values are from the work origin (safe default) |
| `G91` | Relative (incremental) positioning — values are offsets from current position |
| `G92 X Y Z` | Set current position as a new origin (e.g. `G92 X0 Y0 Z0` = define current pos as zero) |

---

## Work Coordinate Systems (WCS)

| Command | What it does |
|---------|--------------|
| `G54` | Use work coordinate system 1 (default, most common) |
| `G55`–`G59` | Work coordinate systems 2–6 (useful for multi-fixture setups) |

---

## Tool & Spindle

| Command | What it does |
|---------|--------------|
| `M3 S` | Spindle on, clockwise. S = speed in RPM (e.g. `M3 S10000`) |
| `M4 S` | Spindle on, counter-clockwise |
| `M5` | Spindle off |
| `T1 M6` | Select tool 1 and perform tool change (manual on the 3018) |

> **Note:** The 3018's spindle speed is often fixed or controlled by a separate dial, not by the S value in software.

---

## Program Control

| Command | What it does |
|---------|--------------|
| `M2` | End of program |
| `M30` | End of program + rewind (same effect as M2 on most hobby controllers) |
| `M0` | Program pause — machine stops, resume manually |
| `M1` | Optional stop (pauses if stop switch is active) |

---

## Feed Rate & Speed

| Command | What it does |
|---------|--------------|
| `F` | Feed rate (movement speed) in mm/min — set inline: `G1 X10 F800` |
| `S` | Spindle speed in RPM — set inline: `M3 S10000` |

---

## Plane Selection

| Command | What it does |
|---------|--------------|
| `G17` | XY plane (default for 3-axis — use this always) |
| `G18` | XZ plane |
| `G19` | YZ plane |

---

## Typical Program Structure

```gcode
G21          ; mm units
G90          ; absolute positioning
G17          ; XY plane
M3 S10000    ; spindle on

G0 Z5        ; lift to safe height
G0 X0 Y0     ; go to start position
G1 Z-0.5 F300  ; plunge (slow!) to cutting depth
G1 X50 F800    ; cut to X=50mm at 800mm/min

G0 Z5        ; retract
G0 X0 Y0     ; go home
M5           ; spindle off
M2           ; end
```

---

## Safe Heights

Always rapid (`G0`) at a safe Z height above your workpiece before moving in X/Y.
A common convention: `Z5` for safe travel, `Z0` = top of workpiece, negative Z = cutting into material.

---

## Key Numbers for the 3018

| Parameter | Typical value |
|-----------|--------------|
| Work area | 300 × 180 × 45 mm |
| Safe Z travel height | `Z5` or higher |
| Plunge speed (feed rate down into material) | 100–300 mm/min |
| Cutting speed (feed rate sideways) | 400–1000 mm/min depending on bit and material |
| Max depth per pass | 0.2–0.5 mm for wood/MDF with the 80W spindle |
