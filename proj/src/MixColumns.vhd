library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MixColumns is
    Port ( 
        clk : in  STD_LOGIC;
        rst : in  STD_LOGIC;
        mode: in  STD_LOGIC; -- '0': encryption, '1': decryption
        in  : in  STD_LOGIC_VECTOR(127 downto 0);
        out : out STD_LOGIC_VECTOR(127 downto 0) := (others => '0'));
end MixColumns;

architecture bhv of MixColumns is
    type TransLine is array(0 to 3) of UNSIGNED(7 downto 0);
    type TransMatrix is array(0 to 3) of TransLine;
    constant trans: TransMatrix := (
        (16#02#, 16#01#, 16#01#, 16#03#),
        (16#03#, 16#02#, 16#01#, 16#01#),
        (16#01#, 16#03#, 16#02#, 16#01#),
        (16#01#, 16#01#, 16#03#, 16#02#));
    constant invtrans: TransMatrix := (
        (16#0e#, 16#09#, 16#0d#, 16#0b#),
        (16#0b#, 16#0e#, 16#09#, 16#0d#),
        (16#0d#, 16#0b#, 16#0e#, 16#09#),
        (16#09#, 16#0d#, 16#0b#, 16#0e#));

    signal reg: STD_LOGIC_VECTOR(127 downto 0) := (others => '0');

function gmult(a: STD_LOGIC_VECTOR(7 downto 0); b: STD_LOGIC_VECTOR(7 downto 0)) return STD_LOGIC_VECTOR is
    variable p: STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    variable hbs: STD_LOGIC := '0';
begin
    for idx in 0 to 7 loop
        if (b(0) = '1') then
            p = p xor a;
        end if;
        hbs = a(7);
        a(7 downto 0) = a(6 downto 0) & '0';
        if (hbs = '1') then 
            a = a xor 16#1b#;
        end if;
        b = '0' & b(7 downto 1);
    end loop;
end function;

begin
    out <= reg;
    process(clk, rst)
    variable temp: UNSIGNED(7 downto 0) := (others => '0');
    begin
        if (rst = '1') then
            reg <= (others => '0');
        elsif (rising_edge(clk)) then
            if (mode = '0') then
                for row in 0 to 3 loop
                    for col in 0 to 3 loop
                        temp := (others => '0');
                        for idx in 0 to 3 loop
                            temp := temp xor gmult(in((row*4 + idx)*8 +7 downto (row*4 + idx)*8), TO_STD_LOGIC_VECTOR(trans(col)(idx)));
                        end loop;
                        reg((row*4 + col)*8 +7 downto (row*4 + col)*8) <= temp(7 downto 0);
                    end loop;
                end loop;
            elsif (mode = '1') then
                for row in 0 to 3 loop
                    for col in 0 to 3 loop
                        temp := (others => '0');
                        for idx in 0 to 3 loop
                            temp := temp xor gmult(in((row*4 + idx)*8 +7 downto (row*4 + idx)*8), TO_STD_LOGIC_VECTOR(invtrans(col)(idx)));
                        end loop;
                        reg((row*4 + col)*8 +7 downto (row*4 + col)*8) <= temp(7 downto 0);
                    end loop;
                end loop;
            else
                reg <= (others => '0');
            end if;
        end if;
    end process;
end bhv;
