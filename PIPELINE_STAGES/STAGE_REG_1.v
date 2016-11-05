`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/25/2016 07:02:32 PM
// Design Name: 
// Module Name: STAGE_REG_1
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


module IFID_Reg(Clock, Reset, Flush , WriteEnable, Instruction_In, Instruction_Out, PCI_In, PCI_Out);

    input Clock, Reset, Flush, WriteEnable;
    
    input [31:0] Instruction_In, PCI_In;
    
    output reg [31:0] Instruction_Out = 0, PCI_Out = 0;
    
    always @(posedge Clock) begin
        if(Reset || Flush) begin
            PCI_Out <= 0;
            Instruction_Out <= 0;
        end else begin
            if(WriteEnable)begin
                PCI_Out <= PCI_In;
                Instruction_Out <= Instruction_In;
            end
        end
    end
    
endmodule
