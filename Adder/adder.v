module adder(PC , PCPLUS4);
    input [31:0] PC;
    output [31:0] PCPLUS4;

    assign PCPLUS4 = PC + 4;
    
endmodule