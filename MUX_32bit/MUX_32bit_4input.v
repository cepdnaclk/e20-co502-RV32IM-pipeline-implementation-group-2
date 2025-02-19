module MUX_32bit_4input(INPUT_0,INPUT_1,INPUT_2,INPUT_3,SELECT,OUTPUT);
input [31:0] INPUT_0,INPUT_1,INPUT_2,INPUT_3;
input [1:0] SELECT;
output reg [31:0] OUTPUT;

always @(INPUT_0,INPUT_1,INPUT_2,INPUT_3,SELECT) begin
    if (SELECT == 2'b00) begin
        OUTPUT = INPUT_0;
    end
    else if(SELECT == 2'b11) begin
        OUTPUT = INPUT_2;
    end
    else if(SELECT == 2'b01) begin
        OUTPUT = INPUT_3;
    end
    else begin
        OUTPUT =INPUT_1;
    end
end

endmodule