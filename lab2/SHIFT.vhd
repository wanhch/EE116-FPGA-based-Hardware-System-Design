library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity SHIFT is
    generic (nq, nm: INTEGER);
    port(A_I  : in  UNSIGNED(nm downto 0);
         Q_I  : in  UNSIGNED(nq-1 downto 0);
         RESET: in  STD_LOGIC;
         START: in  STD_LOGIC;
         A_O  : out UNSIGNED(nm downto 0);
         Q_O  : out UNSIGNED(nq-1 downto 0));
end entity SHIFT;

architecture bhv of SHIFT is
begin
    process(START, RESET, A_I, Q_I)
    variable A_Q: STD_LOGIC_VECTOR((nm+nq) downto 0);
    begin
        if (RESET = '1') then
            A_O <= TO_UNSIGNED(0, nm+1);
            Q_O <= Q_I;
        elsif (START = '1') then
            A_Q := STD_LOGIC_VECTOR(A_I) & STD_LOGIC_VECTOR(Q_I);
            A_Q := '0' & A_Q((nm+nq) downto 1);
            A_O <= UNSIGNED(A_Q((nm+nq) downto nq));
            Q_O <= UNSIGNED(A_Q(nq-1 downto 0));
        end if;
    end process;
end architecture bhv;