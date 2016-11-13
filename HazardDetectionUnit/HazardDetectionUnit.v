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
    Clock, Reset, MemReadFromIDEX, MemReadFromID, BranchFromController, BranchFromBC, RegWriteFromIDEX,
    // Data Input(s)
    IDInstruction, EXInstruction,
    // Control Output(s)
    IDEXFlush, PCWriteEnable, IFIDWriteEnable, Branch);
    
    input Clock, Reset, MemReadFromIDEX, MemReadFromID, BranchFromController, BranchFromBC, RegWriteFromIDEX;
    input [31:0] IDInstruction, EXInstruction;
    
    output reg IDEXFlush, PCWriteEnable, IFIDWriteEnable, Branch;
    
    reg stall;
    
    initial begin
        PCWriteEnable <= 0;
        IFIDWriteEnable <= 0;
        IDEXFlush <= 0;
        stall <= 0;
    end
    
    always @(*) begin
        if(MemReadFromIDEX || MemReadFromID) begin // Check if Previous/Current Command was/is LW
            if((EXInstruction[20:16] == IDInstruction[25:21] || 
                EXInstruction[20:16] == IDInstruction[20:16]) && EXInstruction[20:16] != 5'b00000)begin
                PCWriteEnable <= 0;
                IFIDWriteEnable <= 0;
                IDEXFlush <= 1;
                Branch <= BranchFromController & BranchFromBC;
                stall <= 1;
            end else begin
                PCWriteEnable <= 1;
                IFIDWriteEnable <= 1;
                IDEXFlush <= 0;
                Branch <= BranchFromController & BranchFromBC;
                stall <= 0;
            end
        end else if(BranchFromController && (MemReadFromIDEX || RegWriteFromIDEX)) begin
            // If IDInstruction is Dependent on EXInstruction Stall Branch Decision
            if((EXInstruction[31:26] == 2'b000000 && EXInstruction[15:11] == IDInstruction[25:21]) || // If EXInstruction is R-Type AND IF EX.RD == ID.RS
                (EXInstruction[31:26] != 2'b000000 && EXInstruction[20:16] == IDInstruction[25:21])) begin // If EXInstruction is I-Type AND IF EX.RT == ID.RS
                PCWriteEnable <= 0;
                IFIDWriteEnable <= 0;
                IDEXFlush <= 0;
                Branch <= 0;
                stall <= 1;
            end else begin
                PCWriteEnable <= 1;
                IFIDWriteEnable <= 1;
                IDEXFlush <= 0;
                Branch <= BranchFromController & BranchFromBC;
                stall <= 0;
            end
        end else begin
            PCWriteEnable <= 1;
            IFIDWriteEnable <= 1;
            IDEXFlush <= 0;
            Branch <= BranchFromController & BranchFromBC;
            stall <= 0;
        end
    end
endmodule
