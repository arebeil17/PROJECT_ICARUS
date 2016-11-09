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
    Clock, Reset,  Flush, WriteEnable,
    // Control Input(s)
    RegWrite_In, ALUSrc_In, MemWrite_In, MemRead_In, Branch_In, MemToReg_In, ByteSel_In, RegDestMuxControl_In, ALUOp_In, WriteEnable_In,
    // Data Inputs
    Instruction_In,  SE_In, RF_RD1_In, RF_RD2_In, PC_In, 
    // Control Output(s)
    RegWrite_Out, ALUSrc_Out, MemWrite_Out, MemRead_Out, Branch_Out, MemToReg_Out, ByteSel_Out, RegDestMuxControl_Out, ALUOp_Out, WriteEnable_Out,
    // Outputs
    Instruction_Out, SE_Out, RF_RD1_Out, RF_RD2_Out, PC_Out);

    input Clock, Reset, Flush, WriteEnable;
    
    //-----------STAGE REG INTPUTS-------------------- 
    input  RegWrite_In, ALUSrc_In, MemWrite_In, MemRead_In, Branch_In;           
    input [1:0] ByteSel_In, RegDestMuxControl_In, MemToReg_In, WriteEnable_In;   
    input [4:0] ALUOp_In;
    input [31:0] Instruction_In, SE_In, RF_RD1_In, RF_RD2_In, PC_In;
    
    //-----------STAGE REG OUTPUTS--------------------                                
    output reg RegWrite_Out, ALUSrc_Out, MemWrite_Out, MemRead_Out, Branch_Out;           
    output reg [1:0] ByteSel_Out, RegDestMuxControl_Out, MemToReg_Out, WriteEnable_Out;
    output reg [4:0] ALUOp_Out;
    output reg [31:0] Instruction_Out, SE_Out, PC_Out, RF_RD1_Out, RF_RD2_Out;
    
    initial begin
        ALUSrc_Out <= 0;
        Branch_Out <= 0;
        ByteSel_Out <= 2'b0;
        Instruction_Out <= 32'b0;
        MemToReg_Out <= 2'b0;
        MemRead_Out <= 0;
        MemWrite_Out <= 0;
        RegDestMuxControl_Out <= 2'b0;
        RegWrite_Out <= 0;
        RF_RD1_Out <= 32'b0;
        RF_RD2_Out <= 32'b0;
        PC_Out <= 32'b0;
        SE_Out <= 32'b0;
        WriteEnable_Out <= 32'b0;
        ALUOp_Out <= 5'b0;
    end
    
    always @(posedge Clock) begin
        if(Reset || Flush) begin
            RegWrite_Out            <= 0; 
            ALUSrc_Out              <= 0;
            MemWrite_Out            <= 0; 
            MemRead_Out             <= 0; 
            Branch_Out              <= 0; 
            MemToReg_Out            <= 0; 
            ByteSel_Out             <= 0; 
            RegDestMuxControl_Out   <= 0; 
            ALUOp_Out               <= 0;
            PC_Out                  <= 0;
            RF_RD1_Out              <= 0;
            RF_RD2_Out              <= 0;
            SE_Out                  <= 0;
            Instruction_Out         <= 0;
            WriteEnable_Out         <= 0;
        end else begin
            //if(WriteEnable) begin
                RegWrite_Out            <= RegWrite_In; 
                ALUSrc_Out              <= ALUSrc_In;
                MemWrite_Out            <= MemWrite_In; 
                MemRead_Out             <= MemRead_In; 
                Branch_Out              <= Branch_In; 
                MemToReg_Out            <= MemToReg_In; 
                ByteSel_Out             <= ByteSel_In; 
                RegDestMuxControl_Out   <= RegDestMuxControl_In; 
                ALUOp_Out               <= ALUOp_In;
                PC_Out                  <= PC_In;
                RF_RD1_Out              <= RF_RD1_In;
                RF_RD2_Out              <= RF_RD2_In;
                SE_Out                  <= SE_In;
                Instruction_Out         <= Instruction_In;
                WriteEnable_Out         <= WriteEnable_In;
            //end
        end
     end       
endmodule
