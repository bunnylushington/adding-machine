# Adding Machine: Mechanical Soundscape

This project is a generative soundscape designed for a production of Elmer Rice's mid-century Expressionist play, *The Adding Machine*. The music reflects the dehumanizing monotony of the machine age through industrial textures, digital decay (bit-crunching), and a persistent 5/4 "unnatural" clock pulse.

## Core Sonic DNA
The entire score is built from a shared palette of synthesized sounds:
- **The Clock (5/4 Pulse)**: A rhythmic heartbeat representing the rigid, mechanical passage of time.
- **The Drone**: A morphing, pressurized metallic hum that simulates the claustrophobia of the office and the weight of the system.
- **The Bit-Crunch**: Digital distortion that represents the "data corruption" of the human spirit as it is replaced by the machine.
- **The Typewriter**: High-frequency mechanical stabs with rhythmic echoes, simulating relentless data entry.

---

## File Manifest

### 1. `computer_brain.scd` (Main Theme)
The foundational piece of the production. It features the full ensemble: the 5/4 clock, a heavy 9/4 polyrhythmic bass line, urgent "data alerts" that accelerate over 64 measures, and atmospheric mallet swells. It represents the central nervous system of the machine.

### 2. `scene1_the_bedroom.scd` (Domestic Irritation)
**Context**: Scene 1 - The Bedroom.
**Sonic Focus**: Entrapment and nagging. A heavy, slow clock is paired with a high-pitched, repetitive "nagging" sine-wave pulse.

### 3. `scene2_the_ledger.scd` (The Office)
**Context**: Scene 2 - The Monotony of Labor.
**Sonic Focus**: Pure repetition. It features a "Fluorescent Light" hum drone and constant, unvarying typing. The bass is removed to emphasize the thin, cold atmosphere of the accounting floor.

### 4. `scene3_the_breakdown.scd` (The Breakdown)
**Context**: Scene 3 - Mr. Zero's Firing and Outburst.
**Sonic Focus**: System failure. The urgent "Data Alert" alarms accelerate to chaotic speeds, and dense glitch bursts simulate a buffer overload as Zero’s world collapses.

### 5. `scene4_the_party.scd` (The Social Machine)
**Context**: Scene 4 - The Party.
**Sonic Focus**: Hollow Conformity. A "chatter" of mechanical keyboard stabs and high-end glitches that sound like meaningless, fragmented conversation.

### 6. `scene5_the_graveyard.scd` (The Graveyard Hum)
**Context**: Scene 5 - The Graveyard.
**Sonic Focus**: Surreal Guilt. A deep, resonant "wind" drone and occasional "ghostly" mallet rolls that recall the main theme's harmonics in a desolate space.

### 7. `scene6_the_cage.scd` (The Cage)
**Context**: Scene 6 - The Trial and Prison.
**Sonic Focus**: Oppression and Weight. The tempo slows to a heavy 60 BPM. The sound is dominated by the sub-frequency "Rumbly Thud" and a deep, bit-crushed bass with dark, boxy reverb, representing the finality of the system's judgement.

### 8. `scene7_the_elysian_fields.scd` (The Elysian Fields)
**Context**: Scene 7 - The Surreal Afterlife.
**Sonic Focus**: Ethereal Memory. The mechanical elements are softened with long attack envelopes and heavy reverb. The mallet rolls become the primary texture, creating overlapping waves of "ghostly" data notes.

---

## Quick Start for Collaborators (macOS)

This guide is for theater collaborators who need to run the soundscape on their Mac.

### 1. Download the Project
- Go to the [Releases](https://github.com/bunnylushington/adding-machine/releases) page.
- Download the `Source code (zip)` for Version 1.0.0.
- Find the downloaded `.zip` file in your **Downloads** folder and double-click it to unzip.

### 2. Install SuperCollider
- Download and install **SuperCollider** from the official site: [https://supercollider.github.io/](https://supercollider.github.io/)
- Drag the SuperCollider icon to your **Applications** folder.

### 3. Running the Soundscape
1. Open the **SuperCollider** application.
2. Go to `File > Open` and navigate to the unzipped project folder.
3. Select a scene file (e.g., `scene2_the_ledger.scd`) and click **Open**.
4. **Boot the Audio Server**: Press `Cmd + B`. You should see "server running" in green at the bottom right of the window.
5. **Play the Scene**: Click anywhere inside the code (between the parentheses) and press `Cmd + Enter`. *Note: The first time you play a scene, it may take a few seconds to start as the audio engine warms up.*
6. **Stop the Sound**: Press `Cmd + .` (Command and Period) at any time to kill all sound.

*Note: For advanced users, you can also run scenes via Terminal using the command provided in the Execution section below.*

---

## Execution
The pieces are written in SuperCollider (SC). To run a scene from the command line:

```bash
/Applications/SuperCollider.app/Contents/MacOS/sclang scene2_the_ledger.scd
```

*(Note: Ensure your audio output is configured in SuperCollider before running.)*
