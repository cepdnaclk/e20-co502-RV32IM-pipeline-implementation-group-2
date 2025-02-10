module ID_ExPipeline (CLK,Reset,Write_Enable,Memory_Access,Mem_Write,Mem_Read,Jump_and_Link,ALU_Opcode,Immediate_Select,Offset_Generate,Branch,Jump,PC,PC_next,Data1,Data2,instruction,Immediate_value,Out_Write_Enable,Out_Memory_Access,Out_Mem_Write,Out_Mem_Read,Out_Jump_and_Link,Out_ALU_Opcode,Out_Immediate_Select,Out_Offset_Generate,Out_Branch,Out_Jump,Out_PC,Out_PC_next,Out_Data1,Out_Data2,Out_WriteAddress,Out_func3,Out_Immediate_value,STALL);
    input Write_Enable,Memory_Access,Mem_Write,Mem_Read,Jump_and_Link,Branch,Jump;
    input [1:0] Immediate_Select,Offset_Generate;
    input[4:0] ALU_Opcode;
    input[31:0] PC,PC_next,Data1,Data2,instruction,Immediate_value;
    input CLK,Reset,STALL;
    output reg Out_Write_Enable,Out_Memory_Access,Out_Mem_Write,Out_Mem_Read,Out_Jump_and_Link,Out_Branch,Out_Jump;
    output reg[1:0] Out_Immediate_Select,Out_Offset_Generate;
    output reg[4:0] Out_ALU_Opcode;
    output reg[31:0] Out_PC,Out_PC_next,Out_Data1,Out_Data2,Out_Immediate_value;
    output reg[4:0] Out_WriteAddress;
    output reg[2:0] Out_func3;

    always @(posedge CLK) begin
        if (Reset==1) begin
            #1
            Out_Write_Enable <= 1'bx;
            Out_Memory_Access <= 1'bx;
            Out_Mem_Write <= 1'bx;
            Out_Mem_Read <= 1'bx;
            Out_Jump_and_Link <= 1'bx;
            Out_Immediate_Select <= 2'bx;
            Out_Offset_Generate <= 2'bx;
            Out_Branch <= 1'bx;
            Out_Jump <= 1'bx;
            Out_ALU_Opcode <= 5'bx;
            Out_PC <= 32'bx;
            Out_PC_next <= 32'bx;
            Out_Data1 <= 32'bx;
            Out_Data2 <= 32'bx;
            Out_WriteAddress <= 5'bx;
            Out_func3 <= 3'bx;
            Out_Immediate_value <= 32'bx;
        end
        else if (STALL) begin
            #2
            Out_Write_Enable <= 1'b0;
            Out_Memory_Access <= 1'b0;
            Out_Mem_Write <= 1'b0;
            Out_Mem_Read <= 1'b0;
            Out_Jump_and_Link <= 1'b0;
            Out_Immediate_Select <= 2'b0;
            Out_Offset_Generate <= 2'b0;
            Out_Branch <= 1'b0;
            Out_Jump <= 1'b0;
            Out_ALU_Opcode <= 5'b0;
            Out_PC <= 32'b0;
            Out_PC_next <= 32'b0;
            Out_Data1 <= 32'b0;
            Out_Data2 <= 32'b0;
            Out_WriteAddress <= 5'b0;
            Out_func3 <= 3'b0;
            Out_Immediate_value <= 32'b0;
        end
        else begin
            #2
            Out_Write_Enable <= Write_Enable;
            Out_Memory_Access <= Memory_Access;
            Out_Mem_Write <= Mem_Write;
            Out_Mem_Read <= Mem_Read;
            Out_Jump_and_Link <= Jump_and_Link;
            Out_Immediate_Select <= Immediate_Select;
            Out_Offset_Generate <= Offset_Generate;
            Out_Branch <= Branch ;
            Out_Jump <= Jump;
            Out_ALU_Opcode <= ALU_Opcode;
            Out_PC <= PC;
            Out_PC_next <= PC_next;
            Out_Data1 <= Data1;
            Out_Data2 <= Data2;
            Out_WriteAddress <= instruction[11:7];
            Out_func3 <= instruction[14:12];
            Out_Immediate_value <= Immediate_value;
        end
    end




endmodule