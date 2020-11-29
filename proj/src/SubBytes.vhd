library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.util_package.ALL;

entity SubBytes is
    Port ( 
        clk   : in  STD_LOGIC;
        rst   : in  STD_LOGIC;
        mode  : in  STD_LOGIC; -- '0': encryption, '1': decryption
        input : in  TextBlock;
        output: out TextBlock := (others => (others => (others => '0'))));
end SubBytes;

architecture bhv of SubBytes is

    signal reg: TextBlock := (others => (others => (others => '0')));
begin
    output <= reg;
    process(clk, rst)
    variable ByteL: UNSIGNED(3 downto 0) := (others => '0');
    variable ByteH: UNSIGNED(3 downto 0) := (others => '0');
    begin
        if (rst = '1') then
            reg <= (others => (others => (others => '0')));
        elsif (rising_edge(clk)) then
            if (mode = '0') then
                for row in 1 to 4 loop
                    for col in 1 to 4 loop
                        ByteL := UNSIGNED(input(row)(col)(3 downto 0));
                        ByteH := UNSIGNED(input(row)(col)(7 downto 4));
                        reg(row)(col) <= SubBytes_Table(TO_INTEGER(ByteH))(TO_INTEGER(ByteL));
                    end loop;
                end loop;
            elsif (mode = '1') then
                for row in 1 to 4 loop
                    for col in 1 to 4 loop
                        ByteL := UNSIGNED(input(row)(col)(3 downto 0));
                        ByteH := UNSIGNED(input(row)(col)(7 downto 4));
                        reg(row)(col) <= invSubBytes_Table(TO_INTEGER(ByteH))(TO_INTEGER(ByteL));
                    end loop;
                end loop;
            else 
                reg <= (others => (others => (others => '0')));
            end if;
        end if;
    end process;
end bhv;
