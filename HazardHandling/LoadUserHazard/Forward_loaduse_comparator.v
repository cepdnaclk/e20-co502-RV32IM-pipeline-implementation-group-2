module LoadUseComparator (FORWARD_RS1, FORWARD_RS2,LOAD_USE_RS1,LOAD_USE_RS2,CORRECT_FORWARD_RS1,CORRECT_FORWARD_RS2);
    input [1:0] FORWARD_RS1, FORWARD_RS2,LOAD_USE_RS1,LOAD_USE_RS2;
    output reg [1:0] CORRECT_FORWARD_RS1, CORRECT_FORWARD_RS2;
    always @(FORWARD_RS1, FORWARD_RS2,LOAD_USE_RS1,LOAD_USE_RS2) begin
        if( LOAD_USE_RS1 == 2'b01 || LOAD_USE_RS2 == 2'b01)begin
            if (LOAD_USE_RS1 == 2'b01) begin
                CORRECT_FORWARD_RS1 = 2'b01;
            end else if (LOAD_USE_RS2 == 2'b01) begin
                CORRECT_FORWARD_RS2 = 2'b01;
            end else begin
                CORRECT_FORWARD_RS1 = 2'b01;
                CORRECT_FORWARD_RS2 = 2'b01;
            end
        end
        else begin
            CORRECT_FORWARD_RS1 = FORWARD_RS1;
            CORRECT_FORWARD_RS2 = FORWARD_RS2;
        end
    end

    
endmodule