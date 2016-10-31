`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2016 10:37:32 PM
// Design Name: 
// Module Name: STAGE_REG_4
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


module MEMWB_Reg(
    // Control Input(s)
    Clock, Reset, WriteEnable, MemToReg_In, RegDest_In, RegWrite_In,
    // Data Input(s)
    ALUResult_In, PCI_In, ReadData_In,  
    // Control Output(s)
     MemToReg_Out, RegDest_Out, RegWrite_Out,
    // Data Output(s)
    ALUResult_Out, PCI_Out, ReadData_Out);
    
    input Clock, Reset, WriteEnable, RegWrite_In;
    input [1:0] MemToReg_In;
    input [4:0] RegDest_In;
    input [31:0] ALUResult_In, PCI_In, ReadData_In;
    
    output reg  RegWrite_Out;
    output reg [1:0] MemToReg_Out;
    output reg [4:0] RegDest_Out;
    output reg [31:0] ALUResult_Out, PCI_Out, ReadData_Out;
     
    always @(posedge Clock) begin
        if(Reset) begin
            ALUResult_Out       <= 0;
            MemToReg_Out        <= 0;
            PCI_Out             <= 0;
            ReadData_Out        <= 0;
            RegDest_Out         <= 0;
            RegWrite_Out        <= 0;
        end else begin
            if(WriteEnable) begin
                ALUResult_Out       <= ALUResult_In;
                MemToReg_Out        <= MemToReg_In;
                PCI_Out             <= PCI_In;
                ReadData_Out        <= ReadData_In;
                RegDest_Out         <= RegDest_In;
                RegWrite_Out        <= RegWrite_In;
            end
        end
    end
endmodule
