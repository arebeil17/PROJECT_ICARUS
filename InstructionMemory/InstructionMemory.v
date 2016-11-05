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
    reg [31:0] memory [26:0]; //Leave this alone you bastard!
    
    initial begin
        memory[0]  = 32'b00100000000010010000000000000001;	//	main: addi	  $t1, $0, 1
        memory[1]  = 32'b00100000000010100000000000000010;   //       addi    $t2, $0, 2
        memory[2]  = 32'b00100000000010110000000000000011;   //       addi    $t3, $0, 3
        memory[3]  = 32'b00100000000011000000000000000100;   //       addi    $t4, $0, 4
        memory[4]  = 32'b00100000000011010000000000000101;   //       addi    $t5, $0, 5
        memory[5]  = 32'b00100000000011100000000000000110;   //       addi    $t6, $0, 6
        memory[6]  = 32'b00100000000011110000000000000111;   //       addi    $t7, $0, 7
        memory[7]  = 32'b00000000000000001000000000100000;   // loop: add     $s0, $0, $0
        memory[8]  = 32'b00000001001000001000100000100000;   //       add     $s1, $t1, $0
        memory[9]  = 32'b00000001010000001001000000100000;   //       add     $s2, $t2, $0
        memory[10] = 32'b00000001010010011001100000100000;  //        add     $s3, $t2, $t1
        memory[11] = 32'b00000001100000001010000000100000;  //        add     $s4, $t4, $0
        memory[12] = 32'b00000001101000001010100000100000;  //        add     $s5, $t5, $0
        memory[13] = 32'b00000001100010101011000000100000;  //        add     $s6, $t4, $t2
        memory[14] = 32'b00000001010010101000000000100010;  //        sub     $s0, $t2, $t2
        memory[15] = 32'b00000001011010101000100000100010;  //        sub     $s1, $t3, $t2
        memory[16] = 32'b00000001100010101001000000100010;  //        sub     $s2, $t4, $t2
        memory[17] = 32'b01110001011010011001100000000010;  //        mul     $s3, $t3, $t1
        memory[18] = 32'b01110001100100011010000000000010;  //        mul     $s4, $t4, $s1
        memory[19] = 32'b00000001101011011010100000100100;  //        and     $s5, $t5, $t5
        memory[20] = 32'b00000001110000001011000000100101;  //        or      $s6, $t6, $0
        memory[21] = 32'b00010010100011000000000000000100;	//		  beq	  $s4, $t4, skip
        memory[22] = 32'b00100010001100010000000000000000;    //      addi    $s1, $s1, 0
        memory[23] = 32'b00100010010100100000000000000000;    //      addi    $s2, $s2, 0
        memory[24] = 32'b00100010011100110000000000000000;	 //		  addi	  $s3, $s3, 0
        memory[25] = 32'b00100010100101000000000000000000;    //      addi    $s4, $s4, 0
        memory[26] = 32'b00001000000000000000000000000111;    //      skip:    j    loop

    end

    assign Instruction = memory[Address[31:2]];
    
endmodule
