module Forward (
    //input CLK
    input [31:0] INSTRUCTION,
    input [1:0] ControlUnit_IMMEDIATE_SELECT,
    input [1:0] ControlUnit_OFFSET_GENARATOR,
    output reg [1:0] Data2_ImmediateSelect,
    output reg [1:0] Data1_OffsetGenarator
);
    wire [6:0] OPCODE;
    wire [4:0] SR1, SR2, RD;
    reg [4:0] RD_imm_old,RD_old_old;

    assign OPCODE = INSTRUCTION[6:0];
    assign SR1 = INSTRUCTION[19:15];
    assign SR2 = INSTRUCTION[24:20];
    assign RD  = INSTRUCTION[11:7];
    always @(INSTRUCTION) begin
        RD_old_old=RD_imm_old;
        RD_imm_old = RD;
    end
    always @(*) begin
        
        if (OPCODE == 7'b0110011) begin
            if ((SR1 == RD_imm_old) && (SR2 != RD_imm_old)) begin
                Data1_OffsetGenarator = 2'b11;
                Data2_ImmediateSelect = ControlUnit_IMMEDIATE_SELECT;
            end 
            else if ((SR1 != RD_imm_old) && (SR2 == RD_imm_old)) begin
                Data1_OffsetGenarator = ControlUnit_OFFSET_GENARATOR;
                Data2_ImmediateSelect = 2'b11;
            end 
            else if ((SR1 == RD_imm_old) && (SR2 == RD_imm_old)) begin
                Data1_OffsetGenarator = 2'b11;
                Data2_ImmediateSelect = 2'b11;
            end 
            else if ((SR1 == RD_old_old) && (SR2 != RD_old_old)) begin
                Data1_OffsetGenarator = 2'b01;
                Data2_ImmediateSelect = ControlUnit_IMMEDIATE_SELECT;
            end 
            else if ((SR1 != RD_old_old) && (SR2 == RD_old_old)) begin
                Data1_OffsetGenarator = ControlUnit_OFFSET_GENARATOR;
                Data2_ImmediateSelect = 2'b01;
            end 
            else if ((SR1 == RD_old_old) && (SR2 == RD_old_old)) begin
                Data1_OffsetGenarator = 2'b01;
                Data2_ImmediateSelect = 2'b01;
            end
            else begin
                Data1_OffsetGenarator = ControlUnit_OFFSET_GENARATOR;
                Data2_ImmediateSelect = ControlUnit_IMMEDIATE_SELECT;
            end
            
        end else begin
            Data1_OffsetGenarator = ControlUnit_OFFSET_GENARATOR;
            Data2_ImmediateSelect = ControlUnit_IMMEDIATE_SELECT; 
            
        end
        
    end 
    /*
    always @(posedge CLK) begin
        
        
    end */

endmodule
