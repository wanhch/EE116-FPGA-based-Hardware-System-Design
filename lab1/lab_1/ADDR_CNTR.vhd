library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity ADDR_CNTR is
    generic (addrwidth: integer := 8);
    port(DATA: in std_logic_vector(addrwidth-1 downto 0);
         CE  : in std_logic;
         LOAD: in std_logic;
         UPDN: in std_logic;
         clk : in std_logic;
         RST : in std_logic;
         Q   : out std_logic_vector(addrwidth-1 downto 0));    
end entity ADDR_CNTR;

architecture bhv of ADDR_CNTR is
begin
    
end architecture bhv;