# RV32IM Pipeline Implementation - Group 2

A 5-stage pipelined RISC-V processor implementation in Verilog supporting the RV32I base instruction set and M extension (multiplication/division operations).

---

## 📋 Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Pipeline Architecture](#pipeline-architecture)
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Simulation](#simulation)
- [Testing](#testing)
- [Team](#team)
- [Links](#links)

---

## 🔍 Overview

This project implements an **in-order 5-stage pipelined CPU** that conforms to the RISC-V ISA specification. The processor supports:
- **RV32I Base Integer Instruction Set**: The fundamental 32-bit RISC-V integer instruction set
- **M Extension**: Integer multiplication and division instructions

The implementation is written in Verilog HDL and includes comprehensive testbenches for verification and validation.

---

## ✨ Features

- **5-Stage Pipeline**:
  - Instruction Fetch (IF)
  - Instruction Decode (ID)
  - Execute (EX)
  - Memory Access (MEM)
  - Write Back (WB)

- **Hazard Handling**:
  - Data forwarding mechanism
  - Load-use hazard detection and resolution
  - Control hazard handling for branches and jumps

- **Complete Instruction Support**:
  - Arithmetic and logical operations
  - Load and store instructions
  - Branch and jump instructions
  - Multiplication and division (M extension)

- **Components**:
  - ALU with multiple operations
  - Register file (32 registers)
  - Instruction and data memory
  - Branch controller
  - Control unit
  - Pipeline registers between stages

---

## 🏗️ Pipeline Architecture

The processor implements a classic 5-stage RISC pipeline:

```
┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐
│    IF    │ -> │    ID    │ -> │    EX    │ -> │   MEM    │ -> │    WB    │
│  Stage   │    │  Stage   │    │  Stage   │    │  Stage   │    │  Stage   │
└──────────┘    └──────────┘    └──────────┘    └──────────┘    └──────────┘
     │               │                │               │               │
  Fetch         Decode          Execute         Memory          Write
Instruction   Instruction      ALU Ops         Access          Back to
from Memory   & Read Regs      & Branch        Data Mem        Registers
```

### Pipeline Stages:
1. **IF (Instruction Fetch)**: Fetches instruction from instruction memory using program counter
2. **ID (Instruction Decode)**: Decodes instruction, reads source registers, generates immediate values
3. **EX (Execute)**: Performs ALU operations, calculates branch targets
4. **MEM (Memory Access)**: Accesses data memory for load/store instructions
5. **WB (Write Back)**: Writes results back to register file

---

## 📁 Project Structure

```
.
├── ALUunit/              # Arithmetic Logic Unit implementation
├── Adder/                # Adder module for PC increment
├── BranchController/     # Branch decision logic
├── ControlUnit/          # Main control unit (instruction decoder)
├── CPU/                  # Top-level CPU module and testbench
├── Data Memory/          # Data memory and cache implementation
├── EX_MEM_pipeline/      # Execute-Memory pipeline register
├── HazardHandling/       # Forwarding unit and hazard detection
├── ID_EXPipeline/        # Decode-Execute pipeline register
├── ID_IF_pipeLIne/       # Fetch-Decode pipeline register
├── ImidiateGenarator/    # Immediate value generator
├── InstructionMemory/    # Instruction memory module
├── MEM_WBPipline/        # Memory-WriteBack pipeline register
├── MUX_32bit/            # Multiplexer modules
├── ProgramCounter/       # Program counter implementation
├── RegisterFile/         # 32-register register file
└── docs/                 # Project documentation
```

---

## 🔧 Prerequisites

To build and simulate this project, you need:

- **Icarus Verilog** (iverilog) - Verilog compiler/simulator
- **GTKWave** - Waveform viewer for analyzing simulation results
- **Make** (optional) - For automated build scripts

### Installation on Ubuntu/Debian:
```bash
sudo apt-get update
sudo apt-get install iverilog gtkwave
```

### Installation on macOS:
```bash
brew install icarus-verilog gtkwave
```

### Installation on Windows:
- Download Icarus Verilog from [bleyer.org/icarus](http://bleyer.org/icarus/)
- Download GTKWave from [gtkwave.sourceforge.net](http://gtkwave.sourceforge.net/)

---

## 🚀 Getting Started

### 1. Clone the Repository
```bash
git clone https://github.com/cepdnaclk/e20-co502-RV32IM-pipeline-implementation-group-2.git
cd e20-co502-RV32IM-pipeline-implementation-group-2
```

### 2. Navigate to CPU Directory
```bash
cd CPU
```

---

## 🎮 Simulation

### Compile and Run Simulation

To compile the CPU design and run the testbench:

```bash
# Compile the Verilog files
iverilog -o CPU_tb.out CPU_tb.v

# Run the simulation
vvp CPU_tb.out
```

This will generate a `cpu_pipeline.vcd` file containing the waveform data.

### View Waveforms

To analyze the simulation results using GTKWave:

```bash
gtkwave cpu_pipeline.vcd
```

Alternatively, if you have a saved GTKWave configuration:

```bash
gtkwave "file for gtk wave.gtkw"
```

---

## 🧪 Testing

The project includes testbenches for individual modules and the complete CPU:

- **CPU Testbench**: `CPU/CPU_tb.v` - Tests the complete pipeline
- **Module Testbenches**: Each major component has its own testbench in its respective directory

### Running Module Tests

Example for testing the ALU:
```bash
cd ALUunit
iverilog -o alu_tb.out alu_tb.v
vvp alu_tb.out
```

### Verification Methodology

The testbench:
1. Initializes the CPU with a reset signal
2. Loads instructions into instruction memory
3. Runs the simulation for a specified number of clock cycles
4. Dumps register and memory contents for verification

---

## 👥 Team

### Team Members
- **E/20/419** - Wakkumbura M.M.S.S. ([e20419@eng.pdn.ac.lk](mailto:e20419@eng.pdn.ac.lk))
- **E/20/439** - Wickramasinghe J.M.W.G.R.L. ([e20439@eng.pdn.ac.lk](mailto:e20439@eng.pdn.ac.lk))
- **E/20/036** - Bandara K.G.R.I. ([e20036@eng.pdn.ac.lk](mailto:e20036@eng.pdn.ac.lk))

### Supervisors
- **Dr. Isuru Nawinne** ([isurunawinne@eng.pdn.ac.lk](mailto:isurunawinne@eng.pdn.ac.lk))

---

## 🔗 Links

- **Project Repository**: [GitHub](https://github.com/cepdnaclk/e20-co502-RV32IM-pipeline-implementation-group-2)
- **Project Page**: [GitHub Pages](https://cepdnaclk.github.io/e20-co502-RV32IM-pipeline-implementation-group-2)
- **Department**: [Computer Engineering, UoP](http://www.ce.pdn.ac.lk/)
- **University**: [University of Peradeniya](https://eng.pdn.ac.lk/)
- **RISC-V Specifications**: [RISC-V ISA Manual](https://riscv.org/technical/specifications/)

---

## 📄 License

This project is part of the CO502 Advanced Computer Architecture course at the University of Peradeniya.

---

## 🙏 Acknowledgments

- University of Peradeniya, Department of Computer Engineering
- CO502 - Advanced Computer Architecture course instructors
- RISC-V Foundation for the ISA specifications
