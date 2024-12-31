

module ID_ExPipeline_tb;
    // Testbench signals
    reg CLK, Reset;
    reg Write_Enable, Memory_Access, Mem_Write, Mem_Read, Jump_and_Link;
    reg Immediate_Select, Offset_Generate, Branch, Jump;
    reg [4:0] ALU_Opcode;
    reg [31:0] PC, PC_next, Data1, Data2, instruction, Immediate_value;

    wire Out_Write_Enable, Out_Memory_Access, Out_Mem_Write, Out_Mem_Read;
    wire Out_Jump_and_Link, Out_Immediate_Select, Out_Offset_Generate;
    wire Out_Branch, Out_Jump;
    wire [4:0] Out_ALU_Opcode;
    wire [31:0] Out_PC, Out_PC_next, Out_Data1, Out_Data2, Out_Immediate_value;
    wire [4:0] Out_WriteAddress;
    wire [2:0] Out_func3;

    // Instantiate the module under test (MUT)
    ID_ExPipeline uut (
        .CLK(CLK),
        .Reset(Reset),
        .Write_Enable(Write_Enable),
        .Memory_Access(Memory_Access),
        .Mem_Write(Mem_Write),
        .Mem_Read(Mem_Read),
        .Jump_and_Link(Jump_and_Link),
        .ALU_Opcode(ALU_Opcode),
        .Immediate_Select(Immediate_Select),
        .Offset_Generate(Offset_Generate),
        .Branch(Branch),
        .Jump(Jump),
        .PC(PC),
        .PC_next(PC_next),
        .Data1(Data1),
        .Data2(Data2),
        .instruction(instruction),
        .Immediate_value(Immediate_value),
        .Out_Write_Enable(Out_Write_Enable),
        .Out_Memory_Access(Out_Memory_Access),
        .Out_Mem_Write(Out_Mem_Write),
        .Out_Mem_Read(Out_Mem_Read),
        .Out_Jump_and_Link(Out_Jump_and_Link),
        .Out_ALU_Opcode(Out_ALU_Opcode),
        .Out_Immediate_Select(Out_Immediate_Select),
        .Out_Offset_Generate(Out_Offset_Generate),
        .Out_Branch(Out_Branch),
        .Out_Jump(Out_Jump),
        .Out_PC(Out_PC),
        .Out_PC_next(Out_PC_next),
        .Out_Data1(Out_Data1),
        .Out_Data2(Out_Data2),
        .Out_WriteAddress(Out_WriteAddress),
        .Out_func3(Out_func3),
        .Out_Immediate_value(Out_Immediate_value)
    );

    // Clock generation
    initial begin
        CLK = 0;
        forever #5 CLK = ~CLK; // Clock period = 10 time units
    end

    // Stimulus process
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0,ID_ExPipeline_tb);
        // Initialize inputs
        Reset = 1;
        Write_Enable = 0;
        Memory_Access = 0;
        Mem_Write = 0;
        Mem_Read = 0;
        Jump_and_Link = 0;
        Immediate_Select = 0;
        Offset_Generate = 0;
        Branch = 0;
        Jump = 0;
        ALU_Opcode = 5'b00000;
        PC = 32'h00000000;
        PC_next = 32'h00000004;
        Data1 = 32'hDEADBEEF;
        Data2 = 32'hFEEDC0DE;
        instruction = 32'h00000000;
        Immediate_value = 32'h00F00713;

        // Apply Reset
        #10 Reset = 0;
        #10 Reset = 1;

        // Test Case 1: Reset active
    /*    #10;
        $display("Test Case 1: Reset Active");
        $display("Out_Write_Enable = %b (Expected: x)", Out_Write_Enable);*/

        // Test Case 2: Normal operation
        #10 Reset = 0;
        Write_Enable = 1;
        Memory_Access = 1;
        Mem_Write = 1;
        Mem_Read = 0;
        Jump_and_Link = 0;
        Immediate_Select = 1;
        Offset_Generate = 1;
        Branch = 1;
        Jump = 0;
        ALU_Opcode = 5'b01010;
        PC = 32'h10000000;
        PC_next = 32'h10000004;
        Data1 = 32'h12345678;
        Data2 = 32'h87654321;
        instruction = 32'h00F00713; // Random RISC-V instruction
        #20;
/*
        $display("Test Case 2: Normal Operation");
        $display("Out_Write_Enable = %b (Expected: 1)", Out_Write_Enable);
        $display("Out_WriteAddress = %h (Expected: 0000F)", Out_WriteAddress);
        $display("Out_func3 = %h (Expected: 0007)", Out_func3);
        $display("Out_PC = %h (Expected: 10000000)", Out_PC);
        $display("Out_Data1 = %h (Expected: 12345678)", Out_Data1);
*/
        // Finish Simulation
       // #50;
        $finish;
    end
/*
    // Monitor outputs
    initial begin
        $monitor("Time=%0t CLK=%b Reset=%b Out_Write_Enable=%b Out_PC=%h Out_Data1=%h", $time, CLK, Reset, Out_Write_Enable, Out_PC, Out_Data1);
    end*/

endmodule
