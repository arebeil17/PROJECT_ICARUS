`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Computer Architecture
// Laboratory  1
// Module - InstructionMemory.v
// Description - 32-Bit wide instruction memory.
//
// INPUT:-
// Address: 32-Bit address input port.
//
// OUTPUT:-
// Instruction: 32-Bit output port.
//
// FUNCTIONALITY:-
// Similar to the DataMemory, this module should also be byte-addressed
// (i.e., ignore bits 0 and 1 of 'Address'). All of the instructions will be 
// hard-coded into the instruction memory, so there is no need to write to the 
// InstructionMemory.  The contents of the InstructionMemory is the machine 
// language program to be run on your MIPS processor.
//
//
//we will store the machine code for a code written in C later. for now initialize 
//each entry to be its index * 4 (memory[i] = i * 4;)
//all you need to do is give an address as input and read the contents of the 
//address on your output port. 
// 
//Using a 32bit address you will index into the memory, output the contents of that specific 
//address. for data memory we are using 1K word of storage space. for the instruction memory 
//you may assume smaller size for practical purpose. you can use 128 words as the size and 
//hardcode the values.  in this case you need 7 bits to index into the memory. 
//
//be careful with the least two significant bits of the 32bit address. those help us index 
//into one of the 4 bytes in a word. therefore you will need to use bit [8-2] of the input address. 


////////////////////////////////////////////////////////////////////////////////

module InstructionMemory(Address, Instruction); 

    input [31:0] Address;        // Input Address 

    output [31:0] Instruction;    // Instruction at memory location Address
    
	// Modify the size of the Instructions Array to Be The Total Lines of Code
    reg [31:0] memory [25:0]; //Always check this after to change to IM
    
    initial begin
        memory[0] = 32'b00100000000010000000000000000101;	//	0  main:	addi	$t0, $0, 5
        memory[1] = 32'b00100000000010010000000000000100;   //  4           addi    $t1, $0, 4
        memory[2] = 32'b00100000000010100000000000001001;   //  8           addi    $t2, $0, 9
        memory[3] = 32'b00100000000010111111111111110111;   //  12          addi    $t3, $0, -9
        memory[4] = 32'b00100000000011001111111111110111;   //  16          addi    $t4, $0, -9
        memory[5] = 32'b00100000000100000000000000000000;   //  20          addi    $s0, $0, 0
        memory[6] = 32'b00100000000100010000000000000000;   //  24          addi    $s1, $0, 0
        memory[7] = 32'b00100000000100100000000000000000;   //  28          addi    $s2, $0, 0
        memory[8] = 32'b00100000000100110000000000000000;   //  32          addi    $s3, $0, 0
        memory[9] = 32'b00010010000010000000000000000010;   //  36  loop0:  beq     $s0, $t0, loop1
        memory[10] = 32'b00100010000100000000000000000001;  //  40          addi    $s0, $s0, 1
        memory[11] = 32'b00001000000000000000000000001001;  //  44          j       loop0
        memory[12] = 32'b00010110001000000000000000000011;  //  48  loop1:  bne     $s1, $0, loop2
        memory[13] = 32'b00100001001010011111111111111111;  //  52          addi    $t1, $t1, -1
        memory[14] = 32'b00000001001000001000100000101010;  //  56          slt     $s1, $t1, $0
        memory[15] = 32'b00001000000000000000000000001100;  //  60          j       loop1
        memory[16] = 32'b00011001010000000000000000000010;  //  64  loop2:  blez    $t2, loop3
        memory[17] = 32'b00100001010010101111111111111110;  //  68          addi    $t2, $t2, -2
        memory[18] = 32'b00001000000000000000000000010000;  //  72          j       loop2
        memory[19] = 32'b00000101011000010000000000000010;  //  76  loop3:  bgez    $t3, loop4
        memory[20] = 32'b00100001011010110000000000000010;  //  80          addi    $t3, $t1, 2
        memory[21] = 32'b00001000000000000000000000010011;  //  84          j       loop3
        memory[22] = 32'b00011101100000000000000000000010;  //  88  loop4:  bgtz    $t4, end
        memory[23] = 32'b00100001100011000000000000000010;  //  92          addi    $t4, $t4, 2
        memory[24] = 32'b00001000000000000000000000010110;  //  96          j       loop4
        memory[25] = 32'b00001100000000000000000000000000;  //  100 end:    jal     0
    end

    assign Instruction = memory[Address[31:2]];
    
endmodule
