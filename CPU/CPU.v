`include "../MUX_32bit/MUX_32bit.v"
`include "../MUX_32bit/MUX_32bit_4input.v"
`include "../ALUunit/ALU.v"
`include "../programCounter/pc.v"
`include "../Adder/adder.v"
`include "../BranchController/BranchController.v"
`include "../ControlUnit/ControlUnit.v"
`include "../Data Memory/datamem.v"
`include "../EX_MEM_pipeline/EX_MEM_pipeline.v"
`include "../ID_EXPipeline/ID_ExPipeline.v"
`include "../ID_IF_pipeline/ID_IF_register.v"
`include "../ImidiateGenarator/imidiateGenarator.v"
`include "../InstructionMemory/instructionmem.v"
`include "../RegisterFile/registerfile.v"
`include "../MEM_WBPipline/Mem_WBPipeline.v"
`include "../HazardHandling/Forwarding.v"
`include "../HazardHandling/LoadUserHazard/load_use_hazard.v"
`include "../HazardHandling/LoadUserHazard/Forward_loaduse_comparator.v"

module CPU (CLK, RESET);
    input CLK, RESET;
    wire [31:0] INSTRUCTION;
    wire [31:0] PC, PC_PLUS_4,  WRITEDATA, DATA1, DATA2, ALURESULT, TARGETEDADDRESS,PC_MUX_OUT,PCOUT;
    wire PCADDRESSCONTROLLER, BRANCH, JUMP, MEMREAD, MEMWRITE, JUMPANDLINK, WRITEENABLE, MEMORYACCESS;
    wire [1:0] ControlUnitIMMEDIATESELECT,ControlUnitOFFSETGENARATOR,IMMEDIATESELECT,OFFSETGENARATOR;
    
    wire [4:0] ALU_OPCODE;
    wire [2:0] IMMEDIATE_TYPE;
    wire [4:0] RS1, RS2;
    wire [31:0] IMMEDIATE_VALUE;
    assign RS1 = INSTRUCTION_OUT[19:15];
    assign RS2 = INSTRUCTION_OUT[24:20];
    //ID_IF pipeline out

    wire [31:0] INSTRUCTION_OUT, PC_OUT, PC_PLUS_4_OUT;

    //ID_EX pipeline out
    wire WRITEENABLE_IDOUT,MEMORYACCESS_IDOUT,MEMWRITE_IDOUT,MEMREAD_IDOUT,JAL_IDOUT,BRANCH_IDOUT,JUMP_IDOUT,FORWARD_MEMORY_IDOUT;
    wire[1:0] IMMEDIATESELECT_IDOUT,OFFSETGENARATOR_IDOUT;
    wire [4:0] ALU_OPCODE_IDOUT,WRITEADDRESS_IDOUT;
    wire [31:0] PC_IDOUT,PC_PLUS_4_IDOUT,DATA1_IDOUT,DATA2_IDOUT,IMMEDIATE_VALUE_IDOUT;
    wire [2:0] FUNCT3_IDOUT;

    // data muxes out
    wire [31:0] Data1_MUX_OUT, Data2_MUX_OUT;

    //JAL mux out
    wire [31:0] JAL_MUX_OUT;

    //EX_MEM pipeline out
    wire WRITEENABLE_EXOUT,MEMORYACCESS_EXOUT,MEMWRITE_EXOUT,MEMREAD_EXOUT,FORWARD_MEMORY_EXOUT;
    wire [31:0] ALURESULT_EXOUT,DATA2_EXOUT;
    wire [4:0] WRITEADDRESS_EXOUT;
    wire [2:0] FUNCT3_EXOUT;

    //data memory out
    wire [31:0] DATA_OUT;

    //BUSYWAIT
    wire BUSYWAIT;

    //MEM_WB pipeline out
    wire WRITEENABLE_MEMOUT,MEMORYACCESS_MEMOUT;
    wire [31:0] ALURESULT_MEMOUT,READDATA_MEMOUT;
    wire [4:0] WRITEADDRESS_MEMOUT;

    // Data memory mux
    wire [31:0] DATA2_FORWARD;

    // load use hazard
    wire BUBBLE;
    wire [1:0] FRWD_RS1_WB, FRWD_RS2_WB;
    wire FORWARD_MEMORY;;

    // Forwarding
    wire [1:0] FORWARD_RS1, FORWARD_RS2;
    wire [1:0] Out_Load_Use_Hazard_RS1, Out_Load_Use_Hazard_RS2;
    


// instruction fetch stage
    instruction_memory instructionmem1(RESET,PCOUT, INSTRUCTION);
    MUX_32bit PC_MUX(PC_PLUS_4, TARGETEDADDRESS, PCADDRESSCONTROLLER, PC_MUX_OUT);
    pc pc1(PC_MUX_OUT, RESET, CLK, PCOUT ,BUBBLE);
    adder pc_4_adder(PCOUT,PC_PLUS_4);
    ID_IF_register ID_IF_register1(CLK, INSTRUCTION,PCOUT,PC_PLUS_4,RESET,BUBBLE,INSTRUCTION_OUT,PC_OUT,PC_PLUS_4_OUT);

