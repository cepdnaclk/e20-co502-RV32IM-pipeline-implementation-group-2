module dcache(CLK,RESET,READ,WRITE,ADDRESS,WRITEDATA,READDATA,BUSYWAIT,MEM_READ,MEM_WRITE,MEM_WRITEDATA,MEM_READDATA,MEM_ADDRESS,MEM_BUSYWAIT);
input           CLK;
input           RESET;
input           READ;
input           WRITE;
input[31:0]     ADDRESS;
input[31:0]     WRITEDATA;
output reg [31:0] READDATA;
output reg BUSYWAIT;
input           MEM_READ;
input           MEM_WRITE;
input[31:0]     MEM_WRITEDATA;
output reg [31:0] MEM_READDATA;
input[31:0]     MEM_ADDRESS;
output reg MEM_BUSYWAIT;

reg valid_bits[7:0]; 
reg dirty_bits[7:0];
reg [2:0] tags[7:0];
reg [127:0] data_blocks[31:0];





endmodule