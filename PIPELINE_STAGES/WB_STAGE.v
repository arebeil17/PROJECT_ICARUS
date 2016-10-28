`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Andres Rebeil
// Create Date: 10/25/2016 12:02:49 PM
// Design Name: 
// Module Name: WB_STAGE
// Project Name: 
//////////////////////////////////////////////////////////////////////////////////


module WB_STAGE();

    Mux32Bit4To1 MemToRegMux(
        .Out(MemToReg_Out),
        .In0(ALU_Out),
        .In1(DM_Out),
        .In2(PCI_Out),
        .In3(32'b0),
        .sel(MemToReg));
        
endmodule
