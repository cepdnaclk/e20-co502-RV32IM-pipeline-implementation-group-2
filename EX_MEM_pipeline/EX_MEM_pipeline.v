module EX_MEM_pipeline (CLK,RESET,WRITE_ENABLE,MEM_ACCESS,MEM_WRITE,MEM_READ,ALU_OUTPUT,WRITE_ADDRESS,FUNCT3,DATA2,WRITE_ENABLE_OUT,MEM_ACCESS_OUT,MEM_WRITE_OUT,MEM_READ_OUT,ALU_OUTPUT_OUT,WRITE_ADDRESS_OUT,FUNCT3_OUT,DATA2_OUT);
    input CLK,RESET;
    input WRITE_ENABLE,MEM_ACCESS,MEM_WRITE,MEM_READ;
    input[31:0] ALU_OUTPUT,DATA2;
    input[4:0] WRITE_ADDRESS;
    input[2:0] FUNCT3;
    output reg WRITE_ENABLE_OUT,MEM_ACCESS_OUT,MEM_WRITE_OUT,MEM_READ_OUT;
    output reg[31:0] ALU_OUTPUT_OUT,DATA2_OUT;
    output reg[4:0] WRITE_ADDRESS_OUT;
    output reg[2:0] FUNCT3_OUT;

    always @(posedge CLK) begin
        if(RESET) begin
            #1
            WRITE_ENABLE_OUT <= 1'bx;
            MEM_ACCESS_OUT <= 1'bx;
            MEM_WRITE_OUT <= 1'bx;
            MEM_READ_OUT <= 1'bx;
            ALU_OUTPUT_OUT <= 32'bx;
            WRITE_ADDRESS_OUT <= 5'bx;
            FUNCT3_OUT <= 3'bx;
            DATA2_OUT <= 32'bx;
        end
        else begin
            #2
            WRITE_ENABLE_OUT <= WRITE_ENABLE;
            MEM_ACCESS_OUT <= MEM_ACCESS;
            MEM_WRITE_OUT <= MEM_WRITE;
            MEM_READ_OUT <= MEM_READ;
            ALU_OUTPUT_OUT <= ALU_OUTPUT;
            WRITE_ADDRESS_OUT <= WRITE_ADDRESS;
            FUNCT3_OUT <= FUNCT3;
            DATA2_OUT <= DATA2;
        end
    end
    
endmodule