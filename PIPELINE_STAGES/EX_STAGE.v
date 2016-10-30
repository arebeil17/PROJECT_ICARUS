`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Andres Rebeil
// Create Date: 10/25/2016 12:02:49 PM
// Design Name: 
// Module Name: EX_STAGE
// Project Name: 
//////////////////////////////////////////////////////////////////////////////////


module EX_STAGE(Clock, Reset, Instruction, PCI, RF_RD1, RF_RD2, ALUResult, SE_In, RegDest, RegWrite, ALUSrc, Zero, Jump, ALUOp, RegDst, BranchDest, JumpDest, JumpMuxControl);
    input Clock, Reset, ALUSrc, JumpMuxControl;
    input [1:0] RegDst;
    input [4:0] ALUOp;
    input [31:0] Instruction, PCI, RF_RD1, RF_RD2, SE_In;
    
    output RegWrite, Zero, Jump;
    output [31:0] ALUResult, RegDest, BranchDest, JumpDest;
    
    wire [63:0] HiLoWrite, HiLoRead;
    wire [31:0] BranchShift_Out, ALUSrc_Out, JumpShift_Out;
    wire [5:0] ALUControl;
    
    ShiftLeft JumpShift(
        .In({8'b0,Instruction[25:0]}),
        .Out(JumpShift_Out),
        .Shift(32'd2));
        
    Mux32Bit2To1 JumpMux(
        .In0({PCI[31:28],JumpShift_Out[27:0]}),
        .In1(RF_RD1),
        .Out(JumpDest),
        .sel(JumpMuxControl));
    
    Adder BranchAdder(
        .InA(PCI),
        .InB(BranchShift_Out),
        .Out(BranchDest));
     
    ShiftLeft BranchShift(
        .In(SE_In),
        .Out(BranchShift_Out),
        .Shift(32'd2));

    ALU_Controller ALUController(
        .Reset(Reset),
        .AluOp(ALUOp),
        .Funct(Instruction[5:0]),
        .ALUControl(ALUControl));
        
    Mux32Bit2To1 ALUSrcMux(
        .Out(ALUSrc_Out),
        .In0(RF_RD2),
        .In1(SE_In),
        .sel(ALUSrc));
     
    ALU32Bit ALU(
        .ALUControl(ALUControl),
        .A(RF_RD1),
        .B(ALUSrc_Out),
        .Shamt(Instruction[10:6]),
        .ALUResult(ALUResult),
        .Zero(Zero),
        .HiLoEn(HiLoEn),
        .HiLoWrite(HiLoWrite), 
        .HiLoRead(HiLoRead),
        .RegWrite(RegWrite),
        .Jump(Jump));
     
    HiLoRegister HiLo(
        .WriteEnable(HiLoEn) , 
        .WriteData(HiLoWrite), 
        .HiLoReg(HiLoRead), 
        .Clock(Clock), 
        .Reset(Reset));
        
    Mux32Bit4To1 RegDstMux(
        .In0(Instruction[15:11]),
        .In1(Instruction[20:16]),
        .In2(32'b11111),
        .In3(32'b0),
        .Out(RegDest),
        .sel(RegDst));
endmodule
