module dcache(CLK,RESET,READ,WRITE,ADDRESS,WRITEDATA,READDATA,BUSYWAIT,MEM_READ,MEM_WRITE,MEM_WRITEDATA,MEM_READDATA,MEM_ADDRESS,MEM_BUSYWAIT);
input CLK;
input RESET;
input MEM_READ;                            // memory MEM_READ signal coming from CPU
input MEM_WRITE;                           // memory MEM_WRITE signal coming from CPU
input [31:0] MEM_ADDRESS;                  // memory MEM_ADDRESS coming from ALU
input [31:0] DATA_IN;                      // data coming from register file
input MEM_BUSYWAIT;                        // Signal coming from data memory indicating memory is busy or not
input [127:0] MEM_READ_OUT;                // Newly fetched data word from memory
output reg[31:0] CACHE_READ_OUT;           // Data blocks, MEM_READ asynchronously according to the offset from the cache to send to register file
output reg MEM_MEM_READ, MEM_MEM_WRITE;    // Send MEM_MEM_READ, MEM_MEM_WRITE signals to data memory indicating memory is busy or not MEM_READing & writing
output reg BUSYWAIT;                       // Send signal to stall the CPU on a memory MEM_READ/MEM_WRITE instruction
output reg [27:0] MEM_BLOCK_ADDR;          // Send block MEM_ADDRESS to data memory to fetch data words
output reg [127:0] MEM_WRITE_OUT ;         // Send data word to MEM_WRITE to data memory

//cache implementation
reg VALID_BITS [7:0]; //1 valid bit for each data block
reg DIRTY_BITS [7:0]; //1 dirty bit for each data block
reg [26:0] TAG [7:0]; //25 bit tag for each data block
reg [127:0] DATA_BLOCKS [7:0]; //4 word 8 blocks

integer i; // loop counter

//incoming information from cpu

reg  MEM_READhit; //MEM_READ hit signal
reg [2:0] index; //index of coming address
reg [26:0] tag; //tag of coming address
reg [1:0] offset; //offset of coming address

//extract information form coming address 
always @(MEM_ADDRESS, MEM_READ, MEM_WRITE)
begin
    // Extract tag, index, and offset from the 32-bit memory address
    tag = MEM_ADDRESS[31:5];      // Upper 27 bits for the tag
    index = MEM_ADDRESS[4:2];     // Middle 3 bits for the index
    offset = MEM_ADDRESS[1:0];    // Lower 2 bits for the offset
end

//reset cache
always @(RESET)
begin
    for(i = 0; i < 8; i = i + 1)
    begin
        VALID_BITS[i] = 1'b0;
        DIRTY_BITS[i] = 1'b0;
        TAG[i] = 27'dx;
        DATA_BLOCKS[i] = 128'dx;
    end
end




endmodule

