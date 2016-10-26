`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Andres Rebeil
// Create Date: 10/25/2016 12:02:49 PM
// Design Name: 
// Module Name: ID_STAGE
// Project Name: 
//////////////////////////////////////////////////////////////////////////////////

module ID_STAGE(Clk, Rst, RW_AND, IM, PCI, WriteAddr, WriteData,  
                ALUOp, RegWrite, ALUSrc, MemWrite, MemRead, Branch, MemToReg, SignExt, JumpMuxSel, ByteSel, RegDst, 
                SE_Out, RF_RD1, RF_RD2, PCI_Out);

    input Clk, Rst, RW_AND;
    
    input [31:0] IM, WriteData, PCI;
    
    input [4:0] WriteAddr;
    //Output wires
    output wire [31:0] SE_Out,
                       RF_RD1,
                       RF_RD2,
                       PCI_Out;
         
    //Control Signal Outputs
    output [4:0] ALUOp;
    
    output RegWrite,
           ALUSrc,
           MemWrite,
           MemRead,
           Branch,
           MemToReg,
           SignExt,
           JumpMuxSel;
     
     output [1:0] ByteSel,
                  RegDst;      
                     
    DatapathController Controller(
        .OpCode(IM[31:26]),
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
        .ReadRegister1(IM[25:21]),
        .ReadRegister2(IM[20:16]),
        .WriteRegister(WriteAddr),
        .WriteData(WriteData),
        .RegWrite(RW_AND),
        .Clk(Clk),
        .ReadData1(RF_RD1),
        .ReadData2(RF_RD2),
        .Reset(Rst));
        
     SignExtension SE(
        .In(IM[15:0]),
        .Out(SE_Out));   
        
        
endmodule
