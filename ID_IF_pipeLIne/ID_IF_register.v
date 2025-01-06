module ID_IF_register(CLK,INSTRUCTION,PC,PC_PLUS_4,RESET,INSTRUCTION_OUT,PC_OUT,PC_PLUS_4_OUT);
input RESET,CLK;
input[31:0] INSTRUCTION,PC,PC_PLUS_4;
output reg [31:0] INSTRUCTION_OUT,PC_OUT,PC_PLUS_4_OUT;


always @(posedge CLK) begin
    if (RESET==1) begin
        #1
        INSTRUCTION_OUT <= 0;
        PC_OUT <= 0;
        PC_PLUS_4_OUT <= 0;
    end
    else begin
        #2
    INSTRUCTION_OUT <= INSTRUCTION;
    PC_OUT <= PC;
    PC_PLUS_4_OUT <= PC_PLUS_4;
    end
   
end

endmodule