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
    Clock, Reset, MemReadFromIDEX,
    // Data Input(s)
    ID_Instruction, EX_Instruction,
    // Control Output(s)
    PC_WriteEnable, IFID_WriteEnable, WriteEnableMuxControl);
    
    input Clock, Reset, MemReadFromIDEX;
    input [31:0] ID_Instruction, EX_Instruction;
    
    output reg PC_WriteEnable, IFID_WriteEnable, WriteEnableMuxControl;
    
    reg stall = 0;
    
    //reg out;
    
    initial begin
        PC_WriteEnable = 0;
        IFID_WriteEnable = 0;
        WriteEnableMuxControl = 0;
    end
    
    always @(negedge Clock) begin
        if(PC_WriteEnable == 0)PC_WriteEnable <= 1;
        if(IFID_WriteEnable == 0)IFID_WriteEnable <= 1;
        if(WriteEnableMuxControl == 0)WriteEnableMuxControl <= 1;
        if(MemReadFromIDEX) begin // Check if Last Command was LW
            if(EX_Instruction[20:16] == ID_Instruction[25:21] || EX_Instruction[20:16] == ID_Instruction[20:16]) begin
                PC_WriteEnable = 0;
                IFID_WriteEnable = 0;
                WriteEnableMuxControl = 0;
                stall <= 1;
            end else begin
                PC_WriteEnable = 1;
                IFID_WriteEnable = 1;
                WriteEnableMuxControl = 1;
                stall <= 0;
            end
        end else begin
            PC_WriteEnable = 1;
            IFID_WriteEnable = 1;
            WriteEnableMuxControl = 1;
            stall <= 0;
        end
    end
endmodule
