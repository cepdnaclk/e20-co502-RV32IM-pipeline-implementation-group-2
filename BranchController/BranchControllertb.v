`timescale 1ps/1ps

module BranchController_tb ();
    reg signed [31:0] data1, data2, ALUresult;
    reg [2:0] func3;
    wire[31:0]TargetedAddress;
    reg Branch_tb, Jump_tb; 
    wire PCAddressController;

    // Instantiate the Unit Under Test (UUT)
    BranchController Test_unit (        
        .data1(data1),
        .data2(data2),
        .func3(func3),
        .ALUresult(ALUresult),
        .Branch(Branch_tb),
        .Jump(Jump_tb),
        .TargetedAddress(TargetedAddress),
        .PCAddressController(PCAddressController)
    );

    initial begin
        // Display monitored values
        $monitor("Time=%0t, Output=%b, Branch=%b, Jump=%b , TargetAddress=%d", $time, PCAddressController, Branch_tb, Jump_tb, TargetedAddress);
        
        // Initialize signals
        ALUresult = 32'd24; // Correct integer assignment syntax
    
        Branch_tb = 1;         // Correct binary literal
        Jump_tb = 0;           // Correct binary literal
        data1 = 32'd12;     // Decimal assignment
        data2 = 32'd15;     // Decimal assignment
        func3 = 3'b100;    // Correct binary assignment
        
        #10;                // Wait 10 time units
        func3 = 3'b101;    // Assign new value to funct3
        #10;                // Wait 10 time units

        data1 = 32'd15;     // Assign new value to DATA1
        func3 = 3'b000;    // Assign new value to funct3
        
        #10;

        data1=-32'd15;
        func3 = 3'b101;
        #10;
        func3 = 3'b111;
        #10;
        Jump_tb=1'b1;
        Branch_tb=1'b0;
        $finish;              // Stop the simulation
    end
endmodule
