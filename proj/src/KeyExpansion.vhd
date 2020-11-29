library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.util_package.ALL;

entity KeyExpansion is
    Port ( 
        clk    : in  STD_LOGIC;
        rst    : in  STD_LOGIC;
        Key_in : in  KeyBlock;
        rc     : in  STD_LOGIC_VECTOR(7 downto 0);
        Key_out: out KeyBlock := (others => (others => (others => '0'))));
end KeyExpansion;

architecture bhv of KeyExpansion is    
begin
    process(clk, rst)
    variable temp : KeyBlock := (others => (others => (others => '0')));
    variable ByteL: UNSIGNED(3 downto 0) := (others => '0');
    variable ByteH: UNSIGNED(3 downto 0) := (others => '0');
    begin
        if (rst = '1') then
            temp := (others => (others => (others => '0')));
        elsif (rising_edge(clk)) then
            temp(1)(1) := Key_in(4)(2);
            temp(1)(2) := Key_in(4)(3);
            temp(1)(3) := Key_in(4)(4);
            temp(1)(4) := Key_in(4)(1);
            for idx in 1 to 4 loop
                ByteL := UNSIGNED(temp(1)(idx)(3 downto 0));
                ByteH := UNSIGNED(temp(1)(idx)(7 downto 4));
                temp(1)(idx) := SubBytes_Table(TO_INTEGER(ByteH))(TO_INTEGER(ByteL));
            end loop;
            temp(1)(1) := temp(1)(1) xor rc;
            for idx in 1 to 4 loop
                temp(1)(idx) := temp(1)(idx) xor Key_in(1)(idx);
            end loop;
            for idx1 in 2 to 4 loop
                for idx2 in 1 to 4 loop
                    temp(idx1)(idx2) := temp(idx1 -1)(idx2) xor Key_in(idx1)(idx2);
                end loop;
            end loop;
        end if;
        Key_out <= temp;
    end process;
end bhv;
