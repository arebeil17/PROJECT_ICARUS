`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// Create Date: 10/27/2016 11:29:12 AM
// Design Name: 
// Module Name: STAGE_REG_2
// Project Name: 
//////////////////////////////////////////////////////////////////////////////////

module IDEX_Reg(
    Clock, Reset, WriteEnable,
    // Control Input(s)
    Jump_In, RegWrite_In, ALUSrc_In, MemWrite_In, MemRead_In, Branch_In, MemToReg_In, JumpMuxSel_In, ByteSel_In, RegDestMuxControl_In, ALUOp_In, WriteEnable_In,
    // Data Inputs
    Instruction_In,  SE_In, RF_RD1_In, RF_RD2_In, PCI_In, 
    // Control Output(s)
    Jump_Out, RegWrite_Out, ALUSrc_Out, MemWrite_Out, MemRead_Out, Branch_Out, MemToReg_Out, JumpMuxSel_Out, ByteSel_Out, RegDestMuxControl_Out, ALUOp_Out, WriteEnable_Out,
    // Outputs
    Instruction_Out, SE_Out, RF_RD1_Out, RF_RD2_Out, PCI_Out);

    input Clock, Reset, WriteEnable;
    
    //-----------STAGE REG INTPUTS-------------------- 
    input  RegWrite_In, ALUSrc_In, MemWrite_In, MemRead_In, Branch_In, JumpMuxSel_In, Jump_In;           
    input [1:0] ByteSel_In, RegDestMuxControl_In, MemToReg_In, WriteEnable_In;   
    input [4:0] ALUOp_In;
    input [31:0] Instruction_In, SE_In, RF_RD1_In, RF_RD2_In, PCI_In;
    
    //-----------STAGE REG OUTPUTS--------------------                                
    output reg  RegWrite_Out, ALUSrc_Out, MemWrite_Out, MemRead_Out, Branch_Out, JumpMuxSel_Out, Jump_Out;           
    output reg [1:0] ByteSel_Out, RegDestMuxControl_Out, MemToReg_Out, WriteEnable_Out;
    output reg [4:0] ALUOp_Out;
    output reg [31:0] Instruction_Out, SE_Out, PCI_Out, RF_RD1_Out, RF_RD2_Out;
     
    always @(posedge Clock) begin
        if(Reset) begin
            RegWrite_Out            <= 0; 
            ALUSrc_Out              <= 0;
            MemWrite_Out            <= 0; 
            MemRead_Out             <= 0; 
            Branch_Out              <= 0; 
            MemToReg_Out            <= 0; 
            JumpMuxSel_Out          <= 0; 
            ByteSel_Out             <= 0; 
            RegDestMuxControl_Out   <= 0; 
            ALUOp_Out               <= 0;
            PCI_Out                 <= 0;
            RF_RD1_Out              <= 0;
            RF_RD2_Out              <= 0;
            SE_Out                  <= 0;
            Jump_Out                <= 0;
            Instruction_Out         <= 0;
            WriteEnable_Out         <= 0;
        end else begin
            if(WriteEnable) begin
                RegWrite_Out            <= RegWrite_In; 
                ALUSrc_Out              <= ALUSrc_In;
                MemWrite_Out            <= MemWrite_In; 
                MemRead_Out             <= MemRead_In; 
                Branch_Out              <= Branch_In; 
                MemToReg_Out            <= MemToReg_In; 
                JumpMuxSel_Out          <= JumpMuxSel_In; 
                ByteSel_Out             <= ByteSel_In; 
                RegDestMuxControl_Out   <= RegDestMuxControl_In; 
                ALUOp_Out               <= ALUOp_In;
                PCI_Out                 <= PCI_In;
                RF_RD1_Out              <= RF_RD1_In;
                RF_RD2_Out              <= RF_RD2_In;
                SE_Out                  <= SE_In;
                Jump_Out                <= Jump_In;
                Instruction_Out         <= Instruction_In;
                WriteEnable_Out         <= WriteEnable_In;
            end
        end
     end       
endmodule
