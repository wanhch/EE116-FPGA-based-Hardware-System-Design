library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Use the libraries you need

library work;
use work.util_package.ALL;

entity pe is
    Generic ( 
        MAT_LENGTH : POSITIVE := 32;
        INPUT_WIDTH : POSITIVE := 8;
        OUTPUT_WIDTH : POSITIVE := 21);
    Port ( 
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        init : in STD_LOGIC;
        in_a : in STD_LOGIC_VECTOR (INPUT_WIDTH-1 downto 0);
        in_b : in STD_LOGIC_VECTOR (INPUT_WIDTH-1 downto 0);
        out_sum : out STD_LOGIC_VECTOR (OUTPUT_WIDTH-1 downto 0) := (others => '0');
        valid_sum : out STD_LOGIC := '0';
        out_a : out STD_LOGIC_VECTOR (INPUT_WIDTH-1 downto 0) := (others => '0');
        out_b : out STD_LOGIC_VECTOR (INPUT_WIDTH-1 downto 0) := (others => '0'));
end pe;

architecture Behavioral of pe is
-- Add your own code here
begin
-- Add your own code here
end Behavioral;
