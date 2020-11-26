library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ShiftRows is 
    Port ( 
        clk : in  STD_LOGIC;
        rst : in  STD_LOGIC;
        mode: in  STD_LOGIC; -- '0': encryption, '1': decryption
        in  : in  STD_LOGIC_VECTOR(127 downto 0);
        out : out STD_LOGIC_VECTOR(127 downto 0));
end ShiftRows;

architecture bhv of ShiftRows is
signal reg: STD_LOGIC_VECTOR(127 downto 0) := (others => '0');
begin
    out <= reg;
    process(clk, rst)
    begin
        if (rst = '1') then
            reg <= (others => '0');
        elsif (rising_edge(clk)) then
            if (mode = '0') then

            elsif (mode = '1') then

            else 
                reg <= (others => '0');
            end if;
        end if;
    end process;
end bhv;