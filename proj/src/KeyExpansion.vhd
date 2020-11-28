library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.util_package.ALL;

entity KeyExpansion is
    Port ( 
        clk    : in  STD_LOGIC;
        rst    : in  STD_LOGIC;
        Key_in : in  STD_LOGIC_VECTOR(127 downto 0);
        rc     : in  STD_LOGIC_VECTOR(31 downto 0);
        Key_out: out STD_LOGIC_VECTOR(127 downto 0) := (others => '0'));
end KeyExpansion;

architecture bhv of KeyExpansion is    
begin
    process(clk, rst)
    variable temp: STD_LOGIC_VECTOR (127 downto 0) := (others => '0');
    variable ByteL: UNSIGNED(3 downto 0) := (others => '0');
    variable ByteH: UNSIGNED(3 downto 0) := (others => '0');
    begin
        if (rst = '1') then
            temp := (others => '0');
        elsif (rising_edge(clk)) then
            temp(23 downto 0) := Key_in(127 downto 104);
            temp(31 downto 24) := Key_in(103 downto 96);
            for col in 0 to 3 loop
                ByteL := UNSIGNED(temp(col*8 +3 downto col*8));
                ByteH := UNSIGNED(temp(col*8 +7 downto col*8 +4));
                temp(col*8 +7 downto col*8) := STD_LOGIC_VECTOR(SubBytes_Table(TO_INTEGER(ByteH))(TO_INTEGER(ByteL)));
            end loop;
            temp(31 downto 0) := temp(31 downto 0) xor STD_LOGIC_VECTOR(rc(31 downto 0));
            temp(31 downto 0) := temp(31 downto 0) xor Key_in(31 downto 0);
            for i in 1 to 3 loop
                temp((i+1)*32 -1 downto i*32) := temp(i*32 -1 downto (i-1)*32) xor Key_in((i+1)*32 -1 downto i*32);
            end loop;
        end if;
        Key_out <= temp;
    end process;
end bhv;
