`timescale 1ns / 1ps

module Mem_ExPipeline_tb;

    // Inputs
    reg CLK;
    reg Reset;
    reg Write_enable;
    reg Memory_access;
    reg [31:0] Memory_Data;
    reg [31:0] ALU_Output;
    reg [4:0] Write_Address;

    // Outputs
    wire Write_Enable_Out;
    wire Memory_access_Out;
    wire [31:0] Memory_Data_Out;
    wire [31:0] ALU_Output_Out;
    wire [4:0] Write_Address_out;

    // Instantiate the Unit Under Test (UUT)
    Mem_ExPipeline uut (
        .CLK(CLK),
        .Reset(Reset),
        .Write_enable(Write_enable),
        .Memory_access(Memory_access),
        .Memory_Data(Memory_Data),
        .ALU_Output(ALU_Output),
        .Write_Address(Write_Address),
        .Write_Enable_Out(Write_Enable_Out),
        .Memory_access_Out(Memory_access_Out),
        .Memory_Data_Out(Memory_Data_Out),
        .ALU_Output_Out(ALU_Output_Out),
        .Write_Address_out(Write_Address_out)
    );

    // Clock generation
    initial begin
        CLK = 0;
        forever #5 CLK = ~CLK; // 10ns period
    end

    // Test sequence
    initial begin
        // Initialize Inputs
        Reset = 1;
        Write_enable = 0;
        Memory_access = 0;
        Memory_Data = 32'b0;
        ALU_Output = 32'b0;
        Write_Address = 5'b0;

        // Wait for global reset
        #15;

        // Deassert reset and apply test inputs
        Reset = 0;
        Write_enable = 1;
        Memory_access = 1;
        Memory_Data = 32'hA5A5A5A5;
        ALU_Output = 32'h5A5A5A5A;
        Write_Address = 5'b10101;

        #10; // Wait for one clock cycle

        // Change inputs
        Write_enable = 0;
        Memory_access = 0;
        Memory_Data = 32'h12345678;
        ALU_Output = 32'h87654321;
        Write_Address = 5'b11111;

        #10; // Wait for another clock cycle

        // Assert reset again
        Reset = 1;

        #10; // Wait for reset propagation

        // Deassert reset
        Reset = 0;

        #20; // Wait for some time

        // Finish simulation
        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time: %0t | Reset: %b | Write_enable: %b | Memory_access: %b | Memory_Data: %h | ALU_Output: %h | Write_Address: %b || Write_Enable_Out: %b | Memory_access_Out: %b | Memory_Data_Out: %h | ALU_Output_Out: %h | Write_Address_out: %b", 
                 $time, Reset, Write_enable, Memory_access, Memory_Data, ALU_Output, Write_Address, Write_Enable_Out, Memory_access_Out, Memory_Data_Out, ALU_Output_Out, Write_Address_out);
    end

endmodule