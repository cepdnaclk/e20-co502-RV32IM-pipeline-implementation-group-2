module pc (PCIN,RESET,CLK,PCOUT);
    input [31:0] PCIN;
    input RESET,CLK;
    output reg [31:0] PCOUT;

    always @(posedge CLK)
    begin
        if(RESET)
        begin
            #2
            PCOUT <= 0;
        end
        else
        begin
            #2
            PCOUT <= PCIN;
        end
    end
endmodule