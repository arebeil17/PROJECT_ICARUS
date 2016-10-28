`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Andres Rebeil
// Create Date: 10/25/2016 12:02:49 PM
// Design Name: 
// Module Name: MEM_STAGE
// Project Name: 
//////////////////////////////////////////////////////////////////////////////////


module MEM_STAGE();
    
    
    
    AND BranchAnd(
        .InA(ALU_Zero),
        .InB(Branch),
        .Out(BranchAnd_Out));
    
    DataMemory DM(
        .Address(ALU_Out),
        .WriteData(RF_RD2),
        .ByteSel(ByteSel),
        .Clk(ClkOut),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .ReadData(DM_Out));
        
endmodule
