library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

entity teshbench is
--  Port ( );
end teshbench;

architecture Behavioral of teshbench is
component MUL is
    generic(nq: INTEGER;
            nm: INTEGER);
    port(Multiplicant: in  STD_LOGIC_VECTOR(nm-1 downto 0);
         Multiplier  : in  STD_LOGIC_VECTOR(nq-1 downto 0);
         Start       : in  STD_LOGIC;
         CLK         : in  STD_LOGIC;
         Done        : out STD_LOGIC;
         Product     : out STD_LOGIC_VECTOR(nm+nq-1 downto 0));
end component MUL;

signal clk: STD_LOGIC := '0';


begin
    uut: MUL port map (
        );

    process 
    begin
    end process;

    process
    begin 
        loop
            clk <= '0';
            wait for 1ns;
            clk <= '1';
            wait for 1ns;
        end loop;
    end process;

end Behavioral;