library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.util_package.ALL;

entity AddRoundKey is
    Port ( 
        clk   : in  STD_LOGIC;
        rst   : in  STD_LOGIC;
        key   : in  STD_LOGIC_VECTOR(127 downto 0);
        input : in  STD_LOGIC_VECTOR(127 downto 0);
        output: out STD_LOGIC_VECTOR(127 downto 0) := (others => '0'));
end AddRoundKey;

architecture bhv of AddRoundKey is
    signal reg: STD_LOGIC_VECTOR(127 downto 0) := (others => '0');
begin
    output <= reg;
    process(clk, rst)
    begin
        if (rst = '1') then
            reg <= (others => '0');
        elsif (rising_edge(clk)) then
            for row in 0 to 3 loop
                for col in 0 to 3 loop
                    reg((row*4 + col)*8 +7 downto (row*4 + col)*8) <= input((row*4 + col)*8 +7 downto (row*4 + col)*8) xor key((col*4 + row)*8 +7 downto (col*4 + row)*8);
                end loop;
            end loop;
        end if;
    end process;
end bhv;