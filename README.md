# RISC-V-Processor-Implementation-Single-Cycle-Pipelined-Designs
Welcome to the repository for my comprehensive RISC-V processor project. This repository houses the implementation of both a Single Cycle and a Pipelined RISC-V processor design, accompanied by detailed documentation, simulation results, synthesis reports, and timing analyses.

# Overview
This project explores modern processor design using the RISC-V Instruction Set Architecture (ISA) as the foundation. It includes:

# RISC-V ISA Documentation:
An in-depth overview of the RISC-V base integer instructions (RV32I/RV64I), covering arithmetic, logical, branch, jump, load, and store operations.

# Single Cycle Design:
A straightforward implementation where each instruction is executed in a single clock cycle. This design simplifies control logic and data path routing while serving as a platform for validating the core functionalities of the RISC-V ISA.

# Pipelined Design:
A high-performance implementation that divides instruction execution into five stages (IF, ID, EX, MEM, WB), incorporating hazard detection and data forwarding mechanisms to achieve improved throughput.

Detailed Design Blocks:
Comprehensive design documentation including:

Instruction Fetch: Program Counter (PC) with PC Adder4, and Instruction Memory.

Instruction Decode: Register File, Control Unit, and Immediate Extender.

Execution: ALU, Branch and Jump Logic.

Memory Access & Write Back: Data Memory and Write Back Multiplexer.

![Risc V pipelined](./Risc v.png)

# Verification & Simulation:
Testbenches, simulation waveform data, RTL descriptions, synthesis results, and timing analyses confirm the correctness and performance of the designs.

