library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

entity teshbench is
--  Port ( );
end teshbench;

architecture Behavioral of teshbench is
component LED_DRIVER is
--    generic(addrwidth: INTEGER := 4);
    port(CLK_50: in  STD_LOGIC;
         DATA_in  : in  unsigned(3 downto 0);
         CE    : in  STD_LOGIC;
         LOAD  : in  STD_LOGIC;
         UPDN  : in  STD_LOGIC;
         RST   : in  STD_LOGIC;
         LED   : out unsigned(7 downto 0));
end component LED_DRIVER;
signal clk: STD_LOGIC := '0';
signal data: unsigned(3 downto 0) := ("0001");
signal ce: STD_LOGIC := '1';
signal load: STD_LOGIC := '0';
signal updn: STD_LOGIC := '0';
signal rst: STD_LOGIC := '1';

begin
    uut: LED_DRIVER port map (
        CLK_50 => clk,
        DATA_in => data,
        CE => ce,
        LOAD => load,
        UPDN => updn,
        RST => rst
        );

    process 
    begin
        rst <= '0';
        load <= '1';
        wait for 60ns;
        load <= '0';
        wait;
    end process;

    process
    begin clock : loop
        clk <= '0';
        wait for 1ns;
        clk <= '1';
        wait for 1ns;
    end loop clock;
    end process;

end Behavioral;