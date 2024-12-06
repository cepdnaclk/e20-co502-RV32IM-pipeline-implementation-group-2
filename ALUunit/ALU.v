// ALU unit

module alu (data1,data2,opcode,Output);
    input [31:0] data1,data2;
    input [4:0] opcode;

    output reg [31:0] Output;

    wire [31:0] MULH_result,MULHU_result,MULHSU_result;
    wire [63:0] mulh_result,mulhu_result,mulhsu_result;
    wire [31:0] SLT_result;

    assign mulh_result = $signed (data1)*$signed(data2) ;
    assign MULH_result = mulh_result[63:31];

    assign mulhu_result = $signed (data1)*$unsigned(data2) ;
    assign MULHU_result = mulhu_result[63:31];

    assign mulhsu_result = $unsigned (data1)*$unsigned(data2) ;
    assign MULHSU_result = mulhsu_result[63:31];

    assign SLT_result = (data1<data2)?32'b1:32'b0;
    
    always @(*) begin
        case (opcode)
            5'b00000:Output = data1+data2;      //ADD
            5'b00001:Output = data1-data2;      //SUB
            5'b00010:Output = data1|data2;      //OR
            5'b00011:Output = data1^data2;      //XOR
            5'b00100:Output = data1&data2;      //AND
            5'b00101:Output = data1>>data2;      //SLR
            5'b00110:Output = data1<<data2;      //SLL
            5'b00111:Output = data1>>>data2;      //SRA
            5'b01000:Output = data1*data2;      //MUL
            5'b01001:Output = MULH_result;    //MULH
            5'b01010:Output = MULHU_result;    //MULHU
            5'b01011:Output = MULHSU_result;    //MULHSU
            5'b01100:Output = $signed(data1)/$signed(data2);//DIV
            5'b01101:Output = $unsigned(data1)/$unsigned(data2);//DIVH
            5'b01110:Output = $signed(data1)% $signed(data2);//REM
            5'b01111:Output = $unsigned(data1)% $unsigned(data2);//REMU
            5'b10000:Output = SLT_result; //SLT
            5'b10001:Output = data2;
            default:Output = 32'b0;
        endcase
    end
   
endmodule