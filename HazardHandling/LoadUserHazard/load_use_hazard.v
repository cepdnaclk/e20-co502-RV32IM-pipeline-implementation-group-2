module load_use_hazard(CLK,RESET,LOAD_SIGNAL,MEM_Rd,ALU_RS1,ALU_RS2,FRWD_RS1_WB,FRWD_RS2_WB,BUBBLE);

input CLK,
input RESET,
input LOAD_SIG, //Signal indicating that a load instruction is in MEM stage
input [4:0] MEM_Rd, //Destination register of the load instruction
input [4:0] ALU_RS1, //First source register in ALU stage
input [4:0] ALU_RS2, //Second source register
output reg FRWD_RS1_WB, //Forward data to RS1 from Write Back 
output reg FRWD_RS2_WB, //Forward data to RS2 from Write Back 
output reg BUBBLE //Stall cycle

wire [4:0] ALU_RS1_XNOR,ALU_RS2_XNOR;
wire RS1_COMPARING,RS2_COMPARING,BUBBLE_WR;

//check if this instruction and the previous instruction depend on each other
assign #1 ALU_RS1_XNOR = (MEM_Rd ~^ ALU_RS1);
assign #1 ALU_RS2_XNOR = (MEM_Rd ~^ ALU_RS2);
assign #1 RS1_COMPARING = (&ALU_RS1_XNOR);
assign #1 RS2_COMPARING = (&ALU_RS2_XNOR);
assign #1 BUBBLE_WR = RS1_COMPARING | RS2_COMPARING;

always @(LOAD_SIGNAL) begin
    #1
    if (LOAD_SIGNAL)
    begin
        FRWD_RS1_WB=RS1_COMPARING;
        FRWD_RS2_WB=RS2_COMPARING;
        BUBBLE=BUBBLE_WR;
    end
    else begin
        FRWD_RS1_WB=1'b0;
        FRWD_RS2_WB=1'b0;
        BUBBLE=1'b0;    
    end
    
end

always @(RESET) begin
    if (RESET) begin
        FRWD_RS1_WB=1'b0;
        FRWD_RS2_WB=1'b0;
        BUBBLE=1'b0;
    end
end

endmodule