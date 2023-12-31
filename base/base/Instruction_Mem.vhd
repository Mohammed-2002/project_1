-- if you like to program your own code, just use following website to translate the instruction
-- https://luplab.gitlab.io/rvcodecjs/ 	
-- this site DOES not work for branching!!
	
-- In this file the instruction are hardcoded
-- During the course it showed that this should be saved into SRAM, but to make it easier we hardcode it here

library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity Instruction_Mem is
    port (
        Address     :in std_logic_vector(15 downto 0);
        instruction :out std_logic_vector(31 downto 0) 
    );
end entity Instruction_Mem;

architecture arch_Instruction_Mem of Instruction_Mem is
    
    type ROM_ARRAY is array (0 to 65535) of std_logic_vector(7 downto 0);      --declaring size of memory. 128 elements of 32 bits
    constant ROM : ROM_ARRAY := (
        "00000000","00000000","00000000","00000000",		-- nop 				-PC 00
        "00000000","00010010","10000010","10010011",         -- addi x5,x5,1     04  
        "00000000","00010010","10000010","10010011",         -- addi x5,x5,1     08  
        "01000000","01110010","10000001","10110011",         --sub x3, x7, x5    0C   
        "00000000","01110011","01110010","10110011",         --and x5, x6, x7	 10
        "00000000","00000011","01110010","10010011",         --andi x5, x6, 0	 14
        "00000000","01110011","01000010","10110011",         --xor x5, x6, x7	 18
        "00000000","01110011","01000010","10010011",         --xori x5, x6, 7	 1C
        "00000000","01110011","01100010","10110011",         --or x5, x6, x7	 20
        "00000000","01110011","01100010","10010011",         --ori x5, x6, 7	 24
        "00000000","01110011","00010010","10110011",         --sll x5, x6, x7	 28
        "00000000","01110011","01010010","10110011",         --srl x5, x6, x7    2C
        "00000000","01110011","00100010","10110011",         --slt x5, x6, x7    30
        "00000000","00110001","00000010","10100011",         --sb x3, 5(x2) 	 34
        "00000000","01010001","00100001","10100011",         --sw x5, 3(x2) 	 38
        "00000000","01010001","00000001","00000011",         --lb x2, 5(x3) 	 3C
        "00000000","00110001","10100011","00000011",         --lw x4, 5(x3)		 40
        "00000000","00110000","00000001","00010011",         --branches-------- addi x2,x0, 3   44
        "00000000","00010100","00000100","00010011",        -- addi x8,x8,1                     48
        "11111110","10000001","00011100","11100011",        -- bne x2,x8, BRANCHES              4C      (bne x2, x8, -8)
--------------------FIBONACCI-------------------------------------------------------------
        "00000000","00000000","11110000","10010011",    -- andi x1,x1, 0x0                      50  n
        "00000000","00000001","01110001","00010011",    -- andi x2,x2, 0x0                      54  first
        "00000000","00000001","11110001","10010011",    -- andi x3,x3, 0x0                      58  second
        "00000000","00000010","01110010","00010011",    -- andi x4,x4, 0x0                      5C  next
        "00000000","00000010","11110010","10010011",    -- andi x5,x5, 0x0                      60  c
        "00000000","00000011","11110011","10010011",    -- andi x7,x7, 0x0                      64  num 1
        "00000000","00010011","10000011","10010011",    -- addi x7,x7, 0x1                      68  num 1
        "00000000","00010001","10000001","10010011",    -- addi x3,x3, 0x1                      6C  second = 1
        "00000000","01010000","10000000","10010011",    -- addi x1,x1, 0x5                      70  numero = 5
        "00000000","00000100","01110100","00010011",    -- andi x8,x8, 0x0                      74  base
        "00000000","00000100","00000100","00010011",    -- addi x8,x8, 0x0                      78
        "00000000","01110100","10000100","10010011",    -- addi x9,x9, 0x7                      7C  offset 
        "00000000","01110010","11000110","01100011",    --blt x5,x7, NEXTC       FIBONACCI:     80
        "00000000","00000010","10000010","00010011",    -- addi x4,x5,0x0    				  	84
        "00000001","00000000","00000000","01101111",    -- jal x0, STORE     -- NEXTC:			88
        "00000000","00110001","00000010","00110011",    -- add x4,x2,x3							8C
        "00000000","00000001","10000001","00010011",    -- addi x2,x3,0							90
        "00000000","00000010","00000001","10010011",    -- addi x3,x4,0							94
        "00000000","01000100","00000000","00100011",    -- STORE:  -- sb x4,0(x8)				98
        "00000000","00010100","00000100","00010011",    -- addi x8,x8,1							9C
        "00000000","00010010","10000010","10010011",    -- addi x5,x5,1
        "11111010","10010100","00000110","11100011",    -- beq x8,x9, BEGIN
        "11111100","00010010","11001100","11100011",    -- bgt x1,x5, FIBONACCI
        others => X"00"
    );
begin
    instruction <= ROM(conv_integer(Address)) & ROM(conv_integer(Address + 1)) &
                   ROM(conv_integer(Address + 2)) & ROM(conv_integer(Address + 3)); 

end architecture arch_Instruction_Mem;


-- int n, first = 0, second = 1, next, c;
 
--   printf("Enter the number of terms\n");
--   scanf("%d", &n);
 
--   printf("First %d terms of Fibonacci series are:\n", n);
 
--   for (c = 0; c < n; c++)
--   {
--     if (c <= 1)
--       next = c;
--     else
--     {
--       next = first + second;
--       first = second;
--       second = next;
--     }
--     printf("%d\n", next);
--   }
 
--   return 0;
-- }