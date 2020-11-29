library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.util_package.ALL;

entity ShiftRows is 
    Port ( 
        clk   : in  STD_LOGIC;
        rst   : in  STD_LOGIC;
        input : in  TextBlock;
        output: out TextBlock := (others => (others => (others => '0'))));
end ShiftRows;

architecture bhv of ShiftRows is
signal reg: TextBlock := (others => (others => (others => '0')));
begin
    output <= reg;
    process(clk, rst)
    begin
        if (rst = '1') then
            reg <= (others => (others => (others => '0')));
        elsif (rising_edge(clk)) then
            reg(1)(1) <= input(1)(1);
            reg(1)(2) <= input(2)(2);
            reg(1)(3) <= input(3)(3);
            reg(1)(4) <= input(4)(4);

            reg(2)(1) <= input(2)(1);
            reg(2)(2) <= input(3)(2);
            reg(2)(3) <= input(4)(3);
            reg(2)(4) <= input(1)(4);

            reg(3)(1) <= input(3)(1);
            reg(3)(2) <= input(4)(2);
            reg(3)(3) <= input(1)(3);
            reg(3)(4) <= input(2)(4);

            reg(4)(1) <= input(4)(1);
            reg(4)(2) <= input(1)(2);
            reg(4)(3) <= input(2)(3);
            reg(4)(4) <= input(3)(4);
        end if;
    end process;
end bhv;