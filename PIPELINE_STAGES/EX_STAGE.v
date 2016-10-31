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
    ALUSrc, JumpMuxControl, RegDestMuxControl, ALUOp, MEM_RegDest, EXMEM_WriteEnable, MEMWB_WriteEnable,
    // Data Input(s)
    Instruction, PCI, RF_RD1, RF_RD2, SE_In, FWFromMEM, FWFromWB,
    // Control Output(s)
    RegWrite, Zero, Jump, RegDest,
    // Data Output(s)
    ALUResult, BranchDest, JumpDest);
    
    input Clock, Reset, ALUSrc, JumpMuxControl, EXMEM_WriteEnable, MEMWB_WriteEnable;
    input [1:0] RegDestMuxControl;
    input [4:0] ALUOp, MEM_RegDest;
    input [31:0] Instruction, PCI, RF_RD1, RF_RD2, SE_In, FWFromMEM, FWFromWB;
    
    output RegWrite, Zero, Jump;
    output [4:0] RegDest;
    output [31:0] ALUResult, BranchDest, JumpDest;
    
    wire [63:0] HiLoWrite, HiLoRead;
    wire [31:0] BranchShift_Out, ALUSrc_Out, JumpShift_Out, FWMuxA_Out, FWMuxB_Out;
    wire [5:0] ALUControl;
    wire [1:0] FWMuxAControl, FWMuxBControl;
    
    Forwarder Forwarder(
        .Clock(Clock),
        .Reset(Reset),
        .WriteEnableFromEXMEM(EXMEM_WriteEnable),
        .WriteEnableFromMEMWB(MEMWB_WriteEnable),
        .EX_Instruction(Instruction),
        .RegDest(MEM_RegDest),
        .FWMuxAControl(FWMuxAControl),
        .FWMuxBControl(FWMuxBControl));
        
    Mux32Bit4To1 FWMuxA(
        .In0(RF_RD1),
        .In1(FWFromMEM),
        .In2(FWFromWB),
        .In3(32'b0),
        .Out(FWMuxA_Out),
        .sel(FWMuxAControl));
        
    Mux32Bit4To1 FWMuxB(
        .In0(ALUSrc_Out),
        .In1(FWFromMEM),
        .In2(FWFromWB),
        .In3(32'b0),
        .Out(FWMuxB_Out),
        .sel(FWMuxBControl));
        
    ShiftLeft JumpShift(
        .In({6'b0,Instruction[25:0]}),
        .Out(JumpShift_Out),
        .Shift(5'd2));
        
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
        .RegWrite(RegWrite),
        .Jump(Jump));
     
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
