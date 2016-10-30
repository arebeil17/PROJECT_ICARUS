`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Andres Rebeil
// Create Date: 10/25/2016 12:02:49 PM
// Design Name: 
// Module Name: IF_STAGE
// Project Name: PROJECT_ICARUS
//////////////////////////////////////////////////////////////////////////////////

module IF_STAGE(Clock, Reset, Jump, Branch, BranchDest, JumpDest, Instruction, PCI);
    
    input Clock, Reset;
    
    input Jump, Branch;
    
    input [31:0] JumpDest, BranchDest;
    
    //Internal wires
    wire [31:0] PC_Out, PC_Src_Out, JumpMux_Out;
    
    output wire [31:0] Instruction, PCI;            
    
    ProgramCounter PC(
        .Address(PC_Src_Out),
        .PC(PC_Out),
        .Reset(Reset),
        .Clk(Clock)); 
        
    Adder PC_ADDER(
        .InA(PC_Out),
        .InB(32'd4),
        .Out(PCI));
    
    InstructionMemory IM(
        .Address(PC_Out),
        .Instruction(Instruction));

    Mux32Bit4To1 PC_Src_Mux(
        .Out(PC_Src_Out),
        .In0(PCI),
        .In1(BranchDest),
        .In2(JumpDest),
        .In3(32'b0),
        .sel({Jump, Branch}));    
endmodule
