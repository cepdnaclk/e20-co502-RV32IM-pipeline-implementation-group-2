module BranchController (data1,data2,func3,ALUresult,Branch,Jump,TargetedAddress,PCAddressController);
    input signed[31:0] data1,data2,ALUresult;
    input[2:0] func3;
    input Branch,Jump;

    output reg[31:0] TargetedAddress;
    output reg PCAddressController;

    initial begin
        PCAddressController = 1'b0;
    end

    always @(data1,data2,func3,Branch,Jump,ALUresult) begin
        PCAddressController = 1'b0;                     // Initially the control flag set to 0(choose the PC+4 address)
        if (Branch==1'b1) begin 
            TargetedAddress = ALUresult;
            case (func3)
                3'b000:#1 PCAddressController=(data1==data2)?1'b1:1'b0;                            //BEQ instruction
                3'b001:#1 PCAddressController=(data1!=data2)?1'b1:1'b0;                            //BNE instruction
                3'b100:#1 PCAddressController=($signed(data1)<$signed(data2))?1'b1:1'b0;           //BLT instruction
                3'b101:#1 PCAddressController=($signed(data1)>=$signed(data2))?1'b1:1'b0;          //BGE instruction
                3'b110:#1 PCAddressController=($unsigned(data1)<$unsigned(data2))?1'b1:1'b0;       //BLTU instruction
                3'b111:#1 PCAddressController=($unsigned(data1)>=$unsigned(data2))?1'b1:1'b0;      //BGEU instruction
                default: #1 PCAddressController=1'b0;
            endcase    
        end
        if (Jump==1'b1) begin
            #1;
            TargetedAddress =ALUresult;
            PCAddressController =1'b1;                                                          //Jump Insruction
        end
        
        
    end

    
endmodule