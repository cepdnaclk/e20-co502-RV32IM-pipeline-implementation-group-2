module RegisterFile(RS1,RS2,WRITEDATA,WRITEADDRESS,WRITEENABLE,RESET,CLK,DATA1,DATA2);
    input [4:0] RS1,RS2,WRITEADDRESS;
    input [31:0] WRITEDATA;
    input CLK,WRITEENABLE,RESET;
    output reg [31:0] DATA1,DATA2;
    reg [31:0] registers [0:31];

    integer i;

    always @(posedge CLK)
    begin
        if(RESET)
        begin
            #1
            registers[0] <= 0;
            registers[1] <= 0;
            registers[2] <= 0;
            registers[3] <= 0;
            registers[4] <= 0;
            registers[5] <= 0;
            registers[6] <= 0;
            registers[7] <= 0;
            registers[8] <= 0;
            registers[9] <= 0;
            registers[10] <= 0;
            registers[11] <= 0;
            registers[12] <= 0;
            registers[13] <= 0;
            registers[14] <= 0;
            registers[15] <= 0;
            registers[16] <= 0;
            registers[17] <= 0;
            registers[18] <= 0;
            registers[19] <= 0;
            registers[20] <= 0;
            registers[21] <= 0;
            registers[22] <= 0;
            registers[23] <= 0;
            registers[24] <= 0;
            registers[25] <= 0;
            registers[26] <= 0;
            registers[27] <= 0;
            registers[28] <= 0;
            registers[29] <= 0;
            registers[30] <= 0;
            registers[31] <= 0;
            
        end
        else if(WRITEENABLE && WRITEADDRESS != 5'd0)
        begin
            #1
            registers[WRITEADDRESS] <= WRITEDATA;
        end 
    end
    always @(RS1,RS2)
    begin
        #2
        DATA1 <= registers[RS1];
        DATA2 <= registers[RS2];
    end

    // Initial block to dump register values
   

endmodule

// // module RegisterFile_tb;
// //     reg [4:0] RS1, RS2, WRITEADDRESS;
// //     reg [31:0] WRITEDATA;
// //     reg CLK, WRITEENABLE, RESET;
// //     wire [31:0] DATA1, DATA2;

// //     // Instantiate the RegisterFile module
// //     RegisterFile uut (
// //         .RS1(RS1), .RS2(RS2), .WRITEADDRESS(WRITEADDRESS),
// //         .WRITEDATA(WRITEDATA), .CLK(CLK), .WRITEENABLE(WRITEENABLE),
// //         .RESET(RESET), .DATA1(DATA1), .DATA2(DATA2)
// //     );

// //     // Clock generation
// //     initial CLK = 0;
// //     always #5 CLK = ~CLK;

// //     initial begin

// //         $dumpfile("wave.vcd");
// //         $dumpvars(0,RegisterFile_tb);

// //         // Test case: Reset
// //         RESET = 1;
// //         WRITEENABLE = 0;
// //         #10 RESET = 0;

// //         // Test case: Write to register 1
// //         WRITEADDRESS = 5'd1;
// //         WRITEDATA = 32'hA5A5A5A5;
// //         WRITEENABLE = 1;
// //         #10 WRITEENABLE = 0;

// //         // Test case: Read from register 1
// //         RS1 = 5'd1;
// //         RS2 = 5'd0; // Register 0 should remain 0
// //         #10;

// //         // Test case: Write to register 2
// //         WRITEADDRESS = 5'd2;
// //         WRITEDATA = 32'h5A5A5A5A;
// //         WRITEENABLE = 1;
// //         #10 WRITEENABLE = 0;

// //         // Test case: Read from registers 1 and 2
// //         RS1 = 5'd1;
// //         RS2 = 5'd2;
// //         #10;

// //         $finish;
// //     end
// // endmodule



