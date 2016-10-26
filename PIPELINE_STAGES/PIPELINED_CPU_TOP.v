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
    wire [31:0] S1_IM_IN,
                S1_IM_OUT,
                S1_PCI_IN,
                S1_PCI_OUT;
    
    //Instruction Fetch Stage 1
    IF_STAGE    IF_S1(
        .Clk(ClkOut), 
        .Rst(Rst), 
        .JumpOr(), 
        .Br_AND(), 
        .Br_ADD(), 
        .JumpMux(), 
        .IM_Out(S1_IM_IN),
        .PCI_Out(S1_PCI_IN));
        
    STAGE_REG_1     IF_ID_REG(
        .Clk(ClkOut), 
        .Rst(Rst), 
        .IM(S1_IM_IN), 
        .IM_Out(S1_IM_OUT), 
        .PCI(S1_PCI_IN), 
        .PCI_Out(S1_PCI_OUT));
    
    //Instruction Decode Stage 2  
    ID_STAGE    ID_S2(
        .Clk(ClkOut), 
        .Rst(Rst), 
        .RW_AND(),
        .IM(S1_IM_OUT),
        .PCI(S1_PCI_OUT), 
        .WriteAddr(), 
        .WriteData(),  
        .ALUOp(), .RegWrite(), .ALUSrc(), .MemWrite(), .MemRead(), 
        .Branch(), .MemToReg(), .SignExt(), .JumpMuxSel(), .ByteSel(), 
        .RegDst(), .SE_Out(), .RF_RD1(), .RF_RD2(), .PCI_Out());
    
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
