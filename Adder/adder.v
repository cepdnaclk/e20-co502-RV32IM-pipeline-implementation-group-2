module adder(
    input [31:0] PC,
    input STALL,
    output [31:0] PCPLUS4
);

    assign #1 PCPLUS4 = (STALL) ? PC - 4 : PC + 4;

endmodule
