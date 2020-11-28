library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.util_package.ALL;

entity MixColumns is
    Port ( 
        clk    : in  STD_LOGIC;
        rst    : in  STD_LOGIC;
        mode   : in  STD_LOGIC; -- '0': encryption, '1': decryption
        input  : in  STD_LOGIC_VECTOR(127 downto 0);
        output : out STD_LOGIC_VECTOR(127 downto 0) := (others => '0'));
end MixColumns;

architecture bhv of MixColumns is
    signal reg: STD_LOGIC_VECTOR(127 downto 0) := (others => '0');

begin
    output <= reg;
    process(clk, rst)
    variable temp: STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    begin
        if (rst = '1') then
            reg <= (others => '0');
        elsif (rising_edge(clk)) then
            if (mode = '0') then
                for row in 0 to 3 loop
                    for col in 0 to 3 loop
                        temp := (others => '0');
                        for idx in 0 to 3 loop
                            temp := temp xor gmult(input((row*4 + idx)*8 +7 downto (row*4 + idx)*8), STD_LOGIC_VECTOR(SubBytes_Table(col)(idx)));
                        end loop;
                        reg((row*4 + col)*8 +7 downto (row*4 + col)*8) <= temp(7 downto 0);
                    end loop;
                end loop;
            elsif (mode = '1') then
                for row in 0 to 3 loop
                    for col in 0 to 3 loop
                        temp := (others => '0');
                        for idx in 0 to 3 loop
                            temp := temp xor gmult(input((row*4 + idx)*8 +7 downto (row*4 + idx)*8), STD_LOGIC_VECTOR(invSubBytes_Table(col)(idx)));
                        end loop;
                        reg((row*4 + col)*8 +7 downto (row*4 + col)*8) <= temp(7 downto 0);
                    end loop;
                end loop;
            else
                reg <= (others => '0');
            end if;
        end if;
    end process;
end bhv;
