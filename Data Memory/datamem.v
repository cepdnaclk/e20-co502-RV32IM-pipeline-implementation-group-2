// module data_memory(CLK,RESET,READ,FUNCT3,WRITE,ADDRESS,WRITEDATA,READDATA,BUSYWAIT);
// input           CLK;
// input           RESET;
// input           READ;
// input [2:0]     FUNCT3;
// input           WRITE;
// input[31:0]      ADDRESS;
// input[31:0]      WRITEDATA;
// output reg [31:0] READDATA;
// output reg BUSYWAIT;

// // Declare memory array 1024 x 8-bits 
// reg [7:0] memory_array [0:1023];

// //Busy wait
// always @(READ or WRITE)
// begin
//     if(READ || WRITE)
//         BUSYWAIT = 1;
//     else
//         BUSYWAIT = 0;
// end

// //Reading & writing
// always @(posedge CLK)
// begin
//     if(READ)
//     begin
//         READDATA =#40 {memory_array[ADDRESS],memory_array[ADDRESS+1],memory_array[ADDRESS+2],memory_array[ADDRESS+3]};
//     end
//     if(WRITE)
// 	begin
//         case(FUNCT3)
//         3'b000: //SB
//         begin
//             memory_array[ADDRESS] <=#40 WRITEDATA[7:0];
//         end
//         3'b001: //SH
//         begin
//             memory_array[ADDRESS]   <=#40 WRITEDATA[7:0];    
//             memory_array[ADDRESS+1] <=#40 WRITEDATA[15:8];   
//         end
//         3'b010: //SW
//         begin
//             memory_array[ADDRESS]   <=#40 WRITEDATA[7:0];    
//             memory_array[ADDRESS+1] <=#40 WRITEDATA[15:8];   
//             memory_array[ADDRESS+2] <=#40 WRITEDATA[23:16]; 
//             memory_array[ADDRESS+3] <=#40 WRITEDATA[31:24];  
//         end
//         endcase
//     end
// end

// integer i;

// //Reset memory
// always @(posedge RESET)
// begin
//     if (RESET)
//     begin
//         for (i=0;i<1024; i=i+1)
//             memory_array[i] <= 0;
//     end
// end

// endmodule

module data_memory(CLK,RESET,READ,FUNCT3,WRITE,ADDRESS,WRITEDATA,READDATA,BUSYWAIT);
input           CLK;
input           RESET;
input           READ;
input [2:0]     FUNCT3;
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
always @(*)
begin
    if(READ)
    begin
        READDATA =#1 {memory_array[ADDRESS+3],memory_array[ADDRESS+2],memory_array[ADDRESS+1],memory_array[ADDRESS]};
    end
    if(WRITE)
	begin
        case(FUNCT3)
        3'b000: //SB
        begin
            #2
            memory_array[ADDRESS] <= WRITEDATA[7:0];
        end
        3'b001: //SH
        begin
            #2
            memory_array[ADDRESS]   <= WRITEDATA[7:0];    
            memory_array[ADDRESS+1] <= WRITEDATA[15:8];   
        end
        3'b010: //SW
        begin
            #2
            memory_array[ADDRESS]   <= WRITEDATA[7:0];    
            memory_array[ADDRESS+1] <= WRITEDATA[15:8];   
            memory_array[ADDRESS+2] <= WRITEDATA[23:16]; 
            memory_array[ADDRESS+3] <= WRITEDATA[31:24];  
        end
        endcase
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
