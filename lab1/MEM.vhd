library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity MEM is
    port(addr: in  STD_LOGIC_VECTOR(3 downto 0);
         data: out STD_LOGIC_VECTOR(7 downto 0));
end entity MEM;

architecture bhv of MEM is
type vector_array IS ARRAY(0 to 15) of STD_LOGIC_VECTOR(7 downto 0);
constant memory: vector_array := ("00000000", "00000001", "00000011", "00000100",
                                  "00000101", "00000110", "00000111", "00001000",
                                  "00001001", "00001010", "00001011", "00001100",
                                  "00001101", "00001110", "00001111", "00010000"); 
begin
    process(addr)
    begin
        data <= memory(addr to addr);
    end process;
end architecture bhv;