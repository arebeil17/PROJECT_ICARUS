`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Andres Rebeil
// Create Date: 10/25/2016 12:02:49 PM
// Design Name: 
// Module Name: ID_STAGE
// Project Name: 
//////////////////////////////////////////////////////////////////////////////////

module ID_STAGE(
    Clock, Reset,
    // Control Input(s)
    RegWrite_In, IDEX_MemRead,
    // Data Input(s)
    EX_Instruction_In, Instruction, PC, WriteAddress, WriteData,  
    // Control Output(s)
    ALUOp, RegWrite, ALUSrc, MemWrite, MemRead, Branch, MemToReg, ByteSel, RegDestMuxControl, Jump, PC_WriteEnable, IFID_WriteEnable, WriteEnable_Out, 
    // Outputs
    SE_Out, RF_RD1, RF_RD2, IFID_Flush, JumpDest);

    input Clock, Reset, RegWrite_In, IDEX_MemRead;
    input [4:0] WriteAddress;
    input [31:0] Instruction, EX_Instruction_In, WriteData, PC;
    //Output wires
    output wire [31:0] SE_Out, RF_RD1, RF_RD2;
         
    //Control Signal Outputs
    output RegWrite, ALUSrc, MemWrite, MemRead, Branch, Jump, PC_WriteEnable, IFID_WriteEnable, IFID_Flush;
    output [1:0] ByteSel, RegDestMuxControl, MemToReg;      
    output [4:0] ALUOp;
    output [31:0] JumpDest, WriteEnable_Out;
    
    wire SignExt, LoadMuxControl, Control_WriteEnableMux, JumpMuxSel;
    wire [31:0] JumpShift_Out, WriteEnable;
    
    // Hazard Detection Unit
    HazardDetectionUnit HDU(
        //Control Input(s)
        .Clock(Clock),
        .Reset(Reset),
        .MemReadFromIDEX(IDEX_MemRead),
        // Data Input(s)
        .ID_Instruction(Instruction),
        .EX_Instruction(EX_Instruction_In),
        // Control Output(s)
        .WriteEnableMuxControl(Control_WriteEnableMux),
        .PC_WriteEnable(PC_WriteEnable),
        .IFID_WriteEnable(IFID_WriteEnable));
    
    ShiftLeft JumpShift(
        .In({6'b0,Instruction[25:0]}),
        .Out(JumpShift_Out),
        .Shift(5'd2));
            
    Mux32Bit2To1 JumpMux(
        .In0({PC[31:28],JumpShift_Out[27:0]}),
        .In1(RF_RD1),
        .Out(JumpDest),
        .sel(JumpMuxSel));
    
    Mux32Bit2To1 WriteEnableMux(
        .In0(32'b0),
        .In1(WriteEnable),
        .Out(WriteEnable_Out),
        .sel(Control_WriteEnableMux));
    
    DatapathController Controller(
        .OpCode(Instruction[31:26]),
        .Funct(Instruction[5:0]),
        .AluOp(ALUOp),
        .RegDest(RegDestMuxControl),
        .RegWrite(RegWrite),
        .AluSrc(ALUSrc),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .Branch(Branch),
        .MemToReg(MemToReg),
        .SignExt(SignExt),
        .Jump(Jump),
        .JumpMux(JumpMuxSel),
        .ByteSel(ByteSel),
        .StageWriteEnable(WriteEnable),
        .IFID_Flush(IFID_Flush));
               
     RegisterFile RF(
        .ReadRegister1(Instruction[25:21]),
        .ReadRegister2(Instruction[20:16]),
        .WriteRegister(WriteAddress),
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
