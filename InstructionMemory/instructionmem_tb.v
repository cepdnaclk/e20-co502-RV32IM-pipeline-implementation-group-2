`include "instructionmem.v"

module tb_instruction_memory;

    reg CLK;
    reg RESET;
    reg [31:0] PC;
    wire [31:0] INSTRUCTION;

    // Instantiate instruction memory
    instruction_memory imem (
        .CLK(CLK),
        .RESET(RESET),
        .PC(PC),
        .INSTRUCTION(INSTRUCTION)
    );

    // Clock generation
    always #5 CLK = ~CLK;

    // Test sequence
    initial begin
        // Initialize
        CLK = 0;
        RESET = 1;
        PC = 0;

        // Release reset
        #10 RESET = 0;

        // Test fetching instructions
        #10 PC = 32'd0;  // First instruction
        #10 PC = 32'd4;  // Second instruction
        #10 PC = 32'd8;  // Third instruction
        #10 PC = 32'd12; // Fourth instruction
        #10 PC = 32'd16; // Fifth instruction

        // Finish simulation
        #20 $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time=%0t | PC=%h | INSTRUCTION=%b", $time, PC, INSTRUCTION);
    end

endmodule
