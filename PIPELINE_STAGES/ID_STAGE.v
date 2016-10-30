`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Andres Rebeil
// Create Date: 10/25/2016 12:02:49 PM
// Design Name: 
// Module Name: ID_STAGE
// Project Name: 
//////////////////////////////////////////////////////////////////////////////////

module ID_STAGE(
    // Control Input(s)
    Clock, Reset, RegWrite_In,
    // Data Input(s)
    Instruction, WriteAddr, WriteData,  
    // Control Output(s)
    ALUOp, RegWrite, ALUSrc, MemWrite, MemRead, Branch, MemToReg, JumpMuxSel, ByteSel, RegDst, Jump, 
    // Outputs
    SE_Out, RF_RD1, RF_RD2);

    input Clock, Reset, RegWrite_In;
    
    input [31:0] Instruction, WriteData;
    
    input [4:0] WriteAddr;
    
    //Output wires
    output wire [31:0] SE_Out, RF_RD1, RF_RD2;
         
    //Control Signal Outputs
    output [4:0] ALUOp;
    
    output RegWrite, ALUSrc, MemWrite, MemRead, Branch, JumpMuxSel, Jump;
     
    output [1:0] ByteSel, RegDst, MemToReg;      
    
    wire SignExt;
    
    DatapathController Controller(
        .OpCode(Instruction[31:26]),
        .AluOp(ALUOp),
        .RegDst(RegDst),
        .RegWrite(RegWrite),
        .AluSrc(ALUSrc),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .Branch(Branch),
        .MemToReg(MemToReg),
        .SignExt(SignExt),
        .Jump(Jump),
        .JumpMux(JumpMuxSel),
        .ByteSel(ByteSel));
               
     RegisterFile RF(
        .ReadRegister1(Instruction[25:21]),
        .ReadRegister2(Instruction[20:16]),
        .WriteRegister(WriteAddr),
        .WriteData(WriteData),
        .RegWrite(RegWrite_In),
        .Clk(Clock),
        .ReadData1(RF_RD1),
        .ReadData2(RF_RD2),
        .Reset(Reset));
        
     SignExtension SE(
        .In(Instruction[15:0]),
        .Out(SE_Out));
endmodule
