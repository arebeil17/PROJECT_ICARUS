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
    
    //Instruction Fetch Stage 1
    IF_STAGE    IF_S1();
    
    //Instruction Decode Stage 2  
    ID_STAGE    ID_S2();
    
    //Execute Stage 3
    EX_STAGE    EX_S3();
    
    //MEMORY STAGE 4
    MEM_STAGE   MEM_S4();
    
    //Write Back Stage 5
    WB_STAGE    WB_S5();
    
    
    
    
endmodule
