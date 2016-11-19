`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Computer Architecture
// 
//
//
// Student(s) Name and Last Name: FILL IN YOUR INFO HERE!
//
//
// Module - register_file.v
// Description - Implements a register file with 32 32-Bit wide registers.
//
// 
// INPUTS:-
// ReadRegister1: 5-Bit address to select a register to be read through 32-Bit 
//                output port 'ReadRegister1'.
// ReadRegister2: 5-Bit address to select a register to be read through 32-Bit 
//                output port 'ReadRegister2'.
// WriteRegister: 5-Bit address to select a register to be written through 32-Bit
//                input port 'WriteRegister'.
// WriteData: 32-Bit write input port.
// RegWrite: 1-Bit control input signal.
//
// OUTPUTS:-
// ReadData1: 32-Bit registered output. 
// ReadData2: 32-Bit registered output. 
//
// FUNCTIONALITY:-
// 'ReadRegister1' and 'ReadRegister2' are two 5-bit addresses to read two 
// registers simultaneously. The two 32-bit data sets are available on ports 
// 'ReadData1' and 'ReadData2', respectively. 'ReadData1' and 'ReadData2' are 
// registered outputs (output of register file is written into these registers 
// at the falling edge of the clock). You can view it as if outputs of registers
// specified by ReadRegister1 and ReadRegister2 are written into output 
// registers ReadData1 and ReadData2 at the falling edge of the clock. 
//
// 'RegWrite' signal is high during the rising edge of the clock if the input 
// data is to be written into the register file. The contents of the register 
// specified by address 'WriteRegister' in the register file are modified at the 
// rising edge of the clock if 'RegWrite' signal is high. The D-flip flops in 
// the register file are positive-edge (rising-edge) triggered. (You have to use 
// this information to generate the write-clock properly.) 
//
// NOTE:-
// We will design the register file such that the contents of registers do not 
// change for a pre-specified time before the falling edge of the clock arrives 
// to allow for data multiplexing and setup time.
////////////////////////////////////////////////////////////////////////////////

module RegisterFile(
    Clk, Reset,
    // Control Input(s)
    RegWrite, JAL,
    // Data Input(s)
    ReadRegister1, ReadRegister2, WriteRegister1, WriteRegister2, 
    // Control Output(s)
    // Data Output(s)
    WriteData1, WriteData2,  ReadData1, ReadData2,
    // Specials For Demonstration
    s1_Out, s2_Out, s3_Out, s4_Out);
    
    input [4:0] ReadRegister1, ReadRegister2, WriteRegister1, WriteRegister2;
    input [31:0] WriteData1, WriteData2;
    input RegWrite, Reset, JAL;
    input Clk;
    
    output reg [31:0] ReadData1, ReadData2;
    (* keep = "true" *) output [31:0] s1_Out, s2_Out, s3_Out, s4_Out;
    
    reg [31:0] registers [0:31];
    
    initial begin
	   registers[0] =  32'b00000000000000000000000000000000;
	   registers[1] =  32'b00000000000000000000000000000000;
	   registers[2] =  32'b00000000000000000000000000000000;
	   registers[3] =  32'b00000000000000000000000000000000;
	   registers[4] =  32'b00000000000000000000000000000000;
	   registers[5] =  32'b00000000000000000000000000000000;
	   registers[6] =  32'b00000000000000000000000000000000;
	   registers[7] =  32'b00000000000000000000000000000000;
	   registers[8] =  32'b00000000000000000000000000000000;
	   registers[9] =  32'b00000000000000000000000000000000;
	   registers[10] = 32'b00000000000000000000000000000000;
	   registers[11] = 32'b00000000000000000000000000000000;
	   registers[12] = 32'b00000000000000000000000000000000;
	   registers[13] = 32'b00000000000000000000000000000000;
	   registers[14] = 32'b00000000000000000000000000000000;
	   registers[15] = 32'b00000000000000000000000000000000;
	   registers[16] = 32'b00000000000000000000000000000000;
	   registers[17] = 32'b00000000000000000000000000000000;
	   registers[18] = 32'b00000000000000000000000000000000;
	   registers[19] = 32'b00000000000000000000000000000000;
	   registers[20] = 32'b00000000000000000000000000000000;
	   registers[21] = 32'b00000000000000000000000000000000;
	   registers[22] = 32'b00000000000000000000000000000000;
	   registers[23] = 32'b00000000000000000000000000000000;
	   registers[24] = 32'b00000000000000000000000000000000;
	   registers[25] = 32'b00000000000000000000000000000000;
	   registers[26] = 32'b00000000000000000000000000000000;
	   registers[27] = 32'b00000000000000000000000000000000;
	   registers[28] = 32'b00000000000000000000000000000000;
	   registers[29] = 32'b00000000000000000000000000000000;
	   registers[30] = 32'b00000000000000000000000000000000;
	   registers[31] = 32'b00000000000000000000000000000000;
	end

    always @(negedge Clk, posedge Reset) begin
        if(Reset)begin
            registers[0] =  32'b00000000000000000000000000000000;
            registers[1] =  32'b00000000000000000000000000000000;
            registers[2] =  32'b00000000000000000000000000000000;
            registers[3] =  32'b00000000000000000000000000000000;
            registers[4] =  32'b00000000000000000000000000000000;
            registers[5] =  32'b00000000000000000000000000000000;
            registers[6] =  32'b00000000000000000000000000000000;
            registers[7] =  32'b00000000000000000000000000000000;
            registers[8] =  32'b00000000000000000000000000000000;
            registers[9] =  32'b00000000000000000000000000000000;
            registers[10] = 32'b00000000000000000000000000000000;
            registers[11] = 32'b00000000000000000000000000000000;
            registers[12] = 32'b00000000000000000000000000000000;
            registers[13] = 32'b00000000000000000000000000000000;
            registers[14] = 32'b00000000000000000000000000000000;
            registers[15] = 32'b00000000000000000000000000000000;
            registers[16] = 32'b00000000000000000000000000000000;
            registers[17] = 32'b00000000000000000000000000000000;
            registers[18] = 32'b00000000000000000000000000000000;
            registers[19] = 32'b00000000000000000000000000000000;
            registers[20] = 32'b00000000000000000000000000000000;
            registers[21] = 32'b00000000000000000000000000000000;
            registers[22] = 32'b00000000000000000000000000000000;
            registers[23] = 32'b00000000000000000000000000000000;
            registers[24] = 32'b00000000000000000000000000000000;
            registers[25] = 32'b00000000000000000000000000000000;
            registers[26] = 32'b00000000000000000000000000000000;
            registers[27] = 32'b00000000000000000000000000000000;
            registers[28] = 32'b00000000000000000000000000000000;
            registers[29] = 32'b00000000000000000000000000000000;
            registers[30] = 32'b00000000000000000000000000000000;
            registers[31] = 32'b00000000000000000000000000000000;
            
            ReadData1 <= 32'b0;
            ReadData2 <= 32'b0;
        end else begin
            if(RegWrite)registers[WriteRegister1] = WriteData1;
                ReadData1 = registers[ReadRegister1];
                ReadData2 = registers[ReadRegister2];
            if(JAL) begin
                registers[WriteRegister2] = WriteData2;
            end
        end
    end
    
    assign s1_Out = registers[17];
    assign s2_Out = registers[18];
    assign s3_Out = registers[19];
    assign s4_Out = registers[20];
endmodule
