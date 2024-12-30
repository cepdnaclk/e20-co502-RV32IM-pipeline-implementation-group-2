//ALU testbench
`timescale 1ps/1ps

module tb_ALU ;
    reg[31:0]DATA1,DATA2;
    reg[4:0]ALU_OPCODE;
    wire[31:0]ALU_OUTPUT;

    integer i;

    alu test_unit(DATA1,DATA2,ALU_OPCODE,ALU_OUTPUT);                       // initiating the alu module 
    initial begin
        $monitor("Time=%0t, Data1=%d, Data2=%d, Output=%d", $time, DATA1, DATA2,ALU_OUTPUT);

            
        DATA1 = 32'd6;
        DATA2 = 32'd3;
        ALU_OPCODE = 5'd0;
            

        for (i=0;i<=17;i++)
        begin
            ALU_OPCODE =i;
            #5;
        end
        $finish;
    end
    
endmodule