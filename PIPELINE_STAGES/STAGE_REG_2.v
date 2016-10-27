`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// Create Date: 10/27/2016 11:29:12 AM
// Design Name: 
// Module Name: STAGE_REG_2
// Project Name: 
//////////////////////////////////////////////////////////////////////////////////

module STAGE_REG_2(Clk, Rst, IM, RegWrite, ALUSrc, MemWrite, MemRead, Branch, MemToReg, SignExt, JumpMuxSel, ByteSel, RegDst, ALUOp, SE, RF_RD1, RF_RD2, PCI, 
                             IM_Out, RegWrite_Out, ALUSrc_Out, MemWrite_Out, MemRead_Out, Branch_Out, MemToReg_Out, SignExt_Out, JumpMuxSel_Out, ByteSel_Out, RegDst_Out, ALUOp_Out, SE_Out, RF_RD1_Out, RF_RD2_Out, PCI_Out);

    input Clk, Rst;
    
    //-----------STAGE REG INTPUTS-------------------- 
    //Control Signal Inputs
    input  RegWrite, 
           ALUSrc, 
           MemWrite, 
           MemRead, 
           Branch, 
           MemToReg, 
           SignExt, 
           JumpMuxSel;           
    
    input [1:0] ByteSel, RegDst;   
    
    input [4:0] ALUOp;
    
    //Datapath pass-through inputs
    input [31:0] IM,
                 SE, 
                 RF_RD1, 
                 RF_RD2, 
                 PCI;
    //-----------STAGE REG OUTPUTS--------------------                        
    //Control Signal Outputs            
    output reg  RegWrite_Out, 
                ALUSrc_Out, 
                MemWrite_Out, 
                MemRead_Out, 
                Branch_Out, 
                MemToReg_Out, 
                SignExt_Out, 
                JumpMuxSel_Out;           
     
     output reg [1:0] ByteSel_Out, RegDst_Out;   
     
     output reg [4:0] ALUOp_Out;
     
     //Datapath pass-through Outputs
     output reg [31:0] IM_Out,
                       SE_Out, 
                       RF_RD1_Out, 
                       RF_RD2_Out, 
                       PCI_Out;  
     
     always @(posedge Clk) begin
        
        if(Rst) begin
            IM_Out         <= 0;
            RegWrite_Out   <= 0; 
            ALUSrc_Out     <= 0;
            MemWrite_Out   <= 0; 
            MemRead_Out    <= 0; 
            Branch_Out     <= 0; 
            MemToReg_Out   <= 0; 
            SignExt_Out    <= 0; 
            JumpMuxSel_Out <= 0; 
            ByteSel_Out    <= 0; 
            RegDst_Out     <= 0; 
            ALUOp_Out      <= 0; 
            SE_Out         <= 0; 
            RF_RD1_Out     <= 0; 
            RF_RD2_Out     <= 0; 
            PCI_Out        <= 0;
        end else begin
            IM_Out         <= IM;
            RegWrite_Out   <= RegWrite; 
            ALUSrc_Out     <= ALUSrc;
            MemWrite_Out   <= MemWrite; 
            MemRead_Out    <= MemRead; 
            Branch_Out     <= Branch; 
            MemToReg_Out   <= MemToReg; 
            SignExt_Out    <= SignExt; 
            JumpMuxSel_Out <= JumpMuxSel; 
            ByteSel_Out    <= ByteSel; 
            RegDst_Out     <= RegDst; 
            ALUOp_Out      <= ALUOp; 
            SE_Out         <= SE; 
            RF_RD1_Out     <= RF_RD1; 
            RF_RD2_Out     <= RF_RD2; 
            PCI_Out        <= PCI;
        end
     
     end       
    

endmodule
