module RegisterFile_tb;
    reg [4:0] RS1, RS2, WRITEADDRESS;
    reg [31:0] WRITEDATA;
    reg CLK, WRITEENABLE, RESET;
    wire [31:0] DATA1, DATA2;

    // Instantiate the RegisterFile module
    RegisterFile uut (
        .RS1(RS1), .RS2(RS2), .WRITEADDRESS(WRITEADDRESS),
        .WRITEDATA(WRITEDATA), .CLK(CLK), .WRITEENABLE(WRITEENABLE),
        .RESET(RESET), .DATA1(DATA1), .DATA2(DATA2)
    );

    // Clock generation
    initial CLK = 0;
    always #5 CLK = ~CLK;

    initial begin

        $dumpfile("wave.vcd");
        $dumpvars(0,RegisterFile_tb);

        // Test case: Reset
        RESET = 1;
        WRITEENABLE = 0;
        #10 RESET = 0;

        // Test case: Write to register 1
        WRITEADDRESS = 5'd1;
        WRITEDATA = 32'hA5A5A5A5;
        WRITEENABLE = 1;
        #10 WRITEENABLE = 0;

        // Test case: Read from register 1
        RS1 = 5'd1;
        RS2 = 5'd0; // Register 0 should remain 0
        #10;

        // Test case: Write to register 2
        WRITEADDRESS = 5'd2;
        WRITEDATA = 32'h5A5A5A5A;
        WRITEENABLE = 1;
        #10 WRITEENABLE = 0;

        // Test case: Read from registers 1 and 2
        RS1 = 5'd1;
        RS2 = 5'd2;
        #10;

        $finish;
    end
endmodule




module RegisterFile (RS1,RS2,WRITEDATA,WRITEADDRESS,WRITEENABLE,RESET,CLK,DATA1,DATA2);
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
            for (i = 0;i<32 ;i++ )
            begin
            registers[i] <= 0;
            end 
        end
        else if(WRITEENABLE)
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

endmodule
