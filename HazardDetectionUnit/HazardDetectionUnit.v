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
    
    output PC_WriteEnable, IFID_WriteEnable, WriteEnableMuxControl;
    
    reg out;
    
    initial begin
        out <= 0;
    end
    
    always @(ID_Instruction) begin
        if(MemReadFromIDEX) begin // Check if Last Command was LW
            if(EX_Instruction[20:16] == ID_Instruction[25:21] || 
                EX_Instruction[20:16] == ID_Instruction[20:16]) begin
                out <= 0;
            end else begin
                out <= 1;
            end
        end else begin
            out <= 1;
        end
    end
    
    assign PC_WriteEnable = out;
    assign IFID_WriteEnable = out;
    assign WriteEnableMuxControl = out;
endmodule
