// ALU unit

module alu (data1,data2,ALU_OPCODE,Output);
    input [31:0] data1,data2;
    input [4:0] ALU_OPCODE;

    output reg [31:0] Output;

    wire [31:0] MULH_result,MULHU_result,MULHSU_result;
    wire [63:0] mulh_result,mulhu_result,mulhsu_result;

    assign mulh_result = $signed (data1)*$signed(data2) ;           // Calculation of Multiplication High instruction
    assign MULH_result = mulh_result[63:32];

    assign mulhu_result = $signed (data1)*$unsigned(data2) ;        // Calculation of Multiplication high unsigned values instruction
    assign MULHU_result = mulhu_result[63:32];

    assign mulhsu_result = $unsigned (data1)*$unsigned(data2) ;     // Calculation of Multiplication high signed unsigned instruction
    assign MULHSU_result = mulhsu_result[63:32];

    
    always @(*) begin

        case (ALU_OPCODE)
            5'b00000:#2 Output = data1+data2;                          //ADD instruction
            5'b00001:#2 Output = data1-data2;                          //SUB instruction
            5'b00010:#1 Output = data1|data2;                          //OR instruction
            5'b00011:#1 Output = data1^data2;                          //XOR instruction
            5'b00100:#1 Output = data1&data2;                          //AND instruction
            5'b00101:#2 Output = data1>>data2;                         //SLR instruction
            5'b00110:#2 Output = data1<<data2;                         //SLL instruction
            5'b00111:#2 Output = data1>>>data2;                        //SRA instruction
            5'b01000:#3 Output = data1*data2;                          //MUL instruction
            5'b01001:#3 Output = MULH_result;                          //MULH instruction
            5'b01010:#3 Output = MULHU_result;                         //MULHU instruction
            5'b01011:#3 Output = MULHSU_result;                        //MULHSU instruction
            5'b01100:#3 Output = $signed(data1)/$signed(data2);        //DIV instruction
            5'b01101:#3 Output = $unsigned(data1)/$unsigned(data2);    //DIVH instruction
            5'b01110:#4 Output = $signed(data1)% $signed(data2);       //REM instuction
            5'b01111:#4 Output = $unsigned(data1)% $unsigned(data2);   //REMU instruction
            5'b10000:#2 Output = (data1<data2)?32'b1:32'b0;            //SLT instruction
            5'b10001:#1 Output = data2;                                //Forwarding instruction
            default:#1 Output = 32'b0;

        endcase
    end
   
endmodule
