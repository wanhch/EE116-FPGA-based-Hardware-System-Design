library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
 
entity CONTROL is
    generic (nq: INTEGER RANGE 1 TO 15;
             nm: INTEGER RANGE 1 TO 15);
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
   --type StateType is (init, add, shift, halt, judge);
    variable state: INTEGER RANGE 0 TO 4 := 0;
    variable count: INTEGER RANGE 0 TO 1000;
    begin
        if (START = '1') then
            DONE <= '0';
            RESET <= '1';
            A_O <= TO_UNSIGNED(0, nm+1);
            Q_O <= UNSIGNED(Multiplier);
            state := 0;
        elsif (rising_edge(clk)) then
            case state is
            when 0 => 
                DONE <= '0';
                count := 0;
                RESET <= '0';
                if (nq >= 1) then
                    if (Multiplier(0) = '1') then
                        state := 1;
                    elsif (Multiplier(0) = '0') then
                        state := 2;
                    end if;
                end if;
            when 4 =>
                AD <= '0';
                SH <= '0';
                A_O <= A_I;
                Q_O <= Q_I;
                if (nq >= 1) then
                    if (count = nq) then
                        state := 3;
                    elsif (Q_I(0) = '1') then
                        PASS <= '0';
                        state := 1;
                    elsif (Q_I(0) = '0') then
                        PASS <= '1';
                        state := 2;
                    end if;
                end if;
            when 1 =>
                AD <= '1';
                SH <= '0';
                state := 2;
            when 2 =>
                AD <= '0';
                SH <= '1';
                if (count >= 2147483640) then
                    count := 0;
                else
                    count := count + 1;
                end if;
                state:= 4;
            when 3 =>
                if (nm >= 1) then
                    PRODUCT <= STD_LOGIC_VECTOR(A_I(nm-1 downto 0) & Q_I);
                end if;
                DONE <= '1';
                PASS <= '0';
                AD <= '0';
                SH <= '0';
            end case;
        end if;
    end process;
end architecture bhv;