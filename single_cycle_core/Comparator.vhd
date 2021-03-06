-------------------------------------------------------------------------
---- Simulation Tutorial
---
---- Description: Checks the outputs of the 2 adders by comparing them.
----
---- Author: Victor Lai, Lingkan Gong
----
---- Date: 13/02/2011
----
----
-------------------------------------------------------------------------

library IEEE;

use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Comparator is
    port(
        zero          : in  std_logic;
        zero_ref      : in  std_logic;
        res           : in  std_logic_vector(15 downto 0);
        res_ref       : in  std_logic_vector(15 downto 0);
        pass_or_fail  : out std_logic
    );

end Comparator;

architecture behavioural of Comparator is

begin

    process(zero, res, zero_ref, res_ref)
    begin
        pass_or_fail <= '0'; -- pass

        if (zero /= zero_ref or res /= res_ref) then
            pass_or_fail <= '1'; -- fail
        end if;

    end process;

end behavioural;
