library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity ADD is
    generic (nq, nm: INTEGER);
    port(A_I  : in  unsigned(nm downto 0);
         M    : in  unsigned(nm-1 downto 0);
         START: in  STD_LOGIC;
         A_O  : out unsigned(nm downto 0));
end entity ADD;

architecture bhv of ADD is
begin
    process(START)
    begin
        if (START = '1') then
            A_O <= A_I + M;
        end if;
    end process;
end architecture bhv;