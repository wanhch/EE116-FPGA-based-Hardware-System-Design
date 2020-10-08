library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity SHIFT is
    generic (nq, nm: INTEGER);
    port(A_I  : in  unsigned(nm downto 0);
         Q_I  : in  unsigned(nq-1 downto 0);
         START: in  STD_LOGIC;
         A_O  : out unsigned(nm downto 0);
         Q_O  : out unsigned(nq-1 downto 0));
end entity SHIFT;

architecture bhv of SHIFT is
    signal A_Q: STD_LOGIC_VECTOR((nm+nq)-1 downto 0);
begin
    process(START)
    begin
        if (START = '1') then
            A_Q <= STD_LOGIC_VECTOR(A_I) & STD_LOGIC_VECTOR(Q_I);
            A_Q <= '0' & A_Q((nm+nq)-1 downto 1);
            A_O <= TO_UNSIGNED(A_Q((nm+nq)-1 downto nq));
            Q_O <= TO_UNSIGNED(A_Q(nq-1 downto 0));
        end if;
    end process;
end architecture bhv;