library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.util_package.ALL;

entity SubBytes is
    Port ( 
        clk    : in  STD_LOGIC;
        rst    : in  STD_LOGIC;
        mode   : in  STD_LOGIC; -- '0': encryption, '1': decryption
        input  : in  STD_LOGIC_VECTOR(127 downto 0);
        output : out STD_LOGIC_VECTOR(127 downto 0) := (others => '0'));
end SubBytes;

architecture bhv of SubBytes is

    signal reg: STD_LOGIC_VECTOR(127 downto 0) := (others => '0');
begin
    output <= reg;
    process(clk, rst)
    variable ByteL: UNSIGNED(3 downto 0) := (others => '0');
    variable ByteH: UNSIGNED(3 downto 0) := (others => '0');
    begin
        if (rst = '1') then
            reg <= (others => '0');
        elsif (rising_edge(clk)) then
            if (mode = '0') then
                for row in 0 to 3 loop
                    for col in 0 to 3 loop
                        ByteL := UNSIGNED(input((row*4 + col)*8 +3 downto (row*4 + col)*8));
                        ByteH := UNSIGNED(input((row*4 + col)*8 +7 downto (row*4 + col)*8 +4));
                        reg((row*4 + col)*8 +7 downto (row*4 + col)*8) <= STD_LOGIC_VECTOR(SubBytes_Table(TO_INTEGER(ByteH))(TO_INTEGER(ByteL)));
                    end loop;
                end loop;
            elsif (mode = '1') then
                for row in 0 to 3 loop
                    for col in 0 to 3 loop
                        ByteL := UNSIGNED(input((row*4 + col)*4 +3 downto (row*4 + col)*4));
                        ByteH := UNSIGNED(input((row*4 + col)*4 +7 downto (row*4 + col)*4 +4));
                        reg((row*4 + col)*8 +7 downto (row*4 + col)*8) <= STD_LOGIC_VECTOR(invSubBytes_Table(TO_INTEGER(ByteH))(TO_INTEGER(ByteL)));
                    end loop;
                end loop;
            else 
                reg <= (others => '0');
            end if;
        end if;
    end process;
end bhv;
