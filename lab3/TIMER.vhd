library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity TIMER is
    port(CLK   : in  STD_LOGIC;
         TIMER0: in  STD_LOGIC;
         TIMER1: in  STD_LOGIC;
         RST   : in  STD_LOGIC;
         FLAG0 : out STD_LOGIC;
         FLAG1 : out STD_LOGIC);
end entity TIMER;

architecture bhv of TIMER is
begin
    process(CLK, RST, TIMER0, TIMER1)
    variable count : INTEGER;
    begin
        if (RST = '1') then
            count := 0;
            FLAG0 <= '0';
            FLAG1 <= '0';
        elsif (rising_edge(CLK)) then
            if (TIMER0 = '1') then
                count := count + 1;
                if (count >= 500000) then -- wait for 5 ms
                    FLAG0 <= '1';
                else 
                    FLAG0 <= '0';
                end if;
            elsif (TIMER1 = '1') then
                count := count + 1;
                if (count >= 500000000) then -- wait for 5 sec
                    FLAG1 <= '1';
                else 
                    FLAG1 <= '0';
                end if;
            else
                count := 0;
                FLAG0 <= '0';
                FLAG1 <= '0';
            end if;
        end if;
    end process;
end architecture bhv;