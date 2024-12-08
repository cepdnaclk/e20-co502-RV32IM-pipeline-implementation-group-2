module BranchController (data1,data2,func3,ALUresult,Branch,Jump,TargetedAddress,PCAddressController);
    input signed[31:0] data1,data2,ALUresult;
    input[2:0] func3;
    input Branch,Jump;

    output reg[31:0] TargetedAddress;
    output reg PCAddressController;

    always @(*) begin
        PCAddressController = 1'b0;                     // Initially the control flag set to 0(choose the PC+4 address)
        if (Branch==1'b1) begin 
            case (func3)
                3'b000:PCAddressController=(data1==data2)?1'b1:1'b0;                            //BEQ instruction
                3'b001:PCAddressController=(data1!=data2)?1'b1:1'b0;                            //BNE instruction
                3'b100:PCAddressController=($signed(data1)<$signed(data2))?1'b1:1'b0;           //BLT instruction
                3'b101:PCAddressController=($signed(data1)>=$signed(data2))?1'b1:1'b0;          //BGE instruction
                3'b110:PCAddressController=($unsigned(data1)<$unsigned(data2))?1'b1:1'b0;       //BLTU instruction
                3'b111:PCAddressController=($unsigned(data1)>=$unsigned(data2))?1'b1:1'b0;      //BGEU instruction
                default: PCAddressController=1'b0;
            endcase    
        end
        
        
    end

    
endmodule