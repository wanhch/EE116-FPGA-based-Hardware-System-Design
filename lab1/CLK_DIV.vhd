library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity CLK_DIV is
    port (clk    : in  STD_LOGIC;
          clk_out: out STD_LOGIC);
end entity CLK_DIV;

architecture bhv of CLK_DIV is
signal count: INTEGER := 1;
signal flag: STD_LOGIC := '0';
begin
    process(clk)
    begin
        if (rising_edge(clk)) then
            if (count = 25000000) then
                count <= 1;
                flag <= NOT flag;
            else
                count <= count + 1;
            end if;
        end if;
        clk_out <= flag;
    end process;
end architecture bhv;