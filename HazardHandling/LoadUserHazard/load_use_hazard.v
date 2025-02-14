module load_use_hazard(
    input [31:0] INSTRUCTION,  // Current instruction
    input RESET,               // Reset signal
    input [4:0] ALU_RS1,       // First source register in ALU stage
    input [4:0] ALU_RS2,       // Second source register
    output reg FRWD_RS1_WB,    // Forward data to RS1 from Write Back 
    output reg FRWD_RS2_WB,    // Forward data to RS2 from Write Back 
    output reg BUBBLE          // Stall cycle
);

reg PREV_INST_LOAD;   // Indicates if the previous instruction was a load
reg [4:0] MEM_RD_OLD; // Destination register of the previous load instruction

wire [6:0] OPCODE;
assign OPCODE = INSTRUCTION[6:0];

// Check if the previous instruction was a load (`LW`)
wire LOAD_INST = PREV_INST_LOAD; 

// Check if the current instruction is an R-type instruction (OPCODE = 7'b0110011)
wire R_TYPE_INST = (OPCODE == 7'b0110011);

// Check for hazards
wire RS1_HAZARD = (MEM_RD_OLD == ALU_RS1) && (MEM_RD_OLD != 5'b00000);
wire RS2_HAZARD = (MEM_RD_OLD == ALU_RS2) && (MEM_RD_OLD != 5'b00000);
wire HAZARD_DETECTED = RS1_HAZARD | RS2_HAZARD;

always @(*) begin
    if (LOAD_INST && R_TYPE_INST && HAZARD_DETECTED) begin
        BUBBLE = 1'b1;         // Stall the pipeline
        if(RS1_HAZARD)begin
            FRWD_RS1_WB = 2'b01;  // Forwarding if needed
        end else begin
            FRWD_RS2_WB = 2'b01;
        end
    end else begin
        BUBBLE = 1'b0;
        FRWD_RS1_WB = 1'b0;  // Forwarding if needed
        FRWD_RS2_WB = 1'b0;
    end
end

always @(posedge RESET or posedge OPCODE) begin
    if (RESET) begin
        PREV_INST_LOAD <= 1'b0;
        MEM_RD_OLD <= 5'b00000;
    end else if (OPCODE == 7'b0000011) begin // Load instruction (`LW`)
        PREV_INST_LOAD <= 1'b1;
        MEM_RD_OLD <= INSTRUCTION[11:7]; // Destination register of load instruction
    end else begin
        PREV_INST_LOAD <= 1'b0;
    end
end

endmodule
