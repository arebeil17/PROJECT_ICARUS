`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Andres Rebeil
// Create Date: 10/25/2016 12:02:49 PM
// Design Name: 
// Module Name: EX_STAGE
// Project Name: 
//////////////////////////////////////////////////////////////////////////////////


module EX_STAGE(
    Clock, Reset, 
    // Control Input(s)
    ALUSrc, RegDestMuxControl, ALUOp, EXMEM_RegDest, MEMWB_RegDest, EXMEM_WriteEnable, MEMWB_WriteEnable,
    // Data Input(s)
    PC, Instruction, RF_RD1, RF_RD2, SE_In, FWFromMEM, FWFromWB, MEM_ReadData,
    // Control Output(s)
    RegWrite, Zero, RegDest,
    // Data Output(s)
    ALUResult, BranchDest);
    
    input Clock, Reset, ALUSrc, EXMEM_WriteEnable, MEMWB_WriteEnable;
    input [1:0] RegDestMuxControl;
    input [4:0] ALUOp, EXMEM_RegDest, MEMWB_RegDest;
    input [31:0] PC, Instruction, RF_RD1, RF_RD2, SE_In, FWFromMEM, FWFromWB, MEM_ReadData;
    
    output RegWrite, Zero;
    output [4:0] RegDest;
    output [31:0] ALUResult, BranchDest;
    
    wire [63:0] HiLoWrite, HiLoRead;
    wire [31:0] BranchShift_Out, ALUSrc_Out, FWMuxA_Out, FWMuxB_Out;
    wire [5:0] ALUControl;
    wire [1:0] FWMuxAControl, FWMuxBControl;
    
    Forwarder ForwardUnit(
        .Clock(Clock),
        .Reset(Reset),
        .WriteEnableFromEXMEM(EXMEM_WriteEnable),
        .WriteEnableFromMEMWB(MEMWB_WriteEnable),
        .EX_Instruction(Instruction),
        //.RegDest(MEM_RegDest),
        .EXMEM_WriteReg(EXMEM_RegDest), 
        .MEMWB_WriteReg(MEMWB_RegDest),
        .FWMuxAControl(FWMuxAControl),
        .FWMuxBControl(FWMuxBControl));
        
    Mux32Bit4To1 FWMuxA(
        .In0(RF_RD1),
        .In1(FWFromMEM),
        .In2(FWFromWB),
        .In3(MEM_ReadData),
        .Out(FWMuxA_Out),
        .sel(FWMuxAControl));
        
    Mux32Bit4To1 FWMuxB(
        .In0(ALUSrc_Out),
        .In1(FWFromMEM),
        .In2(FWFromWB),
        .In3(MEM_ReadData),
        .Out(FWMuxB_Out),
        .sel(FWMuxBControl));
    
    Adder BranchAdder(
        .InA(PC),
        .InB(BranchShift_Out),
        .Out(BranchDest));
     
    ShiftLeft BranchShift(
        .In(SE_In),
        .Out(BranchShift_Out),
        .Shift(5'd2));

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
        .A(FWMuxA_Out),
        .B(FWMuxB_Out),
        .Shamt(Instruction[10:6]),
        .ALUResult(ALUResult),
        .Zero(Zero),
        .HiLoEn(HiLoEn),
        .HiLoWrite(HiLoWrite), 
        .HiLoRead(HiLoRead),
        .RegWrite(RegWrite));
     
    HiLoRegister HiLo(
        .WriteEnable(HiLoEn) , 
        .WriteData(HiLoWrite), 
        .HiLoReg(HiLoRead), 
        .Clock(Clock), 
        .Reset(Reset));
        
    Mux32Bit4To1 RegDestMux(
        .In0({27'b0,Instruction[15:11]}),
        .In1({27'b0,Instruction[20:16]}),
        .In2(32'b11111),
        .In3(32'b0),
        .Out(RegDest),
        .sel(RegDestMuxControl));
endmodule
