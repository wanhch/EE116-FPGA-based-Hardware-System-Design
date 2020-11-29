library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.util_package.ALL;

entity AddRoundKey is
    Port ( 
        clk   : in  STD_LOGIC;
        rst   : in  STD_LOGIC;
        key   : in  KeyBlock;
        input : in  TextBlock;
        output: out TextBlock := (others => (others => (others => '0'))));
end AddRoundKey;

architecture bhv of AddRoundKey is
    signal reg: TextBlock := (others => (others => (others => '0')));
begin
    output <= reg;
    process(clk, rst)
    begin
        if (rst = '1') then
            reg <= (others => (others => (others => '0')));
        elsif (rising_edge(clk)) then
            for row in 1 to 4 loop
                for col in 1 to 4 loop
                    reg(row)(col) <= input(row)(col) xor key(row)(col);
                end loop;
            end loop;
        end if;
    end process;
end bhv;