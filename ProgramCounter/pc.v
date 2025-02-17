module pc (PCIN,RESET,CLK,PCOUT ,BUBBLE);
    input [31:0] PCIN;
    input RESET,CLK,BUBBLE;
    output reg [31:0] PCOUT;

    always @(posedge CLK)
    begin
        if(RESET)
        begin
            #2
            PCOUT <= 0;
        end
        else if(!BUBBLE)begin
            #2
            PCOUT <= PCIN;
        end
    end
endmodule