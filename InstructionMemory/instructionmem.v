

// module instruction_memory(CLK,READ,ADDRESS,READINST,BUSYWAIT);
// input				CLK;
// input				READ;
// input[5:0]			ADDRESS;
// output reg [127:0]	READINST;
// output	reg			BUSYWAIT;




// //Declare memory array 1024x8-bits 
// reg [7:0] memory_array [1023:0];

// //Initialize instruction memory
// initial
// begin
// 	BUSYWAIT = 0;
	

  //Hardcoded instructions

  
//    {memory_array[10'd3],  memory_array[10'd2],  memory_array[10'd1],  memory_array[10'd0]}  = 32'b00000000000001000000000000011001; // loadi 4 #25
//    {memory_array[10'd7],  memory_array[10'd6],  memory_array[10'd5],  memory_array[10'd4]}  = 32'b00000000000001010000000000100011; // loadi 5 #35
//    {memory_array[10'd11], memory_array[10'd10], memory_array[10'd9],  memory_array[10'd8]}  = 32'b00000010000001100000010000000101; // add 6 4 5
//    {memory_array[10'd15], memory_array[10'd14], memory_array[10'd13], memory_array[10'd12]} = 32'b00000000000000010000000001011010; // loadi 1 90
//    {memory_array[10'd19], memory_array[10'd18], memory_array[10'd17], memory_array[10'd16]} = 32'b00000011000000010000000100000100; // sub 1 1 4

// end

// //Detecting an incoming memory access
// always @(READ)
// begin
//     BUSYWAIT = (READ)? 1 : 0;
// end

// //Reading
// always @(posedge CLK)
// begin
// 	if(READ)
// 	begin
//         READINST[7:0]     = #40 memory_array[{ADDRESS,4'b0000}];
//         READINST[15:8]    = #40 memory_array[{ADDRESS,4'b0001}];
//         READINST[23:16]   = #40 memory_array[{ADDRESS,4'b0010}];
//         READINST[31:24]   = #40 memory_array[{ADDRESS,4'b0011}];
//         READINST[39:32]   = #40 memory_array[{ADDRESS,4'b0100}];
//         READINST[47:40]   = #40 memory_array[{ADDRESS,4'b0101}];
//         READINST[55:48]   = #40 memory_array[{ADDRESS,4'b0110}];
//         READINST[63:56]   = #40 memory_array[{ADDRESS,4'b0111}];
//         READINST[71:64]   = #40 memory_array[{ADDRESS,4'b1000}];
//         READINST[79:72]   = #40 memory_array[{ADDRESS,4'b1001}];
//         READINST[87:80]   = #40 memory_array[{ADDRESS,4'b1010}];
//         READINST[95:88]   = #40 memory_array[{ADDRESS,4'b1011}];
//         READINST[103:96]  = #40 memory_array[{ADDRESS,4'b1100}];
//         READINST[111:104] = #40 memory_array[{ADDRESS,4'b1101}];
//         READINST[119:112] = #40 memory_array[{ADDRESS,4'b1110}];
//         READINST[127:120] = #40 memory_array[{ADDRESS,4'b1111}];
//         BUSYWAIT = 0;
// 	end
// end

// endmodule

module instruction_memory (          // Clock signal
    input RESET,          // Reset signal
    input [31:0] PC,      // 32-bit Program Counter
    output reg [31:0] INSTRUCTION // 32-bit instruction output
);

// Declare memory array 256x32-bits (to simplify)
reg [31:0] memory_array [0:255]; // Memory to store instructions

// Initialize the instruction memory
initial begin
// Initialize registers
memory_array[0] = 32'b000000000111_00000_000_00110_0010011;   // ADDI x6, x0, 7   (x6 = 7)
memory_array[1] = 32'b000000001011_00000_000_00100_0010011;   // ADDI x4, x0, 11  (x4 = 11)
memory_array[2] = 32'b000000001100_00000_000_00101_0010011;   // ADDI x5, x0, 12  (x5 = 12)

// Register dependency hazard (x7 depends on x6)
memory_array[3] = 32'b0000000_00100_00110_000_00111_0110011;  // ADD x7, x6, x4   (x7 = x6 + x4 = 18)

// Store x4 in memory  
memory_array[4] = 32'b0000000_00100_00000_010_00000_0100011;  // SW x4, 0(x0)  (memory[0] = x4)

// Load-Use Hazard
memory_array[5] = 32'b0000000_00000_00000_010_01000_0000011;  // LW x8, 0(x0)  (Load memory[0] → x8)

memory_array[6] = 32'b0000000_00111_00101_000_00111_0110011;  // ADD x7, x7, x5   (x7 = x7 + x5 = 30)
memory_array[7] = 32'b0000000_01000_00100_000_01001_0110011;  // ADD x9, x8, x4 (x9 = x8 + x4) <-- Load-Use Hazard

// Store x9 and then load it (store-load hazard)

memory_array[8] = 32'b0000000_00000_00000_010_01010_0000011;  // LW x10, 4(x0)  (x10 = memory[4]) <-- Possible RAW hazard
memory_array[9] = 32'b0000000_01010_00000_010_01000_0100011;  // SW x10, 8(x0)  (memory[4] = x5)
// ADD and SUB hazards
memory_array[10] = 32'b0000000_01010_00101_000_01011_0110011;  // ADD x11, x10, x5 (x11 = x10 + x5)
memory_array[11] = 32'b0100000_00110_01011_000_01100_0110011;  // SUB x12, x11, x6 (x12 = x11 - x6)

// Store and reload x12
memory_array[12] = 32'b0000000_01100_00000_010_01000_0100011;  // SW x12, 8(x0) (memory[8] = x12)
memory_array[13] = 32'b0000000_01000_00000_010_01101_0000011;  // LW x13, 8(x0) (x13 = memory[8])

// Final computation to check correctness
memory_array[14] = 32'b0000000_01101_01100_000_01110_0110011;  // ADD x14, x13, x12 (Final verification step)
memory_array[15] = 32'b000000000000_00000_000_00000_1110011;  // EBREAK (Stop execution)



   

  //  memory_array[3] = 32'b1111001_01100_00001_010_00011_0100011;  // SW x12, 0xF23(x1) 
    // Add more instructions as needed
end
//Reading

// Fetch instruction based on PC
always @(PC,RESET) begin
    #1
    if (RESET) begin
        INSTRUCTION <= 32'b0; // Output zero on reset
    end else begin
        INSTRUCTION <= memory_array[PC[9:2]]; // Fetch instruction (PC[9:2] to align with 32-bit words)
    end

end

endmodule
