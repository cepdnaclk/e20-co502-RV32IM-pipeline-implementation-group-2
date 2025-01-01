module EX_MEM_pipeline_tb;

    // Inputs
    reg CLK;
    reg RESET;
    reg WRITE_ENABLE;
    reg MEM_ACCESS;
    reg MEM_WRITE;
    reg MEM_READ;
    reg [31:0] ALU_OUTPUT;
    reg [31:0] DATA2;
    reg [4:0] WRITE_ADDRESS;
    reg [2:0] FUNCT3;

    // Outputs
    wire WRITE_ENABLE_OUT;
    wire MEM_ACCESS_OUT;
    wire MEM_WRITE_OUT;
    wire MEM_READ_OUT;
    wire [31:0] ALU_OUTPUT_OUT;
    wire [31:0] DATA2_OUT;
    wire [4:0] WRITE_ADDRESS_OUT;
    wire [2:0] FUNCT3_OUT;

    // Instantiate the Unit Under Test (UUT)
    EX_MEM_pipeline uut (
        .CLK(CLK),
        .RESET(RESET),
        .WRITE_ENABLE(WRITE_ENABLE),
        .MEM_ACCESS(MEM_ACCESS),
        .MEM_WRITE(MEM_WRITE),
        .MEM_READ(MEM_READ),
        .ALU_OUTPUT(ALU_OUTPUT),
        .DATA2(DATA2),
        .WRITE_ADDRESS(WRITE_ADDRESS),
        .FUNCT3(FUNCT3),
        .WRITE_ENABLE_OUT(WRITE_ENABLE_OUT),
        .MEM_ACCESS_OUT(MEM_ACCESS_OUT),
        .MEM_WRITE_OUT(MEM_WRITE_OUT),
        .MEM_READ_OUT(MEM_READ_OUT),
        .ALU_OUTPUT_OUT(ALU_OUTPUT_OUT),
        .DATA2_OUT(DATA2_OUT),
        .WRITE_ADDRESS_OUT(WRITE_ADDRESS_OUT),
        .FUNCT3_OUT(FUNCT3_OUT)
    );

    // Clock generation
    always #5 CLK = ~CLK; // 10 time unit clock period

    initial begin
        // Initialize inputs
        CLK = 0;
        RESET = 1;
        WRITE_ENABLE = 0;
        MEM_ACCESS = 0;
        MEM_WRITE = 0;
        MEM_READ = 0;
        ALU_OUTPUT = 32'b0;
        DATA2 = 32'b0;
        WRITE_ADDRESS = 5'b0;
        FUNCT3 = 3'b0;

        // Apply reset
        #10 RESET = 0;

        // Apply test stimulus
        #10 WRITE_ENABLE = 1;
            MEM_ACCESS = 1;
            MEM_WRITE = 1;
            MEM_READ = 0;
            ALU_OUTPUT = 32'hA5A5A5A5;
            DATA2 = 32'h5A5A5A5A;
            WRITE_ADDRESS = 5'b10101;
            FUNCT3 = 3'b111;

        #10 WRITE_ENABLE = 0;
            MEM_ACCESS = 0;
            MEM_WRITE = 0;
            MEM_READ = 1;
            ALU_OUTPUT = 32'hFFFFFFFF;
            DATA2 = 32'h00000000;
            WRITE_ADDRESS = 5'b00001;
            FUNCT3 = 3'b000;

        // Deassert reset during operation
        #10 RESET = 1; // Reset active
        #10 RESET = 0; // Reset deactivated

        // Test final state
        #10 WRITE_ENABLE = 1;
            MEM_ACCESS = 1;
            MEM_WRITE = 0;
            MEM_READ = 1;
            ALU_OUTPUT = 32'h12345678;
            DATA2 = 32'h87654321;
            WRITE_ADDRESS = 5'b11111;
            FUNCT3 = 3'b101;

        // End simulation
        #20 $finish;
    end

    initial begin
        // Dump waves for GTKWave
        $dumpfile("EX_MEM_pipeline_tb.vcd");
        $dumpvars(0, EX_MEM_pipeline_tb);

        // Monitor signal changes
        $monitor("Time = %0t | RESET = %b | WRITE_ENABLE = %b | MEM_ACCESS = %b | MEM_WRITE = %b | MEM_READ = %b | ALU_OUTPUT = %h | DATA2 = %h | WRITE_ADDRESS = %b | FUNCT3 = %b | WRITE_ENABLE_OUT = %b | MEM_ACCESS_OUT = %b | MEM_WRITE_OUT = %b | MEM_READ_OUT = %b | ALU_OUTPUT_OUT = %h | DATA2_OUT = %h | WRITE_ADDRESS_OUT = %b | FUNCT3_OUT = %b",
                 $time, RESET, WRITE_ENABLE, MEM_ACCESS, MEM_WRITE, MEM_READ, ALU_OUTPUT, DATA2, WRITE_ADDRESS, FUNCT3,
                 WRITE_ENABLE_OUT, MEM_ACCESS_OUT, MEM_WRITE_OUT, MEM_READ_OUT, ALU_OUTPUT_OUT, DATA2_OUT, WRITE_ADDRESS_OUT, FUNCT3_OUT);
    end

endmodule
