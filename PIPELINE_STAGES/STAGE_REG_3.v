`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2016 10:06:08 PM
// Design Name: 
// Module Name: STAGE_REG_3
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


module EXMEM_Reg(
    Clock, Reset,
    // Control Input(s)
    MemRead_In, MemWrite_In,  ByteSel_In,
    // Data Input(s)
    ALUResult_In, MemToReg_In, PC_In, RegDest_In, RegWrite_In, WriteData_In,
    // Control Output(s)
    MemRead_Out, MemWrite_Out, ByteSel_Out,
    // Data Output(s)
    ALUResult_Out, MemToReg_Out, PC_Out, RegDest_Out, RegWrite_Out, WriteData_Out);
    
    input Clock, Reset, MemRead_In, MemWrite_In, RegWrite_In;
    input [1:0] ByteSel_In, MemToReg_In;
    input [4:0] RegDest_In;
    input [31:0] ALUResult_In, WriteData_In, PC_In;
    
    output reg MemRead_Out, MemWrite_Out, RegWrite_Out;
    output reg [1:0] ByteSel_Out, MemToReg_Out;
    output reg [4:0] RegDest_Out;
    output reg [31:0] ALUResult_Out, WriteData_Out, PC_Out;
    
    initial begin
        ALUResult_Out <= 32'b0;
        ByteSel_Out <= 2'b0;
        MemToReg_Out <= 2'b0;
        MemRead_Out <= 0;
        MemWrite_Out <= 0;
        PC_Out <= 32'b0;
        RegDest_Out <= 5'b0;
        RegWrite_Out <= 0;
        WriteData_Out <= 32'b0;
    end
    
    always @(posedge Clock) begin
        if(Reset) begin
            ALUResult_Out       <= 0;
            ByteSel_Out         <= 0;
            MemToReg_Out        <= 0;
            MemRead_Out         <= 0;
            MemWrite_Out        <= 0;
            PC_Out              <= 0;
            RegDest_Out         <= 0;
            RegWrite_Out        <= 0;
            WriteData_Out       <= 0;
        end else begin
            //if(WriteEnable) begin
                ALUResult_Out       <= ALUResult_In;
                ByteSel_Out         <= ByteSel_In;
                MemToReg_Out        <= MemToReg_In;
                PC_Out              <= PC_In;
                MemRead_Out         <= MemRead_In;
                MemWrite_Out        <= MemWrite_In;
                RegDest_Out         <= RegDest_In;
                RegWrite_Out        <= RegWrite_In;
                WriteData_Out       <= WriteData_In;
            //end
        end
    end 
endmodule
