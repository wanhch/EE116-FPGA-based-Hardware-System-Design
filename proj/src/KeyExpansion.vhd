library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity KeyExpansion is
    Generic ( 
        LENGTH : POSITIVE := 128);
    Port ( 
        clk    : in  STD_LOGIC;
        rst    : in  STD_LOGIC;
        Key_in : in  STD_LOGIC_VECTOR(LENGTH-1 downto 0);
        Key_out: out STD_LOGIC_VECTOR(LENGTH-1 downto 0) := (others => '0'));
end KeyExpansion;

architecture bhv of KeyExpansion is
signal reg: STD_LOGIC_VECTOR (LENGTH-1 downto 0) := (others => '0');
begin
    Key_out <= reg;
    process(clk, rst)
    begin
        if (rst = '1') then
            reg <= (others => '0');
        elsif (rising_edge(clk)) then
            
        end if;
    end process;
end bhv;
