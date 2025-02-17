module Forward (
    input [31:0] INSTRUCTION,
    input [1:0] ControlUnit_IMMEDIATE_SELECT,
    input [1:0] ControlUnit_OFFSET_GENARATOR,
    input [4:0] RD_imm_old, RD_old_old,
    output reg [1:0] Data2_ImmediateSelect,
    output reg [1:0] Data1_OffsetGenarator
);

    wire [6:0] OPCODE;
    wire [4:0] SR1, SR2, RD;
    
    assign OPCODE = INSTRUCTION[6:0];
    assign SR1 = INSTRUCTION[19:15];
    assign SR2 = INSTRUCTION[24:20];
    assign RD  = INSTRUCTION[11:7];

    always @(*) begin
        // Default assignment (No forwarding)
        Data1_OffsetGenarator = ControlUnit_OFFSET_GENARATOR;
        Data2_ImmediateSelect = ControlUnit_IMMEDIATE_SELECT;

        if ((OPCODE == 7'b0110011) ) begin
            // Case 1: Both SR1 and SR2 are dependent on RD_imm_old
            if ((SR1 == RD_imm_old) && (SR2 == RD_imm_old)) begin
                Data1_OffsetGenarator = 2'b11;
                Data2_ImmediateSelect = 2'b11;
            end 
            // Case 2: Both SR1 and SR2 are dependent on RD_old_old
            else if ((SR1 == RD_old_old) && (SR2 == RD_old_old)) begin
                Data1_OffsetGenarator = 2'b01;
                Data2_ImmediateSelect = 2'b01;
            end 
            // Case 3: SR1 depends on RD_old_old, SR2 depends on RD_imm_old
            else if ((SR1 == RD_old_old) && (SR2 == RD_imm_old)) begin
                Data1_OffsetGenarator = 2'b01;
                Data2_ImmediateSelect = 2'b11;
            end
            // Case 4: SR1 depends on RD_imm_old, SR2 depends on RD_old_old
            else if ((SR1 == RD_imm_old) && (SR2 == RD_old_old)) begin
                Data1_OffsetGenarator = 2'b11;
                Data2_ImmediateSelect = 2'b01;
            end
            // Case 5: SR1 depends on RD_imm_old, SR2 does not
            else if ((SR1 == RD_imm_old) && (SR2 != RD_imm_old)) begin
                Data1_OffsetGenarator = 2'b11;
            end 
            // Case 6: SR2 depends on RD_imm_old, SR1 does not
            else if ((SR2 == RD_imm_old) && (SR1 != RD_imm_old)) begin
                Data2_ImmediateSelect = 2'b11;
            end 
            // Case 7: SR1 depends on RD_old_old, SR2 does not
            else if ((SR1 == RD_old_old) && (SR2 != RD_old_old)) begin
                Data1_OffsetGenarator = 2'b01;
            end 
            // Case 8: SR2 depends on RD_old_old, SR1 does not
            else if ((SR2 == RD_old_old) && (SR1 != RD_old_old)) begin
                Data2_ImmediateSelect = 2'b01;
            end 
        end
    end 

endmodule
