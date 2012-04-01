---------------------------------------------------------------------------
-- adder_16b.vhd - 16-bit Adder Implementation
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


entity alu is
    port ( alucontrol: in std_logic_vector(1 downto 0); 
           src_a     : in  std_logic_vector(15 downto 0);
           src_b     : in  std_logic_vector(15 downto 0);
           res       : out std_logic_vector(15 downto 0);
           zero      : out std_logic ); --TRUE if subtraction led to 0
end alu;



architecture structural of alu is

component addsumunit is
    port ( alucontrol: in std_logic_vector(1 downto 0); 
           src_a     : in  std_logic_vector(7 downto 0);
           src_b     : in  std_logic_vector(7 downto 0);
           res       : out std_logic_vector (7 downto 0);
           zero      : out std_logic );
end component;


--alucontrol: '01' for add
--alucontrol: '10' for sub
--alucontrol: '11' for beq


begin
  
  
  my_addsumunit : addsumunit
  port map ( 
      alucontrol => alucontrol,
      src_a => src_a(7 downto 0),
      src_b => src_b(7 downto 0),
      res => res(7 downto 0),
      zero => zero
   );
  
    res (15 downto 8) <= "00000000";
    
end structural;