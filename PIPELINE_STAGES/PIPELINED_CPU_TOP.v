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
    
    //STAGE 1 INPUTS/OUTPUTS
    wire [31:0] IFID_IM,
                IFID_IM_Out,
                IFID_PCI,
                IFID_PCI_Out;

    //Instruction Fetch Stage 1
    IF_STAGE    IF_S1(
        .Clk(ClkOut), 
        .Rst(Rst), 
        .JumpOr(), 
        .Br_AND(), 
        .Br_ADD(), 
        .JumpMux(), 
        .IM_Out(IFID_IM),
        .PCI_Out(IFID_PCI));
        
    STAGE_REG_1     IF_ID_SR1(
        .Clk(ClkOut), 
        .Rst(Rst), 
        .IM(IFID_IM), 
        .IM_Out(IFID_IM_Out), 
        .PCI(IFID_PCI), 
        .PCI_Out(IFID_PCI_Out));
    
    //Instruction Decode Stage 2  
    ID_STAGE    ID_S2(
        .Clk(ClkOut), 
        .Rst(Rst), 
        .RW_AND(),
        .IM(IFID_IM_Out),
        .PCI(IFID_PCI_Out), 
        .WriteAddr(), 
        .WriteData(),  
        .ALUOp(IDEX_ALUOp), .RegWrite(IDEX_RegWrite), .ALUSrc(IDEX_ALUSrc), .MemWrite(IDEX_MemWrite), .MemRead(IDEX_MemRead), 
        .Branch(IDEX_Branch), .MemToReg(IDEX_MemToReg), .SignExt(IDEX_SignExt), .JumpMuxSel(IDEX_JumpMuxSel), .ByteSel(IDEX_ByteSel), 
        .RegDst(IDEX_RegDst), .SE_Out(IDEX_SE), .RF_RD1(IDEX_RF_RD1), .RF_RD2(IDEX_RF_RD2), .PCI_Out(IDEX_PCI));
    
    //STAGE 2 INPUTS/OUTPUTS
     wire IDEX_RegWrite,   IDEX_RegWrite_Out, 
          IDEX_ALUSrc,     IDEX_ALUSrc_Out, 
          IDEX_MemWrite,   IDEX_MemWrite_Out, 
          IDEX_MemRead,    IDEX_MemRead_Out, 
          IDEX_Branch,     IDEX_Branch_Out,
          IDEX_MemToReg,   IDEX_MemToReg_Out, 
          IDEX_SignExt,    IDEX_SignExt_Out, 
          IDEX_JumpMuxSel, IDEX_JumpMuxSel_Out;      
     
     wire [1:0] IDEX_ByteSel, IDEX_ByteSel_Out,
                IDEX_RegDst,  IDEX_RegDst_Out;
     
     wire [4:0] IDEX_ALUOp, IDEX_ALUOp_Out;
     
     wire [31:0] IDEX_SE,     IDEX_SE_Out,
                 IDEX_RF_RD1, IDEX_RF_RD1_Out, 
                 IDEX_RF_RD2, IDEX_RF_RD2_Out,
                 IDEX_PCI,    IDEX_PCI_Out;
                    
     STAGE_REG_2    ID_EX_SR2(
        //Inputs
        .Clk(ClkOut), .Rst(Rst), .RegWrite(IDEX_RegWrite), .ALUSrc(IDEX_ALUSrc), .MemWrite(IDEX_MemWrite), .MemRead(IDEX_MemRead), .Branch(IDEX_Branch), 
        .MemToReg(IDEX_MemToReg), .SignExt(IDEX_SignExt), .JumpMuxSel(IDEX_JumpMuxSel), .ByteSel(IDEX_ByteSel), .RegDst(IDEX_RegDst), .ALUOp(IDEX_ALUOp), 
        .SE(IDEX_SE), .RF_RD1(IDEX_RF_RD1), .RF_RD2(IDEX_RF_RD2), .PCI(IDEX_PCI),
        //Outputs 
        .RegWrite_Out(), .ALUSrc_Out(), .MemWrite_Out(), .MemRead_Out(), .Branch_Out(), .MemToReg_Out(), .SignExt_Out(), .JumpMuxSel_Out(), .ByteSel_Out(),
        .RegDst_Out(), .ALUOp_Out(), .SE_Out(), .RF_RD1_Out(), .RF_RD2_Out(), .PCI_Out());
    
    //Execute Stage 3
    EX_STAGE    EX_S3();
    
    //Memory Stage 4
    MEM_STAGE   MEM_S4();
    
    //Write Back Stage 5
    WB_STAGE    WB_S5();
    
    
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
