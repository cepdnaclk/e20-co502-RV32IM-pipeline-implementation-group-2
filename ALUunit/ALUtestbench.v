//ALU testbench
`timescale 1ps/1ps

module tb_ALU ;
    reg[31:0]DATA1,DATA2;
    reg[4:0]OPCODE;
    wire[31:0]ALU_OUTPUT;

    integer i;

    alu test_unit(DATA1,DATA2,OPCODE,ALU_OUTPUT);
    initial begin
        $dumpfile("waveform.vcd"); 
        $dumpvars(0, tb_ALU);
            
        DATA1 = 32'd6;
        DATA2 = 32'd3;
        OPCODE = 5'd0;
            

        for (i=0;i<=17;i++)
        begin
            OPCODE =i;
            #5;
        end
        $finish;
    end
    
endmodule