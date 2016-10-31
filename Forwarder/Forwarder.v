`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/30/2016 01:43:32 PM
// Design Name: 
// Module Name: Forwarder
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


module Forwarder(
    Clock,
    Reset,
    // Control Input(s)
    WriteEnableFromEXMEM, WriteEnableFromMEMWB,
    // Data Input(s)
    EX_Instruction, RegDest,
    // Control Output(s)
    FWMuxAControl, FWMuxBControl);
    
    input Clock, Reset, WriteEnableFromEXMEM, WriteEnableFromMEMWB;
    input [4:0] RegDest;
    input [31:0] EX_Instruction;
    
    output reg [1:0] FWMuxAControl, FWMuxBControl;
    
    always @(*) begin
        FWMuxAControl <= 2'b00;
        FWMuxBControl <= 2'b00;
    end
endmodule
