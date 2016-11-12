`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Andres Rebeil
// Create Date: 10/25/2016 12:02:49 PM
// Design Name: 
// Module Name: MEM_STAGE
// Project Name: 
//////////////////////////////////////////////////////////////////////////////////


module MEM_STAGE(Clock, Reset, PC, WriteData, ReadData, WriteAddress, MemRead, MemWrite, ByteSel);
    input Clock, Reset, MemRead, MemWrite;
    input [1:0] ByteSel;
    input [31:0] PC, WriteData, WriteAddress;
    
    output [31:0] ReadData;
    
    DataMemory DM(
        .Address(WriteAddress),
        .WriteData(WriteData),
        .ByteSel(ByteSel),
        .Clock(Clock),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .ReadData(ReadData));
        
endmodule
