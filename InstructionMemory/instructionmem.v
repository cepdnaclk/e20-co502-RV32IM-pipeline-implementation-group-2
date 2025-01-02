
module instruction_memory(CLK,READ,ADDRESS,READINST,BUSYWAIT);
input				CLK;
input				READ;
input[31:0]			ADDRESS;
output reg [31:0]	READINST;
output	reg			BUSYWAIT;



//Declare memory array 1024x8-bits 
reg [7:0] memory_array [1023:0];

//Initialize instruction memory
initial
begin
	BUSYWAIT = 0;
	

  //Hardcoded instructions
  
   {memory_array[10'd3],  memory_array[10'd2],  memory_array[10'd1],  memory_array[10'd0]}  = 32'b00000000000001000000000000011001; // loadi 4 #25
   {memory_array[10'd7],  memory_array[10'd6],  memory_array[10'd5],  memory_array[10'd4]}  = 32'b00000000000001010000000000100011; // loadi 5 #35
   {memory_array[10'd11], memory_array[10'd10], memory_array[10'd9],  memory_array[10'd8]}  = 32'b00000010000001100000010000000101; // add 6 4 5
   {memory_array[10'd15], memory_array[10'd14], memory_array[10'd13], memory_array[10'd12]} = 32'b00000000000000010000000001011010; // loadi 1 90
   {memory_array[10'd19], memory_array[10'd18], memory_array[10'd17], memory_array[10'd16]} = 32'b00000011000000010000000100000100; // sub 1 1 4

end

//Detecting an incoming memory access
always @(READ)
begin
    BUSYWAIT = (READ)? 1 : 0;
end

//Reading
always @(posedge CLK)
begin
	if(READ)
	begin
        READINST[7:0]     = #40 memory_array[{ADDRESS,4'b0000}];
        READINST[15:8]    = #40 memory_array[{ADDRESS,4'b0001}];
        READINST[23:16]   = #40 memory_array[{ADDRESS,4'b0010}];
        READINST[31:24]   = #40 memory_array[{ADDRESS,4'b0011}];
        BUSYWAIT = 0;
	end
end

endmodule