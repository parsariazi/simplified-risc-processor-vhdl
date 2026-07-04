# Simplified Single-Cycle RISC Processor in VHDL

<p align="center">

![VHDL](https://img.shields.io/badge/Language-VHDL-blue)
![Vivado](https://img.shields.io/badge/Tool-Xilinx%20Vivado-red)
![Architecture](https://img.shields.io/badge/Architecture-Single--Cycle-success)
![License](https://img.shields.io/badge/License-MIT-green)

</p>

---

## Overview

This project presents the implementation of a **simplified single-cycle RISC processor** using **VHDL**.

The processor was designed as a Computer Architecture course project to demonstrate the fundamental concepts of CPU design, including instruction fetch, instruction decode, register operations, ALU execution, memory access, and write-back.

The design follows a **single-cycle datapath**, where every instruction is completed within one clock cycle.

---

## Processor Architecture

<p align="center">
<img src="images/datapath.png" width="900">
</p>

The processor consists of the following hardware modules:

- Program Counter (PC)
- Instruction Memory
- Register File
- Immediate Generator
- Arithmetic Logic Unit (ALU)
- Data Memory
- Control Unit

---

# Features

- Single-Cycle Processor Architecture
- Modular VHDL Design
- 32-bit Datapath
- 32 General Purpose Registers
- Instruction Memory
- Data Memory
- Immediate Generator
- ALU
- Control Logic
- Simulation Testbench
- Vivado Compatible

---

# Project Structure

```text
simplified-risc-processor-vhdl
│
├── src
│   ├── ALUmod.vhd
│   ├── ControlUnit.vhd
│   ├── DataMemory.vhd
│   ├── ImmediateGenerator.vhd
│   ├── InstructionMemory.vhd
│   ├── ProgramCounter.vhd
│   ├── RegisterFile.vhd
│   └── TopModule.vhd
│
├── tb
│   └── TopModule_tb.vhd
│
├── images
│   └── datapath.png
│
├── docs
│   └── REPORT.pdf
│
├── README.md
├── LICENSE
└── .gitignore
```

---

# Hardware Modules

## Program Counter

- Stores the current instruction address.
- Increments by **4** every clock cycle.
- Supports reset operation.

---

## Instruction Memory

- Stores program instructions.
- 64-byte memory.
- Little-endian organization.
- Outputs one 32-bit instruction.

---

## Register File

- 32 registers
- 32-bit width
- Two read ports
- One write port
- Synchronous write
- Asynchronous read

---

## Immediate Generator

Generates 32-bit sign-extended immediate values from 12-bit instruction fields.

Supports Immediate instructions.

---

## Arithmetic Logic Unit (ALU)

Supported operations:

| ALUSel | Operation |
|---------|-----------|
| 00 | ADD |
| 01 | SUB |
| 10 | AND |
| 11 | OR |

---

## Data Memory

Supports:

- Load Word (LW)
- Store Word (SW)

Memory organization:

- 64 Bytes
- Little-endian

---

## Control Unit

Generates all processor control signals.

Output signals include:

- ALUSel
- BSel
- RegWEn
- MemRW
- MemToReg

---

# Supported Instructions

Current implementation supports the following instruction classes:

- R-Type
- I-Type
- Load (LW)
- Store (SW)

Implemented ALU operations include:

- ADD
- SUB
- AND
- OR

---

# Datapath Flow

Instruction execution follows the sequence:

```
PC
 ↓
Instruction Memory
 ↓
Instruction Decode
 ↓
Control Unit
 ↓
Register File
 ↓
Immediate Generator
 ↓
ALU
 ↓
Data Memory
 ↓
Write Back
```

---

# Simulation

Simulation is performed using:

- Xilinx Vivado

A dedicated testbench is included:

```
tb/TopModule_tb.vhd
```

The testbench generates:

- Clock signal
- Reset signal
- Instruction execution

---

# Requirements

Software

- Xilinx Vivado

Language

- VHDL

---

# Future Improvements

Possible future extensions include:

- Branch Instructions
- Jump Instructions
- Pipeline Architecture
- Hazard Detection
- Forwarding Unit
- Branch Prediction
- Larger Instruction Memory
- External Program Loading
- UART Interface
- FPGA Deployment

---

# Author

**Parsa Riazi**

Computer Engineering Student

GitHub:

https://github.com/parsariazi

---

# License

This project is released under the MIT License.
