library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity ADDR_CNTR is
    generic (addrwidth: INTEGER := 4);
    port(DATA: in  STD_LOGIC_VECTOR(addrwidth-1 downto 0);
         CE  : in  STD_LOGIC;
         LOAD: in  STD_LOGIC;
         UPDN: in  STD_LOGIC;
         clk : in  STD_LOGIC;
         RST : in  STD_LOGIC;
         Q   : out STD_LOGIC_VECTOR(addrwidth-1 downto 0));    
end entity ADDR_CNTR;

architecture bhv of ADDR_CNTR is
begin
    process(clk, CE, LOAD, UPDN, RST, DATA)
    begin
        if (rising_edge(clk) and RST = '0') then
            if (LOAD = '1') then
                Q <= DATA;
            elsif (CE = '1') then
                if (UPDN = '1') then
                    Q <= Q + 1;
                elsif (UPDN = '0') then
                    Q <= Q - 1;
                end if;
            end if;
        end if;
    end process;
end architecture bhv;