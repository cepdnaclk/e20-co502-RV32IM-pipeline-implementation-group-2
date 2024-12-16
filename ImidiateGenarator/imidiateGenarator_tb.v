module immediateGenerator_tb;

    // Testbench inputs and outputs
    reg [31:0] INSTRUCTION;
    reg [2:0] IMMEDIATE_TYPE;
    wire [31:0] IMMEDIATE_VALUE;

    // Instantiate the module under test
    imidiateGenarator uut (
        .INSTRUCTION(INSTRUCTION),
        .IMMEDIATE_TYPE(IMMEDIATE_TYPE),
        .IMMEDIATE_VALUE(IMMEDIATE_VALUE)
    );

    // Test sequence
    initial begin
        $display("Testbench started...");

        // Test case 1: IMMEDIATE_TYPE = 3'b000
        INSTRUCTION = 32'b00010010001101000101011001111000; // Example instruction
        IMMEDIATE_TYPE = 3'b000;
        #10; 
       $display("IMMEDIATE_VALUE = %b %b %b %b %b %b %b %b",
    IMMEDIATE_VALUE[31:28], IMMEDIATE_VALUE[27:24],
    IMMEDIATE_VALUE[23:20], IMMEDIATE_VALUE[19:16],
    IMMEDIATE_VALUE[15:12], IMMEDIATE_VALUE[11:8],
    IMMEDIATE_VALUE[7:4], IMMEDIATE_VALUE[3:0]);

        // Test case 2: IMMEDIATE_TYPE = 3'b001
        INSTRUCTION = 32'b10000111011001010100001100100001; // Example instruction
        IMMEDIATE_TYPE = 3'b001;
        #10; 
       $display("IMMEDIATE_VALUE = %b %b %b %b %b %b %b %b",
    IMMEDIATE_VALUE[31:28], IMMEDIATE_VALUE[27:24],
    IMMEDIATE_VALUE[23:20], IMMEDIATE_VALUE[19:16],
    IMMEDIATE_VALUE[15:12], IMMEDIATE_VALUE[11:8],
    IMMEDIATE_VALUE[7:4], IMMEDIATE_VALUE[3:0]);

        // Test case 3: IMMEDIATE_TYPE = 3'b010
        INSTRUCTION = 32'b11111110110111001011101010011000; // Example instruction
        IMMEDIATE_TYPE = 3'b010;
        #10; 
       $display("IMMEDIATE_VALUE = %b %b %b %b %b %b %b %b",
    IMMEDIATE_VALUE[31:28], IMMEDIATE_VALUE[27:24],
    IMMEDIATE_VALUE[23:20], IMMEDIATE_VALUE[19:16],
    IMMEDIATE_VALUE[15:12], IMMEDIATE_VALUE[11:8],
    IMMEDIATE_VALUE[7:4], IMMEDIATE_VALUE[3:0]);

        // Test case 4: IMMEDIATE_TYPE = 3'b011
        INSTRUCTION = 32'b00001010101111001101111011110000; // Example instruction
        IMMEDIATE_TYPE = 3'b011;
        #10; 
       $display("IMMEDIATE_VALUE = %b %b %b %b %b %b %b %b",
    IMMEDIATE_VALUE[31:28], IMMEDIATE_VALUE[27:24],
    IMMEDIATE_VALUE[23:20], IMMEDIATE_VALUE[19:16],
    IMMEDIATE_VALUE[15:12], IMMEDIATE_VALUE[11:8],
    IMMEDIATE_VALUE[7:4], IMMEDIATE_VALUE[3:0]);

        // Test case 5: IMMEDIATE_TYPE = 3'b100
        INSTRUCTION = 32'b10100001101100101100001111010100; // Example instruction
        IMMEDIATE_TYPE = 3'b100;
        #10; 
        $display("IMMEDIATE_VALUE = %b %b %b %b %b %b %b %b",
    IMMEDIATE_VALUE[31:28], IMMEDIATE_VALUE[27:24],
    IMMEDIATE_VALUE[23:20], IMMEDIATE_VALUE[19:16],
    IMMEDIATE_VALUE[15:12], IMMEDIATE_VALUE[11:8],
    IMMEDIATE_VALUE[7:4], IMMEDIATE_VALUE[3:0]);

        $display("Testbench finished.");
        $finish;
    end

endmodule
