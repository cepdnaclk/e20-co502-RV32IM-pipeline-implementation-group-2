module data_memory(CLK,RESET,READ,WRITE,ADDRESS,WRITEDATA,READDATA);
input           CLK;
input           RESET;
input           READ;
input           WRITE;
input[31:0]      ADDRESS;
input[31:0]      WRITEDATA;
output reg [31:0] READDATA;

// Declare memory array 1024 x 8-bits 
reg [7:0] memory_array [0:1023];
integer i;

//Reading & writing
always @(posedge CLK or posedge RESET)
begin
    //reset memory
    if (RESET) begin
        for (i = 0; i < 1024; i = i + 1) begin
            memory_array[i] <= 8'b0; // Clear memory byte-by-byte
        end
    end

    // Write to memory
    if(WRITE)
	begin
        memory_array[ADDRESS]   <= WRITEDATA[7:0];    
        memory_array[ADDRESS+1] <= WRITEDATA[15:8];   
        memory_array[ADDRESS+2] <= WRITEDATA[23:16]; 
        memory_array[ADDRESS+3] <= WRITEDATA[31:24];  
    end
end


always @(*) begin
    if (READ) begin
        READDATA = {memory_array[ADDRESS],      // LSB
                    memory_array[ADDRESS + 1],  // Byte 1
                    memory_array[ADDRESS + 2],  // Byte 2
                    memory_array[ADDRESS + 3]}; // MSB
        end 
        else begin
            READDATA = 32'b0; // Default value when READ is not enabled
        end
    end

endmodule
