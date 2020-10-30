library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Use the libraries you need

entity pipe is
    Generic(
        DATA_WIDTH : POSITIVE := 8;
        LENGTH : POSITIVE := 10);  
    Port( 
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        D : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
        Q : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0) := (others => '0'));
end pipe;

architecture Behavioral of pipe is
-- Add your own code here
begin
-- Add your own code here
end Behavioral;