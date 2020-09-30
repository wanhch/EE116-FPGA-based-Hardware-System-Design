library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity MEM is
    generic (addrwidth: INTEGER := 4);
    port(addr: in  unsigned(addrwidth-1 downto 0);
         data: out unsigned(7 downto 0));
end entity MEM;

architecture bhv of MEM is
type vector_array IS ARRAY(0 to 15) of unsigned(7 downto 0);
constant memory: vector_array := ("00000000", "00000001", "00000011", "00000100",
                                  "00000101", "00000110", "00000111", "00001000",
                                  "00001001", "00001010", "00001011", "00001100",
                                  "10001101", "01001110", "00101111", "00010000"); 
begin
    process(addr)
    begin
        data <= memory(TO_INTEGER(addr));
    end process;
end architecture bhv;