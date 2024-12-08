`timescale 1ns/1ps



module controlUnit_tb;

    // Inputs
    reg [31:0] INSTRUCTION;

    // Outputs
    wire [4:0] ALU_OPCODE;
    wire [2:0] IMMEDIATE_TYPE;
    wire WRITE_ENABLE, MEMORY_ACCESS, MEM_WRITE, MEM_READ, JUMP_AND_LINK;
    wire IMMEDIATE_SELECT, OFFSET_GENARATOR, BRANCH, JUMP;

    // Instantiate the controlUnit module
    controlUnit uut (
        .INSTRUCTION(INSTRUCTION),
        .ALU_OPCODE(ALU_OPCODE),
        .IMMEDIATE_TYPE(IMMEDIATE_TYPE),
        .WRITE_ENABLE(WRITE_ENABLE),
        .MEMORY_ACCESS(MEMORY_ACCESS),
        .MEM_WRITE(MEM_WRITE),
        .MEM_READ(MEM_READ),
        .JUMP_AND_LINK(JUMP_AND_LINK),
        .IMMEDIATE_SELECT(IMMEDIATE_SELECT),
        .OFFSET_GENARATOR(OFFSET_GENARATOR),
        .BRANCH(BRANCH),
        .JUMP(JUMP)
    );

    initial begin
        // Initialize the input
        INSTRUCTION = 32'b0;

        // Test R-type ADD instruction
        #10 INSTRUCTION = 32'b0000000_00001_00010_000_00011_1100011; // ADD
        #10 $display("ADD Test: ALU_OPCODE=%b", ALU_OPCODE);

        // Test I-type ADDI instruction
        #10 INSTRUCTION = 32'b000000000001_00010_000_00011_0010011; // ADDI
        #10 $display("ADDI Test: ALU_OPCODE=%b", ALU_OPCODE);

        // Test LW instruction
        #10 INSTRUCTION = 32'b000000000001_00010_010_00011_0000011; // LW
        #10 $display("LW Test: MEMORY_ACCESS=%b, MEM_READ=%b", MEMORY_ACCESS, MEM_READ);

        // Test SW instruction
        #10 INSTRUCTION = 32'b0000000_00001_00010_010_00011_0100011; // SW
        #10 $display("SW Test: MEMORY_ACCESS=%b, MEM_WRITE=%b", MEMORY_ACCESS, MEM_WRITE);

        // Test JAL instruction
        #10 INSTRUCTION = 32'b00000000000000000001_00000_1101111; // JAL
        #10 $display("JAL Test: JUMP=%b, JUMP_AND_LINK=%b", JUMP, JUMP_AND_LINK);

        // Test LUI instruction
        #10 INSTRUCTION = 32'b00000000000000000001_00000_0110111; // LUI
        #10 $display("LUI Test: IMMEDIATE_TYPE=%b, ALU_OPCODE=%b", IMMEDIATE_TYPE, ALU_OPCODE);

        // Test B-type instruction (e.g., BEQ)
        #10 INSTRUCTION = 32'b0000000_00001_00010_000_00011_1100011; // BEQ
        #10 $display("BEQ Test: BRANCH=%b, ALU_OPCODE=%b", BRANCH, ALU_OPCODE);

        // Finish simulation
        #10 $finish;
    end
endmodule
