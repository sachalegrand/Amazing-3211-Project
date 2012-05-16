---------------------------------------------------------------------------
-- control_unit.vhd - Control Unit Implementation
--
-- Notes: refer to headers in single_cycle_core.vhd for the supported ISA.
--
--  control signals:
--     reg_dst    : asserted for ADD instructions, so that the register
--                  destination number for the 'write_register' comes from
--                  the rd field (bits 3-0). 
--     reg_write  : asserted for ADD and LOAD instructions, so that the
--                  register on the 'write_register' input is written with
--                  the value on the 'write_data' port.
--     alu_src    : asserted for LOAD and STORE instructions, so that the
--                  second ALU operand is the sign-extended, lower 4 bits
--                  of the instruction.
--     mem_write  : asserted for STORE instructions, so that the data 
--                  memory contents designated by the address input are
--                  replaced by the value on the 'write_data' input.
--     mem_to_reg : asserted for LOAD instructions, so that the value fed
--                  to the register 'write_data' input comes from the
--                  data memory.
--
--
-- Copyright (C) 2006 by Lih Wen Koh (lwkoh@cse.unsw.edu.au)
-- All Rights Reserved. 
--
-- The single-cycle processor core is provided AS IS, with no warranty of 
-- any kind, express or implied. The user of the program accepts full 
-- responsibility for the application of the program and the use of any 
-- results. This work may be downloaded, compiled, executed, copied, and 
-- modified solely for nonprofit, educational, noncommercial research, and 
-- noncommercial scholarship purposes provided that this notice in its 
-- entirety accompanies all copies. Copies of the modified software can be 
-- delivered to persons who use it solely for nonprofit, educational, 
-- noncommercial research, and noncommercial scholarship purposes provided 
-- that this notice in its entirety accompanies all copies.
--
---------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity control_unit is
    port ( opcode     : in  std_logic_vector(2 downto 0);
           reg_dst    : out std_logic;
           reg_write  : out std_logic;
           alu_src    : out std_logic;
           mem_write  : out std_logic;
           mem_to_reg : out std_logic;
           alucontrol : out std_logic_vector (1 downto 0) --new opcode sig
           );  
end control_unit;


architecture behavioural of control_unit is

--i've removed the first digit from each opcode
constant OP_LOAD  : std_logic_vector(2 downto 0) := "001";
constant OP_STORE : std_logic_vector(2 downto 0) := "011";
constant OP_ADD   : std_logic_vector(2 downto 0) := "010";
constant OP_ADDI   : std_logic_vector(2 downto 0) := "101";
constant OP_BNE   : std_logic_vector(2 downto 0) := "100"; --new opcode
constant OP_SUB   : std_logic_vector(2 downto 0) := "110"; --new opcode


begin

 reg_dst    <= '1' after 1.5 ns when (opcode = OP_ADD or opcode = OP_SUB) else
                  '0' after 1.5 ns;

    reg_write  <= '1' after 1.5 ns when (opcode = OP_ADD or opcode = OP_ADDI
                            or opcode = OP_LOAD or opcode = OP_SUB) else
                  '0'after 1.5 ns;
    
    alu_src    <= '1' after 1.5 ns when (opcode = OP_LOAD 
                           or opcode = OP_STORE or opcode = OP_ADDI) else
                  '0' after 1.5 ns;
                 
    mem_write  <= '1' after 1.5 ns when opcode = OP_STORE else
                  '0'after 1.5 ns;
                 
    mem_to_reg <= '1' after 1.5 ns when opcode = OP_LOAD else
                  '0'after 1.5 ns;
                  
    with opcode SELECT
    alucontrol    <=  "11" after 1.5 ns when OP_BNE,
                      "01" after 1.5 ns when OP_ADD,
                      "01" after 1.5 ns when OP_ADDI,
                      "10" after 1.5 ns when OP_SUB, 
                      "00" after 1.5 ns when others ;
  
 

end behavioural;

