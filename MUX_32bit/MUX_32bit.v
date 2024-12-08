module MUX_32bit(INPUT_0,INPUT_1,SELECT,OUTPUT);
input [31:0] INPUT_0,INPUT_1;
input SELECT;
output reg [31:0] OUTPUT;

always @(INPUT_0,INPUT_1,SELECT) begin
    if (SELECT == 1'b0) begin
        OUTPUT = INPUT_0;
    end
    else begin
        OUTPUT = INPUT_1;
    end
end

endmodule