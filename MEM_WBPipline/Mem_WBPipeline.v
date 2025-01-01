module Mem_ExPipeline (CLK,Reset,Write_enable,Memory_access,Memory_Data,ALU_Output,Write_Address,Write_Enable_Out,Memory_access_Out,Memory_Data_Out,ALU_Output_Out,Write_Address_out);
    input Write_enable,Memory_access;
    input [31:0] Memory_Data,ALU_Output;
    input [4:0] Write_Address;
    input CLK, Reset;

    output reg Write_Enable_Out,Memory_access_Out;
    output reg [31:0] Memory_Data_Out,ALU_Output_Out;
    output reg [4:0] Write_Address_out;

    always @(posedge CLK) begin
        if (Reset == 1 ) begin
            Write_Enable_Out <= 1'bx;
            Memory_access_Out <= 1'bx;
            Memory_Data_Out <= 32'bx;
            ALU_Output_Out <= 32'bx;
            Write_Address_out <= 5'bx;
            
        end else begin
            Write_Enable_Out <= Write_enable;
            Memory_access_Out <= Memory_access;
            Memory_Data_Out <= Memory_Data;
            ALU_Output_Out <= ALU_Output;
            Write_Address_out <= Write_Address;
        end
        
        
    end

endmodule 