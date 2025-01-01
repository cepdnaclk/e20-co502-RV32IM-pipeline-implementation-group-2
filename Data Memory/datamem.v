module data_memory(CLK,RESET,READ,WRITE,ADDRESS,WRITEDATA,READDATA,BUSYWAIT);
input           CLK;
input           RESET;
input           READ;
input           WRITE;
input[31:0]      ADDRESS;
input[31:0]      WRITEDATA;
output reg [31:0] READDATA;
output reg BUSYWAIT;

// Declare memory array 1024 x 8-bits 
reg [7:0] memory_array [0:1023];

//Busy wait
always @(READ or WRITE)
begin
    if(READ || WRITE)
        BUSYWAIT = 1;
    else
        BUSYWAIT = 0;
end

//Reading & writing
always @(posedge CLK)
begin
    if(READ)
    begin
        READDATA =#40 {memory_array[ADDRESS],memory_array[ADDRESS+1],memory_array[ADDRESS+2],memory_array[ADDRESS+3]};
    end
    if(WRITE)
	begin
        memory_array[ADDRESS]   <=#40 WRITEDATA[7:0];    
        memory_array[ADDRESS+1] <=#40 WRITEDATA[15:8];   
        memory_array[ADDRESS+2] <=#40 WRITEDATA[23:16]; 
        memory_array[ADDRESS+3] <=#40 WRITEDATA[31:24];  
    end
end

integer i;

//Reset memory
always @(posedge RESET)
begin
    if (RESET)
    begin
        for (i=0;i<1024; i=i+1)
            memory_array[i] <= 0;
    end
end

endmodule
