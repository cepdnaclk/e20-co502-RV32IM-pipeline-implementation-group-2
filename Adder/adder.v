module adder(PC , PCPLUS4);
    input [31:0] PC;
    output [31:0] PCPLUS4;

    assign #1 PCPLUS4 = PC + 4;
    
endmodule