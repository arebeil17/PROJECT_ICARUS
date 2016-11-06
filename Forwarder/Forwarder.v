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
    EX_Instruction, EXMEM_WriteReg, MEMWB_WriteReg,
    // Control Output(s)
    FWMuxAControl, FWMuxBControl);
    
    input Clock, Reset, WriteEnableFromEXMEM, WriteEnableFromMEMWB;
    input [4:0] EXMEM_WriteReg, MEMWB_WriteReg;
    input [31:0] EX_Instruction;
    
    output reg [1:0] FWMuxAControl, FWMuxBControl;
    
    reg [4:0] IDEX_RegRs = 0, IDEX_RegRt = 0;
    
    initial begin
        FWMuxAControl <= 2'b00;
        FWMuxBControl <= 2'b00;
    end
    
    // FORWARDING MUX REFERENCE:
    // 00 = NO FORWARD
    // 01 = FORWARD MEM -> EX
    // 10 = FORWARD WB -> EX
    // 11 = UNDEFINED
    
    always @(*) begin
        //For readability
        IDEX_RegRs <= EX_Instruction[25:21];
        IDEX_RegRt <= EX_Instruction[20:16];
        
        FWMuxAControl <= 2'b00;
        FWMuxBControl <= 2'b00;
        
        if(WriteEnableFromMEMWB) begin
            if(IDEX_RegRs == MEMWB_WriteReg && IDEX_RegRs != 5'b00000)FWMuxAControl <= 2'b10;
            if(IDEX_RegRt == MEMWB_WriteReg && IDEX_RegRt != 5'b00000)FWMuxBControl <= 2'b10;
        end
        if(WriteEnableFromEXMEM) begin
            if(IDEX_RegRs == EXMEM_WriteReg && IDEX_RegRs != 5'b00000)FWMuxAControl <= 2'b01;
            if(IDEX_RegRt == EXMEM_WriteReg && IDEX_RegRt != 5'b00000)FWMuxBControl <= 2'b01;
        end
/*        
        //Forwarding logic for MEM to EX
         if((EXMEM_WriteReg == IDEX_RegRs) || (EXMEM_WriteReg ==  IDEX_RegRt)) begin
            //Forward from two different stages
            //Forward MEM to EX for A and WB to EX for B required 
            if((EXMEM_WriteReg == IDEX_RegRs) && (MEMWB_WriteReg == IDEX_RegRt))begin
                FWMuxAControl <= 2'b01;
                FWMuxBControl <= 2'b10;
            //Forward from two different stages    
            //Forward WB to EX for A and MEM to EX for B required 
            end else if((MEMWB_WriteReg == IDEX_RegRs) &&( EXMEM_WriteReg == IDEX_RegRt)) begin
                FWMuxAControl <= 2'b10;
                FWMuxBControl <= 2'b01;
            //Forward MEM to EX for both A and B
            end else if((EXMEM_WriteReg ==  IDEX_RegRs) && (EXMEM_WriteReg ==  IDEX_RegRt)) begin
                FWMuxAControl <= 2'b01;
                FWMuxBControl <= 2'b01;
            //Forward MEM to EX for just A    
            end else if(EXMEM_WriteReg ==  IDEX_RegRs) begin
                FWMuxAControl <= 2'b01;
                FWMuxBControl <= 2'b00;
            //Forward MEM to EX for just B     
            end else begin
                FWMuxAControl <= 2'b00;
                FWMuxBControl <= 2'b01;
            end 
        //Forwarding logic for WB to EX
        end else if((MEMWB_WriteReg ==  IDEX_RegRs) || (MEMWB_WriteReg ==  IDEX_RegRt) ) begin
            //Forward WB to EX for both A and B
            if((MEMWB_WriteReg ==  IDEX_RegRs) && (MEMWB_WriteReg ==  IDEX_RegRt)) begin
                FWMuxAControl <= 2'b10;
                FWMuxBControl <= 2'b10;
            //Forward WB to EX for just A    
            end else if(MEMWB_WriteReg ==  IDEX_RegRs) begin
                FWMuxAControl <= 2'b10;
                FWMuxBControl <= 2'b00;
            //Forward WB to EX for just B     
            end else begin
                FWMuxAControl <= 2'b00;
                FWMuxBControl <= 2'b10;
            end 
        //No Forwarding needed
        end else begin
            FWMuxAControl <= 2'b00;
            FWMuxBControl <= 2'b00;
        end*/
    end
endmodule
