# EVM on FPGA

Electronic Voting Machine implementation for FPGA with 7-segment display.

## Features

- 3-candidate voting system
- Button debouncing
- 7-segment display for results
- LED winner indication
- Vote limit: 9 votes per candidate

## Ports

| Port | Type | Description |
|------|------|-------------|
| clk | Input | 100 MHz clock |
| vote_enable | Input | Enable voting |
| A, B, C | Input | Vote buttons |
| rst | Input | Reset |
| display[6:0] | Output | 7-segment display |
| an[3:0] | Output | Display anode control |
| ledA, ledB, ledC | Output | Winner LEDs |

## Usage

1. Set `vote_enable = 1` to start voting
2. Press A, B, or C buttons to cast votes
3. Set `vote_enable = 0` to display results
4. LED lights up for winner

## Waveform

<img width="1550" height="563" alt="Screenshot 2025-12-11 122418" src="https://github.com/user-attachments/assets/3e6ef350-c864-4672-85a1-ec39433a6b1a" />

## Files

```
src/
├── evm_display_three_candidates.v
└── evm_tb.v
```

