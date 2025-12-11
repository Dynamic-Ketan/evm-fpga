# EVM FPGA

Electronic Voting Machine implementation on Spartan-7 FPGA with real-time vote counting and winner detection.

## Hardware

- **Board**: Boolean Board (XC7S50-1CSGA324C)
- **FPGA**: Xilinx Spartan-7
- **Clock**: 12 MHz onboard (100 MHz internal)

## Demo

📹 **[Implementation Video]()**

## Features

- 3-candidate voting system with hardware debouncing
- 7-segment display for vote counts (multiplexed)
- LED winner indication
- Vote limit: 9 per candidate
- Reset functionality


### FPGA Implementation
1. Open Vivado targeting XC7S50-1CSGA324C
2. Add files from `src/` and `constraints/`
3. Synthesize → Implement → Generate Bitstream
4. Program via JTAG

## Usage

1. `vote_enable = 1` → Cast votes using A/B/C buttons
2. `vote_enable = 0` → Display results and winner LED

## Project Structure

```
├── src/ # RTL design and testbench
├── constraints/ # XDC files for Boolean board
└── waveform.png # Simulation result
```

## Implemented by:

**Ketan** - [GitHub](https://github.com/Dynamic-Ketan)
**Naman Malhotra** - [GitHub](https://github.com/naman-vlsi-vision)

---
