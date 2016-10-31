`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/30/2016 10:55:03 AM
// Design Name: 
// Module Name: HazardDetectionUnit
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

module HazardDetectionUnit(
    // Control Input(s)
    Clock, Reset, EXMEM_WriteEnable,
    // Data Input(s)
    ID_Instruction, EX_Instruction,
    // Control Output(s)
    PC_WriteEnable, IFID_WriteEnable, WriteEnableMuxControl);
    
    input Clock, Reset, EXMEM_WriteEnable;
    input [31:0] ID_Instruction, EX_Instruction;
    
    output reg PC_WriteEnable, IFID_WriteEnable, WriteEnableMuxControl;
    
    initial begin
        PC_WriteEnable <= 1;
        IFID_WriteEnable <= 1;
        WriteEnableMuxControl <= 1;
    end
    
    always @(*) begin
        //PC_WriteEnable <= 1;
        //IFID_WriteEnable <= 1;
        //WriteEnableMuxControl <= 1;
    end
endmodule
