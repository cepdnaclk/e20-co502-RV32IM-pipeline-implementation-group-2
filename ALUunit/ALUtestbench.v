
module tb_alu;
    // Testbench signals
    reg [31:0] data1, data2;
    reg [4:0] ALU_OPCODE;
    wire [31:0] Output;

    // Instantiate the ALU module
    alu uut (
        .data1(data1),
        .data2(data2),
        .ALU_OPCODE(ALU_OPCODE),
        .Output(Output)
    );

    integer i;

    initial begin
        // Initialize inputs
        $monitor("Time: %0t | ALU_OPCODE: %b | data1: %d | data2: %d | Output: %d", 
                 $time, ALU_OPCODE, data1, data2, Output);
        
        // Test ADD
        data1 = 32'd10;
        data2 = 32'd20;
        ALU_OPCODE = 5'b00000; // ADD
        #10;

        // Test SUB
        ALU_OPCODE = 5'b00001; // SUB
        #10;

        // Test OR
        ALU_OPCODE = 5'b00010; // OR
        #10;

        // Test XOR
        ALU_OPCODE = 5'b00011; // XOR
        #10;

        // Test AND
        ALU_OPCODE = 5'b00100; // AND
        #10;

        // Test Shift Right
        ALU_OPCODE = 5'b00101; // SLR
        #10;

        // Test Shift Left
        ALU_OPCODE = 5'b00110; // SLL
        #10;

        // Test Arithmetic Shift Right
        ALU_OPCODE = 5'b00111; // SRA
        #10;

        // Test MUL
        ALU_OPCODE = 5'b01000; // MUL
        #10;

        // Test MULH
        ALU_OPCODE = 5'b01001; // MULH
        #10;

        // Test MULHU
        ALU_OPCODE = 5'b01010; // MULHU
        #10;

        // Test MULHSU
        ALU_OPCODE = 5'b01011; // MULHSU
        #10;

        // Test DIV
        ALU_OPCODE = 5'b01100; // DIV
        #10;

        // Test DIVU
        ALU_OPCODE = 5'b01101; // DIVU
        #10;

        // Test REM
        ALU_OPCODE = 5'b01110; // REM
        #10;

        // Test REMU
        ALU_OPCODE = 5'b01111; // REMU
        #10;

        // Test SLT
        ALU_OPCODE = 5'b10000; // SLT
        #10;

        // Test Forwarding
        ALU_OPCODE = 5'b10001; // Forwarding
        #10;

        // Test default case
        ALU_OPCODE = 5'b11111; // Default
        #10;

        // Finish simulation
        $finish;
    end
endmodule