`timescale 1ns/100ps

module dcache (
    CLK,
    RESET,
    MEM_READ,
    MEM_WRITE,
    MEM_ADDRESS,
    DATA_IN,
    MEM_BUSYWAIT,
    MEM_READ_OUT,
    CACHE_READ_OUT,
    MEM_MEM_READ,
    MEM_MEM_WRITE,
    BUSYWAIT,
    MEM_BLOCK_ADDR,    MEM_WRITE_OUT     
);

    input CLK;
    input RESET;
    input MEM_READ;                            // memory MEM_READ signal coming from CPU
    input MEM_WRITE;                           // memory MEM_WRITE signal coming from CPU
    input [31:0] MEM_ADDRESS;                  // memory MEM_ADDRESS coming from ALU
    input [31:0] DATA_IN;                      // data coming from register file
    input MEM_BUSYWAIT;                        // Signal coming from data memory indicating memory is busy or not
    input [127:0] MEM_READ_OUT;                // Newly fetched data word from memory
    output reg[31:0] CACHE_READ_OUT;           // Data blocks, MEM_READ asynchronously according to the offset from the cache to send to register file
    output reg MEM_MEM_READ, MEM_MEM_WRITE;    // Send MEM_MEM_READ, MEM_MEM_WRITE signals to data memory indicating memory is busy or not MEM_READing & writing
    output reg BUSYWAIT;                       // Send signal to stall the CPU on a memory MEM_READ/MEM_WRITE instruction
    output reg [27:0] MEM_BLOCK_ADDR;          // Send block MEM_ADDRESS to data memory to fetch data words
    output reg [127:0] MEM_WRITE_OUT ;         // Send data word to MEM_WRITE to data memory

    
    /*
    Combinational part for indexing, tag comparison for hit deciding, etc.
    ...
    ...
    */

    reg STORE_VALID [7:0];              // 8 Registers to store 1 bit valid for each data block
    reg STORE_DIRTY [7:0];              // 8 Registers to store 1 bit dirty for each data block
    reg [24:0] STORE_TAG [7:0];          // 8 Registers to store 3 bit tag for each data block
    reg [127:0] STORE_DATA [7:0];        // 8 Registers to store 32 bit data block

    integer i;

    reg  MEM_READhit;
    reg [2:0] index;
    reg [24:0] tag;
    reg [1:0] offset;

    always @(MEM_ADDRESS,MEM_READ ,MEM_WRITE)
    begin
    
        // extract tag, index and offset from input MEM_ADDRESS
         {tag,index,offset} = MEM_ADDRESS;

    end


    // RESET data cache
    always @ (RESET)
    begin
        for(i = 0; i < 8; i++) begin
            STORE_VALID[i] = 1'd0;
            STORE_DIRTY[i] = 1'd0;
            STORE_TAG[i] = 25'dx;
            STORE_DATA[i] = 128'dx;
        end
    end

    wire VALID, DIRTY;      // To store 1 bit valid & 1 bit dirty bits corresponding to index given by memory MEM_ADDRESS
    wire [24:0] TAG;         // To store 3 bit tag corresponding to index given by memory MEM_ADDRESS
    reg [127:0] DATA;        // To store 32 bit data corresponding to index given by memory MEM_ADDRESS


    // Decide whether CPU should be stalled in order to perform memory MEM_READ or MEM_WRITE
    always @ (MEM_READ, MEM_WRITE)
    begin
        if (MEM_READ || MEM_WRITE) begin
            BUSYWAIT = 1'b1;
        end else begin
            BUSYWAIT = 1'b0;
        end
    end

    always @ (*)
    begin
        #1
        DATA = STORE_DATA[MEM_ADDRESS[index]];            // Getting 32 bit data corresponding to index given by memory MEM_ADDRESS
    end

    assign #1 VALID = STORE_VALID[index];    // Getting valid bit corresponding to index given by memory MEM_ADDRESS
    assign #1 DIRTY = STORE_DIRTY[index];    // Getting dirty bit corresponding to index given by memory MEM_ADDRESS
    assign #1 TAG = STORE_TAG[index];        // Getting tag 3 bits corresponding to index given by memory MEM_ADDRESS


    wire COMPARATORSIGNAL;  // To store whether tag bits in corresponding index & tag bits given by memory MEM_ADDRESS matches
    wire HITSIGNAL;         // To store whether a 'hit' or a 'miss'


    // Getting whether tag bits in corresponding index & tag bits given by memory MEM_ADDRESS matches
    assign #0.9 COMPARATORSIGNAL = (TAG == tag) ? 1 : 0;


    // If tag bits given by memory MEM_ADDRESS matches with tag bits in corresponding index of cache memory & if it is a valid data block, it is a 'hit'(1)
    // If tag bits given by memory MEM_ADDRESS mismatches with tag bits in corresponding index of cache memory or if it is not a valid data block, it is a 'miss'(0)
    assign HITSIGNAL = COMPARATORSIGNAL && VALID;

    // If it is a hit, CPU should not be stalled. So, MEM_BUSYWAIT should be de-asserted
    always @ (posedge CLK)
    if (HITSIGNAL) begin
        BUSYWAIT = 1'b0;
    end


    
 
    always @(posedge CLK) begin
    if((MEM_WRITE||MEM_READ) && HITSIGNAL) 
    begin
    MEM_READhit = 1;
   //MEM_READindex = index;
    end
end

    // MEM_READing data blocks asynchronously from the cache to send to register file according to the offset, if it is a MEM_READ hit
    always @(*)
	begin
	if(MEM_READhit)begin
		case(offset)
			'b00:	
                 #1 CACHE_READ_OUT = STORE_DATA[index][31:0];
			'b01:	
                 #1 CACHE_READ_OUT = STORE_DATA[index][63:32];
			'b10:	
                 #1 CACHE_READ_OUT = STORE_DATA[index][95:64];
			'b11:	
                 #1 CACHE_READ_OUT = STORE_DATA[index][127:96];
		endcase
            MEM_READhit = 0;
            state = IDLE;

	end
	end

    


    // Writing data blocks to the cache if it is a 'hit' according to the offset
    always @ (posedge CLK)
    begin
        if (HITSIGNAL && MEM_WRITE) begin
            #1;
            STORE_DIRTY[MEM_ADDRESS[4:2]] = 1'b1;       // dirty bit of the index is set as data block in cache is updated with data coming from register file (indicate that the block of data is inconsistant)

            if (offset == 2'b00) begin
                STORE_DATA[index][31:0] = DATA_IN;
            end else if (offset == 2'b01) begin
                STORE_DATA[index][63:32] = DATA_IN;
            end else if (offset == 2'b10) begin
                STORE_DATA[index][95:64] = DATA_IN;
            end else if (offset == 2'b11) begin
                STORE_DATA[index][127:96] = DATA_IN;
            end
        end
    end


    /* Cache Controller FSM Start */

    parameter IDLE = 2'b00, MEM_MEM_READ_STATE = 2'b01, MEM_MEM_WRITE_STATE = 2'b10, CACHE_UPDATE = 2'b11;
    reg [1:0] state, next_state;

    // combinational next state logic
    always @(*)
    begin
        case (state)
            IDLE:
                if ((MEM_READ || MEM_WRITE) && !DIRTY && !HITSIGNAL)  
                    next_state = MEM_MEM_READ_STATE;          // If it is a 'miss' and the block isn’t dirty, the missing data block should be MEM_READ from the memory
                else if ((MEM_READ || MEM_WRITE) && DIRTY && !HITSIGNAL)
                    next_state = MEM_MEM_WRITE_STATE;         // If it is a 'miss' and the block is dirty, that block must be written back to the memory
                else
                    next_state = IDLE;              // If it is a 'hit', either update data block in cache or MEM_READ data from cache
            
            MEM_MEM_READ_STATE:
                if (MEM_BUSYWAIT)
                    next_state = MEM_MEM_READ_STATE;          // Keep MEM_READing whole data word from memory until the memory de-asserts its BUSYWAIT signal
                else    
                    next_state = CACHE_UPDATE;      // Update cache memory with data word MEM_READ from data memory

            MEM_MEM_WRITE_STATE:
                if (MEM_BUSYWAIT)
                    next_state = MEM_MEM_WRITE_STATE;         // Keep writing data to the memory until the memory de-asserts its BUSYWAIT signal
                else    
                    next_state = MEM_MEM_READ_STATE;          // Fetch required data word from memory

            CACHE_UPDATE:
                next_state = IDLE;                  // Either update data block in cache or MEM_READ data from cache
            
        endcase
    end

    // combinational output logic
    always @(state)
    begin
        case(state)

            // Either update data block in cache or MEM_READ data from cache (Without accessing data memory)
            IDLE:
            begin

                MEM_MEM_READ = 0;
                MEM_MEM_WRITE = 0;
                MEM_BLOCK_ADDR = 6'dx;
                MEM_WRITE_OUT  = 32'dx;
                BUSYWAIT = 0;

            end
         
            // State of fetching required data word from memory
            MEM_MEM_READ_STATE: 
            begin

                MEM_MEM_READ = 1;                       // Enable 'MEM_MEM_READ' to send to data memory to assert 'MEM_BUSYWAIT' in order to stall the CPU
                MEM_MEM_WRITE = 0;
                MEM_BLOCK_ADDR = {MEM_ADDRESS[7:2]};       // Derive block MEM_ADDRESS from the MEM_ADDRESS coming from ALU to send to data memory
               MEM_WRITE_OUT  = 32'dx;

            end
            
            // State of writing data to the memory
            MEM_MEM_WRITE_STATE: 
            begin

                MEM_MEM_READ = 0;
                MEM_MEM_WRITE = 1;                      // Enable 'MEM_MEM_WRITE' to send to data memory to assert 'MEM_BUSYWAIT' in order to stall the CPU
                MEM_BLOCK_ADDR = {TAG,index};   // Derive block MEM_ADDRESS to send to data memory to store a existing cache data word
                  MEM_WRITE_OUT  = DATA;               // Getting existing cache data word corresponding to index

            end

            // State of updating cache memory with data word MEM_READ from data memory
            CACHE_UPDATE:
            begin

                MEM_MEM_READ = 0;
                MEM_MEM_WRITE = 0;
                MEM_BLOCK_ADDR = 6'dx;
                MEM_WRITE_OUT  = 32'dx;

                #1
                STORE_DATA[index] = MEM_READ_OUT;    // Update current cache data word with newly fetched data from memory
                STORE_TAG[index] = tag;     // Update 'STORE_TAG' array with tag bits corresponding to the MEM_ADDRESS
                STORE_VALID[index] = 1'b1;           // Set the newly fetched data from memory as valid
                STORE_DIRTY[index] = 1'b0;           // Set that newly fetched data is consistant with the data word in memory

            end

        endcase
    end

    //  logic  transitioning 
    always @(posedge CLK, RESET)
    begin
        if(RESET)
            state = IDLE;
        else
            state = next_state;
    end

    /* Cache Controller FSM End */


    // dumping register values to .vcd file
    initial
    begin
        $dumpfile("cpu_wavedata.vcd");
        for(i=0;i<8;i++)
            $dumpvars(1,STORE_DATA[i], STORE_TAG[i], STORE_VALID[i], STORE_DIRTY[i]);
    end

endmodule