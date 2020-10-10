library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity ADD is
    generic (nq, nm: INTEGER RANGE 1 TO 15);
    port(A_I  : in  unsigned(nm downto 0);
         M    : in  STD_LOGIC_VECTOR(nm-1 downto 0);
         START: in  STD_LOGIC;
         PASS : in  STD_LOGIC;
         RESET: in  STD_LOGIC;
         A_O  : out unsigned(nm downto 0));
end entity ADD;

architecture bhv of ADD is
begin
    process(START, RESET, A_I, M, PASS)
    begin
        if (RESET = '1') then
            A_O <= TO_UNSIGNED(0, nm+1);
        elsif (START = '1') then
            A_O <= A_I + unsigned(M);
        elsif (PASS = '1') then
            A_O <= A_I;
        end if;
    end process;
end architecture bhv;