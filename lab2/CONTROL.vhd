library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
 
entity CONTROL is
    generic (nq, nm: INTEGER);
    port (Multiplier: in  unsigned(nq-1 downto 0);
          START     : in  STD_LOGIC;
          A_I       : in  unsigned(nm downto 0);
          Q_I       : in  unsigned(nq-1 downto 0);
          CLK       : in  STD_LOGIC;
          DONE      : out STD_LOGIC;
          PRODUCT   : out unsigned(nq+nm-1 downto 0);
          A_O       : out unsigned(nm downto 0);
          Q_O       : out unsigned(nq-1 downto 0);
          SH        : out STD_LOGIC;
          AD        : out STD_LOGIC);
end entity CONTROL;

architecture bhv of CONTROL is
begin
    process(CLK, START)
    type StateType is (init, add, shift, halt);
    variable state: StateType;
    variable count: INTEGER;
    begin
        if (START = '1') then
            state := init;
        elsif (rising_edge(clk)) then
            case state is
            when init => 
                A_O <= TO_UNSIGNED(0, nm+1);
                Q_O <= Multiplier;
                DONE <= '0';
                count := 0;
                if (STD_LOGIC_VECTOR(Q_I)(0) = '1') then
                    AD <= '1';
                    SH <= '0';
                    state := add;
                elsif (STD_LOGIC_VECTOR(Q_I)(0) = '0') then
                    AD <= '0';
                    SH <= '1';
                    state := shift;
                end if;
            when add =>
                A_O <= A_I;
                Q_O <= Q_I;
                AD <= '0';
                SH <= '1';
                state := shift;
            when shift =>
                count:= count + 1;
                A_O <= A_I;
                Q_O <= Q_I;
                if (count = nq) then
                    PRODUCT <= STD_LOGIC_VECTOR(A_I(nm-1 downto 0)) & STD_LOGIC_VECTOR(Q_I);
                    state := halt;
                else
                    if (STD_LOGIC_VECTOR(Q_I)(0) = '1') then
                        AD <= '1';
                        SH <= '0';
                        state := add;
                    elsif (STD_LOGIC_VECTOR(Q_I)(0) = '0') then
                        AD <= '0';
                        SH <= '1';
                        state := shift;
                    end if;
                end if;
            when halt =>
                DONE <= '1';
                AD <= '0';
                SH <= '0';
            end case;
        end if;
    end process;
end architecture bhv;