## Simon Game Implementation using RISC-V Assembly

### Overview

This repository contains the implementation of the classic memory game "Simon" using RISC-V Assembly language. The project is a part of CSC258 coursework, developed by Philip Huang. The game simulates the original Simon game, where players must repeat increasingly complex sequences of lights.

### Prerequisites

Before you begin, ensure you have the following software installed:

- **Ripes**: A graphical RISC-V computer simulator. Download Ripes from [here](https://github.com/mortbopet/Ripes/releases/tag/v2.2.4).

### Setup Instructions

1. **Download Ripes**: If you haven't already, download and install Ripes from the link above.

2. **Load the Program in Ripes**:
    - Open Ripes.
    - Go to `File` -> `Load Program`.
    - Select the `starter.s` file from this repository and click `Open`.

3. **Processor Configuration**:
    - Click the processor icon at the top right corner.
    - Ensure that you are using a `32-bit Single-cycle` processor.

4. **I/O Configuration**:
    - On the left sidebar, select `I/O` -> double-click `D-Pad` and `LED Matrix`.
    - On the right panel, locate `LED Matrix 0`. Set the `height` and `width` to `2` and `2`.
    - Adjust the `size` parameter as desired (1-100).
    - In the middle section, extract both `D-Pad 0` and `LED Matrix 0`.

5. **Start the Game**:
    - Click `Fast Execution` at the top to start the game.

### Game Instructions

1. **Game Start**:
    - The console will display the current level's difficulty, indicating the number of LEDs that will light up in this round.
    - LEDs will light up in a random order. Once all LEDs turn off, press the corresponding buttons on the D-Pad in the same order.

2. **D-Pad Controls**:
    - `UP`: Top Left LED
    - `DOWN`: Top Right LED
    - `LEFT`: Bottom Left LED
    - `RIGHT`: Bottom Right LED

3. **Gameplay**:
    - After each button press, the corresponding LED will light up if correct.
    - If the sequence is correct, all LEDs will turn green, and the difficulty will increase for the next round.
    - If a mistake is made, all LEDs will turn red, and the game will exit.
    - Press `UP` to proceed to the next round or any other button to exit the game.

4. **Restarting the Game**:
    - Click the `Reset` button at the top and repeat the setup steps to restart the game.

### Troubleshooting

- If you encounter any errors or bugs, try resetting the game or restarting Ripes.

### Files

- `starter.s`: The main assembly code for the Simon game.