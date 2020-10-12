library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
 
entity CONTROL is
    generic (nq: INTEGER;
             nm: INTEGER);
    port (Multiplier: in  STD_LOGIC_VECTOR(nq-1 downto 0);
          START     : in  STD_LOGIC;
          A_I       : in  UNSIGNED(nm downto 0);
          Q_I       : in  UNSIGNED(nq-1 downto 0);
          CLK       : in  STD_LOGIC;
          DONE      : out STD_LOGIC;
          PRODUCT   : out STD_LOGIC_VECTOR(nq+nm-1 downto 0);
          A_O       : out UNSIGNED(nm downto 0);
          Q_O       : out UNSIGNED(nq-1 downto 0);
          RESET     : out STD_LOGIC;
          SH        : out STD_LOGIC;
          PASS      : out STD_LOGIC;
          AD        : out STD_LOGIC);
end entity CONTROL;

architecture bhv of CONTROL is
begin
    process(CLK, START)
   type StateType is (init, add, shift, halt, judge);
    variable state: StateType := init;
    variable count: INTEGER RANGE 0 TO 1000;
    begin
        if (START = '1') then
            DONE <= '0';
            RESET <= '1';
            A_O <= TO_UNSIGNED(0, nm+1);
            Q_O <= UNSIGNED(Multiplier);
            state := init;
        elsif (rising_edge(clk)) then
            case state is
            when init => 
                DONE <= '0';
                count := 0;
                RESET <= '0';
                if (Multiplier(0) = '1') then
                    state := add;
                elsif (Multiplier(0) = '0') then
                    state := shift;
                end if;
            when judge =>
                AD <= '0';
                SH <= '0';
                A_O <= A_I;
                Q_O <= Q_I;
                if (count = nq) then
                    state := halt;
                elsif (Q_I(0) = '1') then
                    PASS <= '0';
                    state := add;
                elsif (Q_I(0) = '0') then
                    PASS <= '1';
                    state := shift;
                end if;
            when add =>
                AD <= '1';
                SH <= '0';
                state := shift;
            when shift =>
                AD <= '0';
                SH <= '1';
                if (count >= 2147483640) then
                    count := 0;
                else
                    count := count + 1;
                end if;
                state:= judge;
            when halt =>
                PRODUCT <= STD_LOGIC_VECTOR(A_I(nm-1 downto 0) & Q_I);
                DONE <= '1';
                PASS <= '0';
                AD <= '0';
                SH <= '0';
            end case;
        end if;
    end process;
end architecture bhv;