// instruction decode stage
    controlUnit controlunit1(INSTRUCTION_OUT, WRITEENABLE, MEMORYACCESS, MEMWRITE, MEMREAD, JUMPANDLINK, ALU_OPCODE, ControlUnitIMMEDIATESELECT, ControlUnitOFFSETGENARATOR, BRANCH, JUMP, IMMEDIATE_TYPE);
    Forward immForwarding(INSTRUCTION_OUT,ControlUnitIMMEDIATESELECT,ControlUnitOFFSETGENARATOR,WRITEADDRESS_IDOUT,WRITEADDRESS_EXOUT,IMMEDIATESELECT,OFFSETGENARATOR);
    load_use_hazard load_use_hazard1(MEMREAD_IDOUT,MEMWRITE,RS1,RS2,WRITEADDRESS_IDOUT,FRWD_RS1_WB,FRWD_RS2_WB,BUBBLE,FORWARD_MEMORY);
    RegisterFile registerfile1(RS1,RS2,WRITEDATA,WRITEADDRESS_MEMOUT,WRITEENABLE_MEMOUT,RESET,CLK,DATA1,DATA2);
    imidiateGenarator imidiateGenarator1(INSTRUCTION_OUT,IMMEDIATE_TYPE,IMMEDIATE_VALUE);
    ID_ExPipeline ID_EXPipeline1(CLK,RESET,BUBBLE,WRITEENABLE,MEMORYACCESS,MEMWRITE,MEMREAD,JUMPANDLINK,ALU_OPCODE,IMMEDIATESELECT,OFFSETGENARATOR,BRANCH,JUMP,PC_OUT,PC_PLUS_4_OUT,DATA1,DATA2,INSTRUCTION_OUT,IMMEDIATE_VALUE,WRITEENABLE_IDOUT,MEMORYACCESS_IDOUT,MEMWRITE_IDOUT,MEMREAD_IDOUT,JAL_IDOUT,ALU_OPCODE_IDOUT,IMMEDIATESELECT_IDOUT,OFFSETGENARATOR_IDOUT,BRANCH_IDOUT,JUMP_IDOUT,PC_IDOUT,PC_PLUS_4_IDOUT,DATA1_IDOUT,DATA2_IDOUT,WRITEADDRESS_IDOUT,FUNCT3_IDOUT,IMMEDIATE_VALUE_IDOUT,FRWD_RS1_WB,FRWD_RS2_WB,Out_Load_Use_Hazard_RS1,Out_Load_Use_Hazard_RS2,FORWARD_MEMORY,FORWARD_MEMORY_IDOUT);

// Execution stage
    LoadUseComparator LoadUseComparator1(OFFSETGENARATOR_IDOUT,IMMEDIATESELECT_IDOUT,Out_Load_Use_Hazard_RS1,Out_Load_Use_Hazard_RS2,FORWARD_RS1,FORWARD_RS2);
    MUX_32bit_4input Data1_MUX(DATA1_IDOUT,PC_IDOUT,ALURESULT_EXOUT,WRITEDATA,FORWARD_RS1,Data1_MUX_OUT);
    MUX_32bit_4input Data2_MUX(DATA2_IDOUT,IMMEDIATE_VALUE_IDOUT,ALURESULT_EXOUT,WRITEDATA,FORWARD_RS2,Data2_MUX_OUT);
    alu ALU(Data1_MUX_OUT,Data2_MUX_OUT,ALU_OPCODE_IDOUT,ALURESULT);
    MUX_32bit JAL_MUX(ALURESULT,PC_PLUS_4_IDOUT,JAL_IDOUT,JAL_MUX_OUT);
    BranchController BranchController1(DATA1_IDOUT,DATA2_IDOUT,FUNCT3_IDOUT,ALURESULT,BRANCH_IDOUT,JUMP_IDOUT,TARGETEDADDRESS,PCADDRESSCONTROLLER);
    EX_MEM_pipeline EX_MEM_pipeline1(CLK,RESET,WRITEENABLE_IDOUT,MEMORYACCESS_IDOUT,MEMWRITE_IDOUT,MEMREAD_IDOUT,JAL_MUX_OUT,WRITEADDRESS_IDOUT,FUNCT3_IDOUT,DATA2_IDOUT,WRITEENABLE_EXOUT,MEMORYACCESS_EXOUT,MEMWRITE_EXOUT,MEMREAD_EXOUT,ALURESULT_EXOUT,WRITEADDRESS_EXOUT,FUNCT3_EXOUT,DATA2_EXOUT,FORWARD_MEMORY_IDOUT,FORWARD_MEMORY_EXOUT);

// Memory stage
    MUX_32bit datamemory_MUX(DATA2_EXOUT,WRITEDATA,FORWARD_MEMORY_EXOUT,DATA2_FORWARD);
    data_memory datamemory1(CLK,RESET,MEMREAD_EXOUT,FUNCT3_EXOUT,MEMWRITE_EXOUT,ALURESULT_EXOUT,DATA2_FORWARD,DATA_OUT,BUSYWAIT);
    Mem_WBPipeline  MEM_WBPipeline1(CLK,RESET,WRITEENABLE_EXOUT,MEMORYACCESS_EXOUT,DATA_OUT,ALURESULT_EXOUT,WRITEADDRESS_EXOUT,WRITEENABLE_MEMOUT,MEMORYACCESS_MEMOUT,READDATA_MEMOUT,ALURESULT_MEMOUT,WRITEADDRESS_MEMOUT);

// write back stage
    MUX_32bit Memory_access_MUX(ALURESULT_MEMOUT,READDATA_MEMOUT,MEMORYACCESS_MEMOUT,WRITEDATA);

endmodule