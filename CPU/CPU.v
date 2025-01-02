`include "../MUX_32bit/MUX_32bit.v"
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
//`include "../InstructionMemory/instructionmem.v"
`include "../RegisterFile/registerfile.v"

module CPU (CLK, RESET);
    input CLK, RESET;
    wire [31:0] PC, PC_PLUS_4, INSTRUCTION, WRITEDATA, DATA1, DATA2, ALUresult, TARGETEDADDRESS,PC_MUX_OUT,PCOUT;
    wire PCADDRESSCONTROLLER, BRANCH, JUMP, MEMREAD, MEMWRITE, JUMPANDLINK, OFFSETGENARATOR, WRITEENABLE, MEMORYACCESS, IMMEDIATESELECT;
    wire [31:0] INSTRUCTION_OUT, PC_OUT, PC_PLUS_4_OUT, WRITEDATA_OUT, DATA1_OUT, DATA2_OUT, ALUresult_OUT;
    wire [4:0] ALU_OPCODE;
    wire [2:0] IMMEDIATE_TYPE;

// instruction fetch stage
 //   instructionmem instructionmem1(PCOUT, INSTRUCTION);
    pc pc1(PC_MUX_OUT, RESET, CLK, PCOUT);
    MUX_32bit PC_MUX(PC_PLUS_4, TARGETEDADDRESS, PCADDRESSCONTROLLER, PC_MUX_OUT);
    ID_IF_register ID_IF_register1(CLK, INSTRUCTION,PCOUT,PC_PLUS_4,RESET,INSTRUCTION_OUT,PC_OUT,PC_PLUS_4_OUT);

// instruction decode stage




    
endmodule