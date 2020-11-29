library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.util_package.ALL;

entity MixColumns is
    Port ( 
        clk   : in  STD_LOGIC;
        rst   : in  STD_LOGIC;
        input : in  TextBlock;
        output: out TextBlock := (others => (others => (others => '0'))));
end MixColumns;

architecture bhv of MixColumns is
    signal reg: TextBlock := (others => (others => (others => '0')));

begin
    output <= reg;
    process(clk, rst)
    variable temp: STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    begin
        if (rst = '1') then
            reg <= (others => (others => (others => '0')));
        elsif (rising_edge(clk)) then
            for row in 1 to 4 loop
                for col in 1 to 4 loop
                    temp := (others => '0');
                    for idx in 1 to 4 loop
                        temp := temp xor gmult(input(row)(idx), MixColumns_Table(col)(idx));
                    end loop;
                    reg(row)(col) <= temp;
                end loop;
            end loop;
        end if;
    end process;
end bhv;
