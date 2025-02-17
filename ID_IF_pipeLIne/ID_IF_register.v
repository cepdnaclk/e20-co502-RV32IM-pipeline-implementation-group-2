module ID_IF_register(CLK,INSTRUCTION,PC,PC_PLUS_4,RESET,BUBBLE,INSTRUCTION_OUT,PC_OUT,PC_PLUS_4_OUT);
input RESET,CLK,BUBBLE;
input[31:0] INSTRUCTION,PC,PC_PLUS_4;
output reg [31:0] INSTRUCTION_OUT,PC_OUT,PC_PLUS_4_OUT;


always @(posedge CLK or posedge RESET) begin
    if (RESET) begin
        #1
        INSTRUCTION_OUT <= 32'b0;  // Clear the pipeline register on reset
        PC_OUT <= 32'b0;
        PC_PLUS_4_OUT <= 32'b0;
    end 
    else if (!BUBBLE) begin
        #2
        INSTRUCTION_OUT <= INSTRUCTION;
        PC_OUT <= PC;
        PC_PLUS_4_OUT <= PC_PLUS_4;
    end
end

endmodule