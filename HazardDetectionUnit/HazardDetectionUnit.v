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
    Clock, Reset, MemReadFromIDEX, MemReadFromID, Branch,
    // Data Input(s)
    IDInstruction, EXInstruction,
    // Control Output(s)
    Flush, PCWriteEnable, IFIDWriteEnable);
    
    input Clock, Reset, MemReadFromIDEX, MemReadFromID, Branch;
    input [31:0] IDInstruction, EXInstruction;
    
    output reg Flush, PCWriteEnable, IFIDWriteEnable;
    
    reg stall;
    
    initial begin
        PCWriteEnable <= 0;
        IFIDWriteEnable <= 0;
        Flush = 0;
        stall = 0;
    end
    
    always @(negedge Clock) begin
        if(MemReadFromIDEX || MemReadFromID || Branch) begin // Check if Previous/Current Command was/is LW
            if((EXInstruction[20:16] == IDInstruction[25:21] || 
                EXInstruction[20:16] == IDInstruction[20:16]) && EXInstruction[20:16] != 5'b00000)begin
                PCWriteEnable <= 0;
                IFIDWriteEnable <= 0;
                Flush <= 1;
                stall <= 1;
            end else begin
                PCWriteEnable <= 1;
                IFIDWriteEnable <= 1;
                Flush <= 0;
                stall <= 0;
            end
        end else begin
            PCWriteEnable <= 1;
            IFIDWriteEnable <= 1;
            Flush <= 0;
            stall <= 0;
        end
    end
endmodule
