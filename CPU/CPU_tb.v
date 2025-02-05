`include "CPU.v"

module cpu_testbench;
    reg CLK, RESET;
    reg [31:0] INSTRUCTION;

    // Instantiate the CPU
    CPU cpu_inst(
        .CLK(CLK),
        .RESET(RESET)
        // Connect other signals as needed
    );

    // Clock generation
    initial begin
        CLK = 0;
        forever #4 CLK = ~CLK; // 10ns clock period
    end

   initial begin
        // Initialize inputs
        RESET = 1;
        #5 RESET = 0; // Release reset after 10ns

        // Provide enough time for instructions to propagate through the pipeline
        #1000;

        // Stop simulation
        $finish;
    end

    // Dump Waveform for GTKWave
    initial begin
        $dumpfile("cpu_pipeline.vcd"); // Name of the dump file
        $dumpvars(0, cpu_testbench);    // Dump all variables in this module
        for (integer i = 0;i<32 ;i=i+1 ) begin
        $dumpvars(0, cpu_inst.registerfile1.registers[i]);    // Dump all variables in this module    
        end
        for (integer i = 0;i<20 ;i=i+1 ) begin
        $dumpvars(0, cpu_inst.datamemory1.memory_array[i]);    // Dump all variables in this module    
        end
    end

endmodule
