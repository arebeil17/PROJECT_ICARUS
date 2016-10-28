`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Andres Rebeil
// Create Date: 10/25/2016 12:02:49 PM
// Design Name: 
// Module Name: EX_STAGE
// Project Name: 
//////////////////////////////////////////////////////////////////////////////////


module EX_STAGE(Clk, Rst);
    
    input Clk, Rst;     
     
     ShiftLeft JumpShift(
        .In({8'b0,IM_Out[25:0]}),
        .Out(JumpShift_Out),
        .Shift(32'd2));
     
     Adder BranchAdder(
        .InA(PCI_Out),
        .InB(BranchShift_Out),
        .Out(BranchAdd_Out));
     
     ShiftLeft BranchShift(
        .In(SE_Out),
        .Out(BranchShift_Out),
        .Shift(32'd2));

     ALU_Controller ALUController(
        .Rst(Rst),
        .AluOp(ALUOp),
        .Funct(IM_Out[5:0]),
        .ALUControl(ALUControl));
        
     Mux32Bit2To1 ALUSrcMux(
        .Out(ALUSrc_Out),
        .In0(RF_RD2),
        .In1(SE_Out),
        .sel(ALUSrc));
     
     ALU32Bit ALU(
        .ALUControl(ALUControl),
        .A(RF_RD1),
        .B(ALUSrc_Out),
        .Shamt(IM_Out[10:6]),
        .ALUResult(ALU_Out),
        .Zero(ALU_Zero),
        .HiLoEn(HiLoEn),
        .HiLoWrite(HiLoWrite), 
        .HiLoRead(HiLoRead),
        .RegWrite(ALU_RegWrite),
        .Jump(ALU_Jump));
     
     HiLoRegister HiLo(
        .WriteEnable(HiLoEn) , 
        .WriteData(HiLoWrite), 
        .HiLoReg(HiLoRead), 
        .Clk(ClkOut), 
        .Reset(Rst));
endmodule
