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


module STAGE_REG_1(Clk, Rst, IM, IM_Out, PCI, PCI_Out);

    input Clk, Rst;
    
    input [31:0] IM, PCI;
    
    output reg [31:0] IM_Out = 0, 
                      PCI_Out = 0;
    
    always @(posedge Clk) begin
        if(Rst) begin
            PCI_Out <= 0;
            IM_Out <= 0;
        end else begin
            PCI_Out <= PCI;
            IM_Out <= IM;
        end
    end
    
endmodule
