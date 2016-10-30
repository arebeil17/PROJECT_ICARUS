`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/25/2016 12:14:02 PM
// Design Name: 
// Module Name: PIPELINED_CPU_TOP
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module PIPELINED_CPU_TOP(Clk, Rst, out7, en_out, ClkOut);

    input Clk, Rst;
    
    output [6:0] out7; //seg a, b, ... g
    output [7:0] en_out;
    output wire ClkOut;
    
    // IF Stage Outputs
    wire [31:0] IF_Instruction_Out, IF_PCI_Out;
    
    // IFID Stage Register Outputs
    wire [31:0] IFID_Instruction_Out, IFID_PCI_Out;
    
    // ID Stage Output(s)
    wire [31:0] ID_RF_RD1_Out, ID_RF_RD2_Out, ID_SE_Out;
    wire ID_RegWrite_Out, ID_ALUSrc_Out, ID_MemWrite_Out, ID_MemRead_Out, ID_Branch_Out, ID_SignExt_Out, ID_JumpMuxSel_Out, ID_SE_Out;
    wire [4:0] ID_ALUOp_Out;
    wire [1:0] ID_ByteSel_Out, ID_RegDst_Out, ID_MemToReg_Out;
    
    // IDEX Stage Register Outputs
    wire IDEX_RegWrite_Out, IDEX_ALUSrc_Out, IDEX_MemWrite_Out, IDEX_MemRead_Out, IDEX_Branch_Out, IDEX_SignExt_Out, IDEX_JumpMuxSel_Out;      
    wire [1:0] IDEX_ByteSel_Out, IDEX_RegDst_Out, IDEX_MemToReg_Out;
    wire [4:0] IDEX_ALUOp_Out;
    wire [31:0] IDEX_Instruction_Out, IDEX_SE_Out, IDEX_RF_RD1_Out, IDEX_RF_RD2_Out, IDEX_PCI_Out;

    // EX Stage Register Outputs
    wire EX_ALURegWrite_Out, EX_Zero_Out, EX_Jump_Out;
    wire [31:0] EX_ALUResult_Out, EX_BranchDest_Out, EX_JumpDest_Out, EX_RegDest_Out;
    
    //EXMEM Stage Register Output(s)
    wire EXMEM_RegWrite_Out;
    wire [1:0] EXMEM_ByteSel_Out, EXMEM_MemToReg_Out;
    wire [31:0] EXMEM_ALUResult_Out, EXMEM_PCI_Out, EXMEM_RegDest_Out, EXMEM_WriteData_Out;
    
    //MEM Stage Output(s)
    wire [31:0] MEM_ReadData_Out;
    
    // MEMWB Stage Register Inputs/Outputs
    wire [31:0] MEMWB_ALUResult_Out, MEMWB_ReadData_Out, MEMWB_RegDest_Out, MEMWB_WriteAddress_Out, MEMWB_PCI_Out;
    wire [1:0] MEMWB_MemToReg_Out;
    wire MEMWB_RegWrite_Out; 
    
    // WB Stage Outputs
    wire [31:0] WB_MemToReg_Out;
    
    //Instruction Fetch Stage 1
    IF_STAGE    IF(
        // Control Input(s)
        .Clock(ClkOut), 
        .Reset(Rst), 
        .Jump(IDEX_Jump_Out | EX_Jump_Out), 
        .Branch(IDEX_Branch_Out & EX_Zero_Out), 
        .BranchDest(EX_BranchDest_Out), 
        .JumpDest(EX_JumpDest_Out),
        // Data Output(s)
        .Instruction(IF_Instruction_Out),
        .PCI(IF_PCI_Out));
        
    IFID_Reg     IFID_SR(
        // Inputs
        .Clock(ClkOut), 
        .Reset(Rst),
        .Instruction_In(IF_Instruction_Out),
        .PCI_In(IF_PCI_Out),
        // Outputs
        .Instruction_Out(IFID_Instruction_Out), 
        .PCI_Out(IFID_PCI_Out));
    
    //Instruction Decode Stage 2  
    ID_STAGE    ID(
        // Control Inputs
        .Clock(ClkOut),
        .Reset(Rst),
        .RegWrite_In(MEMWB_RegWrite_Out),
        // Data Inputs
        .Instruction(IFID_Instruction_Out),
        .WriteAddr(MEMWB_RegDest_Out),
        .WriteData(WB_MemToReg_Out),
        // Control Output(s)
        .Jump(ID_Jump_Out),
        .ALUOp(ID_ALUOp_Out),
        .RegWrite(ID_RegWrite_Out),
        .ALUSrc(ID_ALUSrc_Out),
        .MemWrite(ID_MemWrite_Out),
        .MemRead(ID_MemRead_Out), 
        .Branch(ID_Branch_Out),
        .MemToReg(ID_MemToReg_Out),
        .JumpMuxSel(ID_JumpMuxSel_Out),
        .ByteSel(ID_ByteSel_Out), 
        .RegDst(ID_RegDst_Out),
        // Data Output(s)
        .SE_Out(ID_SE_Out),
        .RF_RD1(ID_RF_RD1_Out),
        .RF_RD2(ID_RF_RD2_Out));
                  
     IDEX_Reg    IDEX_SR(
        // Control Inputs
        .Clock(ClkOut),
        .Reset(Rst),
        .WriteEnable(),
        .Jump_In(ID_Jump_Out),
        .RegWrite_In(ID_RegWrite_Out),
        .ALUSrc_In(ID_ALUSrc_Out),
        .MemWrite_In(ID_MemWrite_Out),
        .MemRead_In(ID_MemRead_Out),
        .Branch_In(ID_Branch_Out), 
        .MemToReg_In(ID_MemToReg_Out),
        .JumpMuxSel_In(ID_JumpMuxSel_Out),
        .ByteSel_In(ID_ByteSel_Out),
        .RegDst_In(ID_RegDst_Out),
        .ALUOp_In(ID_ALUOp_Out), 
        // Data Inputs
        .Instruction_In(IFID_Instruction_Out),
        .SE_In(ID_SE_Out),
        .PCI_In(IFID_PCI_Out),
        .RF_RD1_In(ID_RF_RD1_Out),
        .RF_RD2_In(ID_RF_RD2_Out),
        // Control Outputs
        .RegWrite_Out(IDEX_RegWrite_Out),
        .ALUSrc_Out(IDEX_ALUSrc_Out),
        .MemWrite_Out(IDEX_MemWrite_Out),
        .MemRead_Out(IDEX_MemRead_Out),
        .Branch_Out(IDEX_Branch_Out),
        .MemToReg_Out(IDEX_MemToReg_Out),
        .JumpMuxSel_Out(IDEX_JumpMuxSel_Out),
        .ByteSel_Out(IDEX_ByteSel_Out),
        .RegDst_Out(IDEX_RegDst_Out),
        .ALUOp_Out(IDEX_ALUOp_Out),
        .Jump_Out(IDEX_Jump_Out),
        // Data Outputs 
        .Instruction_Out(IDEX_Instruction_Out),
        .PCI_Out(IDEX_PCI_Out),
        .RF_RD1_Out(IDEX_RF_RD1_Out),
        .RF_RD2_Out(IDEX_RF_RD2_Out),
        .SE_Out(IDEX_SE_Out));
    
    //Execute Stage 3
    EX_STAGE    EX(
        // Control Input(s)
        .Clock(ClkOut),
        .Reset(Rst),
        .ALUSrc(IDEX_ALUSrc_Out),
        .Instruction(IDEX_Instruction_Out),
        .PCI(IDEX_PCI_Out),
        .RF_RD1(IDEX_RF_RD1_Out),
        .RF_RD2(IDEX_RF_RD2_Out),
        .SE_In(IDEX_SE_Out),
        .ALUOp(IDEX_ALUOp_Out),
        .RegDst(IDEX_RegDst_Out),
        .JumpMuxControl(IDEX_JumpMuxSel_Out),
        // Control Output(s)
        .RegWrite(EX_ALURegWrite_Out),
        .Zero(EX_Zero_Out),
        .Jump(EX_Jump_Out),
        // Data Output(s)
        .ALUResult(EX_ALUResult_Out),
        .RegDest(EX_RegDest_Out),
        .BranchDest(EX_BranchDest_Out),
        .JumpDest(EX_JumpDest_Out));
    
    EXMEM_Reg EXMEM_SR(
        // Control Input(s)
        .Clock(ClkOut),
        .Reset(Rst),
        .MemToReg_In(IDEX_MemToReg_Out),
        .RegWrite_In(IDEX_RegWrite_Out & EX_ALURegWrite_Out),
        .MemRead_In(IDEX_MemRead_Out),
        .MemWrite_In(IDEX_MemWrite_Out),
        .ByteSel_In(IDEX_ByteSel_Out),
        // Data Input(s)
        .ALUResult_In(EX_ALUResult_Out),
        .PCI_In(IDEX_PCI_Out),
        .WriteData_In(IDEX_RF_RD2_Out),
        .RegDest_In(EX_RegDest_Out),
        // Control Outputs
        .MemToReg_Out(EXMEM_MemToReg_Out),
        .RegWrite_Out(EXMEM_RegWrite_Out),
        .MemRead_Out(EXMEM_MemRead_Out),
        .MemWrite_Out(EXMEM_MemWrite_Out),
        .ByteSel_Out(EXMEM_ByteSel_Out),
        // Data Outputs
        .ALUResult_Out(EXMEM_ALUResult_Out),
        .PCI_Out(EXMEM_PCI_Out),
        .WriteData_Out(EXMEM_WriteData_Out),
        .RegDest_Out(EXMEM_RegDest_Out));
    
    //Memory Stage 4
    MEM_STAGE   MEM(
        // Control Input(s)
        .Clock(ClkOut),
        .Reset(Rst),
        .MemRead(EXMEM_MemRead_Out),
        .MemWrite(EXMEM_MemWrite_Out),
        .ByteSel(EXMEM_ByteSel_Out),
        // Data Inputs
        .WriteData(EXMEM_WriteData_Out),
        .WriteAddress(EXMEM_ALUResult_Out),
        // Outputs
        .ReadData(MEM_ReadData_Out));
    
    MEMWB_Reg   MEMWB_SR(
        // Control Input(s)
        .Clock(ClkOut),
        .Reset(Rst),
        .MemToReg_In(EXMEM_MemToReg_Out),
        .RegWrite_In(EXMEM_RegWrite_Out),
        // Data Input(s)
        .ALUResult_In(EXMEM_ALUResult_Out),
        .ReadData_In(MEM_ReadData_Out),
        .PCI_In(EXMEM_PCI_Out),
        .RegDest_In(EXMEM_RegDest_Out),
        // Control Output(s)
        .MemToReg_Out(MEMWB_MemToReg_Out),
        .RegWrite_Out(MEMWB_RegWrite_Out),
        // Data Output(s)
        .ALUResult_Out(MEMWB_ALUResult_Out),
        .ReadData_Out(MEMWB_ReadData_Out),
        .RegDest_Out(MEMWB_RegDest_Out),
        .PCI_Out(MEMWB_PCI_Out));
        
    //Write Back Stage 5
    WB_STAGE    WB(
        // Control Input(s)
        .Clock(ClkOut),
        .Reset(Rst),
        .MemToReg(MEMWB_MemToReg_Out),
        // Data Input(s)
        .ALUResult(MEMWB_ALUResult_Out),
        .ReadData(MEMWB_ReadData_Out),
        .PCI(MEMWB_PCI_Out),
        // Outputs
        .MemToReg_Out(WB_MemToReg_Out));
    
    // Output 8 x Seven Segment
    Two4DigitDisplay Display(
        .Clk(Clk),
        .NumberA(WriteOutReg), 
        .NumberB(PC_OutReg), 
        .out7(out7), 
        .en_out(en_out));
     Reg32 WriteOutput(
        .Clk(ClkOut), 
        .Rst(Rst), 
        .data(MemToReg_Out), 
        .Output(WriteOutReg));
     Reg32 PCOutput(
        .Clk(ClkOut), 
        .Rst(Rst), 
        .data(PC_Out), 
        .Output(PC_OutReg));
    
    // Clock Divider
    Mod_Clk_Div MCD(
        .In(4'b1111), // For Testing
        //.In(4'b0000), // For Use 
        .Clk(Clk), 
        .Rst(Rst), 
        .ClkOut(ClkOut));
endmodule
