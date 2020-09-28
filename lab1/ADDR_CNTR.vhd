library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity ADDR_CNTR is
    generic (addrwidth: INTEGER := 4);
    port(DATA: in  unsigned(addrwidth-1 downto 0);
         CE  : in  STD_LOGIC;
         LOAD: in  STD_LOGIC;
         UPDN: in  STD_LOGIC;
         clk : in  STD_LOGIC;
         RST : in  STD_LOGIC;
         Q   : out unsigned(addrwidth-1 downto 0));    
end entity ADDR_CNTR;

architecture bhv of ADDR_CNTR is
    signal count: unsigned(addrwidth-1 downto 0);
begin
    process(clk)
    begin
        if (rising_edge(clk) and RST = '0') then
            if (LOAD = '1') then
                count <= DATA;
            elsif (CE = '1') then
                if (UPDN = '1') then
                    count <= count + 1;
                elsif (UPDN = '0') then
                    count <= count - 1;
                end if;
            end if;
        end if;
    end process;
    
    process(count)
    begin
        Q <= count;
    end process;
end architecture bhv;