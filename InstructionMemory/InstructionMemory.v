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
    reg [31:0] memory [21:0]; //Always check this after to change to IM
    
    initial begin
        memory[0] = 32'b00100000000010010000000000000001;	//	main:	addi	$t1, $0, 1
        memory[1] = 32'b00100000000010100000000000000010;    //        addi    $t2, $0, 2
        memory[2] = 32'b00100000000010110000000000000011;    //        addi    $t3, $0, 3
        memory[3] = 32'b00100000000011000000000000000100;    //        addi    $t4, $0, 4
        memory[4] = 32'b00100000000011010000000000000101;    //        addi    $t5, $0, 5
        memory[5] = 32'b00100000000011100000000000000110;    //        addi    $t6, $0, 6
        memory[6] = 32'b00100000000011110000000000000111;    //        addi    $t7, $0, 7
        memory[7] = 32'b00000000000000001000000000100000;    //loop:   add    $s0, $0, $0
        memory[8] = 32'b00000010000010011000100000100000;    //        add    $s1, $s0, $t1
        memory[9] = 32'b00000010001100011001000000100000;    //        add    $s2, $s1, $s1
        memory[10] = 32'b00000010010100011001100000100000;    //       add    $s3, $s2, $s1
        memory[11] = 32'b00000010010100101010000000100000;    //       add    $s4, $s2, $s2
        memory[12] = 32'b00000010100100011010100000100000;    //       add    $s5, $s4, $s1
        memory[13] = 32'b00000001100010101011000000100000;    //       add    $s6, $t4, $t2
        memory[14] = 32'b00000010110100011010100000100010;    //       sub    $s5, $s6, $s1
        memory[15] = 32'b00000010110010101010000000100010;    //       sub    $s4, $s6, $t2
        memory[16] = 32'b00000010100100011001100000100010;    //       sub    $s3, $s4, $s1
        memory[17] = 32'b00000010100100101001000000100010;    //       sub    $s2, $s4, $s2
        memory[18] = 32'b00000010011100101000100000100010;    //       sub    $s1, $s3, $s2
        memory[19] = 32'b00001100000000000000000000000111;    //       jal    loop
        memory[20] = 32'b00001000000000000000000000000111;    //       j      loop
        memory[21] = 32'b00000000000000000000000000000000;    //       nop

    end

    assign Instruction = memory[Address[31:2]];
    
endmodule
