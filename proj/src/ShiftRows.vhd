library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ShiftRows is 
    Port ( 
        clk : in  STD_LOGIC;
        rst : in  STD_LOGIC;
        mode: in  STD_LOGIC; -- '0': encryption, '1': decryption
        in  : in  STD_LOGIC_VECTOR(127 downto 0);
        out : out STD_LOGIC_VECTOR(127 downto 0));
end ShiftRows;

architecture bhv of ShiftRows is
signal reg: STD_LOGIC_VECTOR(127 downto 0) := (others => '0');
begin
    out <= reg;
    process(clk, rst)
    begin
        if (rst = '1') then
            reg <= (others => '0');
        elsif (rising_edge(clk)) then
            if (mode = '0') then
                reg(31 downto 0) <= in(31 downto 0 );
                reg(55 downto 32) <= in(63 downto 40);
                reg(63 downto 56) <= in(39 downto 32);
                reg(79 downto 64) <= in(95 downto 80);
                reg(95 downto 80) <= in(79 downto 64);
                reg(103 downto 96) <= in(127 downto 120);
                reg(127 downto 104) <= in(119 downto 96);
            elsif (mode = '1') then
                reg(31 downto 0 ) <= in(31 downto 0);
                reg(63 downto 40) <= in(55 downto 32);
                reg(39 downto 32) <= in(63 downto 56);
                reg(95 downto 80) <= in(79 downto 64);
                reg(79 downto 64) <= in(95 downto 80);
                reg(127 downto 120) <= in(103 downto 96);
                reg(119 downto 96) <= in(127 downto 104);
            else 
                reg <= (others => '0');
            end if;
        end if;
    end process;
end bhv;