`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Andres Rebeil
// Create Date: 10/25/2016 12:02:49 PM
// Design Name: 
// Module Name: IF_STAGE
// Project Name: PROJECT_ICARUS
//////////////////////////////////////////////////////////////////////////////////

module IF_STAGE(Clk, Rst, JumpOr, Br_AND, Br_ADD, JumpMux, IM_Out);
    
    input Clk, Rst;
    
    input JumpOr, Br_AND;
    
    input [31:0] JumpMux, Br_ADD;
    
    //Internal wires
    wire [31:0] PC_Out,
                PC_Src_Out,
                PCI_Out,
                JumpMux_Out;
    
    output wire [31:0] IM_Out;            
    
    ProgramCounter PC(
        .Address(PC_Src_Out),
        .PC(PC_Out),
        .Reset(Rst),
        .Clk(Clk)); 
        
    Adder PC_ADDER(
        .InA(PC_Out),
        .InB(32'd4),
        .Out(PCI_Out));    
    
    InstructionMemory IM(
        .Address(PC_Out),
        .Instruction(IM_Out));
                
        
    Mux32Bit4To1 PC_Src_Mux(
        .Out(PC_Src_Out),
        .In0(PCI_Out),
        .In1(Br_ADD),
        .In2(JumpMux),
        .In3(32'b0),
        .sel({JumpOr, Br_AND}));    
    
endmodule
