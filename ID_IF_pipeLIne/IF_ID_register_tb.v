

module TB_ID_IF_register;
    // Inputs
    reg CLK;
    reg RESET;
    reg [31:0] INSTRUCTION;
    reg [31:0] PC;
    reg [31:0] PC_PLUS_4;

    // Outputs
    wire [31:0] INSTRUCTION_OUT;
    wire [31:0] PC_OUT;
    wire [31:0] PC_PLUS_4_OUT;

    // Instantiate the module
    ID_IF_register uut (
        .CLK(CLK),
        .RESET(RESET),
        .INSTRUCTION(INSTRUCTION),
        .PC(PC),
        .PC_PLUS_4(PC_PLUS_4),
        .INSTRUCTION_OUT(INSTRUCTION_OUT),
        .PC_OUT(PC_OUT),
        .PC_PLUS_4_OUT(PC_PLUS_4_OUT)
    );

    // Clock generation
    initial begin
        CLK = 0;
        forever #5 CLK = ~CLK;  // 10 ns clock period
    end

    // Test sequence
    initial begin
        // Initialize inputs
        RESET = 1;
        INSTRUCTION = 0;
        PC = 0;
        PC_PLUS_4 = 0;

        // Apply reset
        #10;
        RESET = 0;

        // Apply first set of inputs
        #10;
        INSTRUCTION = 32'hAABBCCDD;
        PC = 32'h00000010;
        PC_PLUS_4 = 32'h00000014;

        // Wait for the register to update
        #20;

        // Apply second set of inputs
        INSTRUCTION = 32'h12345678;
        PC = 32'h00000020;
        PC_PLUS_4 = 32'h00000024;

        // Wait for the register to update
        #20;

        // Apply reset again
        RESET = 1;
        #10;
        RESET = 0;

        // Final inputs
        INSTRUCTION = 32'hFFFFFFFF;
        PC = 32'h00000030;
        PC_PLUS_4 = 32'h00000034;

        // Wait and finish
        #20;
        $finish;
    end

    // Monitor outputs
    initial begin
        $dumpfile("if_id_pipeline.vcd");
        $dumpvars(0, TB_ID_IF_register);
        $monitor("Time: %0d | RESET: %b | CLK: %b | INSTRUCTION: %h | PC: %h | PC_PLUS_4: %h | INSTRUCTION_OUT: %h | PC_OUT: %h | PC_PLUS_4_OUT: %h",
                 $time, RESET, CLK, INSTRUCTION, PC, PC_PLUS_4, INSTRUCTION_OUT, PC_OUT, PC_PLUS_4_OUT);
    end
endmodule
