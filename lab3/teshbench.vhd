library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

entity teshbench is
--  Port ( );
end teshbench;

architecture Behavioral of teshbench is
component VENDING_MACHINE is
    port(Enable    : in  STD_LOGIC;
         RST       : in  STD_LOGIC;
         CLK       : in  STD_LOGIC;
         OneDollar : in  STD_LOGIC;
         FiftyCents: in  STD_LOGIC;
         TenCents  : in  STD_LOGIC;
         FiveCents : in  STD_LOGIC;
         Deliver   : out STD_LOGIC;
         Money     : out STD_LOGIC_VECTOR(5 downto 0));
end component VENDING_MACHINE;

signal Enable    : STD_LOGIC;
signal RST       : STD_LOGIC;
signal CLK       : STD_LOGIC;
signal OneDollar : STD_LOGIC;
signal FiftyCents: STD_LOGIC;
signal TenCents  : STD_LOGIC;
signal FiveCents : STD_LOGIC;
begin
    uut: VENDING_MACHINE port map (
        Enable => Enable,
        RST => RST,
        CLK => CLK,
        OneDollar => OneDollar,
        FiftyCents => FiftyCents,
        TenCents => TenCents,
        FiveCents => FiveCents);

    process 
    begin
        RST <= '1';
        OneDollar <= '0';
        FiftyCents <= '0';
        TenCents <= '0';
        FiveCents <= '0';
        Enable <= '0';
        wait for 1 ms;
        RST <= '0';
        wait for 1 ms;
        OneDollar <= '1';
        wait for 1 ms;
        OneDollar <= '0';
        wait for 1 ms;
        FiftyCents <= '1';
        wait for 1 ms;
        FiftyCents <= '0';
        wait for 1 ms;
        TenCents <= '1';
        wait for 1 ms;
        TenCents <= '0';
        wait for 1 ms;
        FiveCents <= '1';
        wait for 1 ms;
        FiveCents <= '0';
        Enable <= '1';
        wait for 1 ms;
        Enable <= '0';
        wait for 1 ms;
        OneDollar <= '1';
        wait for 1 ms;
        OneDollar <= '0';
        wait for 1 ms;
        FiftyCents <= '1';
        wait for 1 ms;
        FiftyCents <= '0';
        wait for 1 ms;
        TenCents <= '1';
        wait for 1 ms;
        TenCents <= '0';
        wait for 1 ms;
        OneDollar <= '1';
        wait for 1 ms;
        OneDollar <= '0';
        wait for 6 ms;
    end process;

    process
    begin 
        loop
            CLK <= '0';
            wait for 5 ns;
            CLK <= '1';
            wait for 5 ns;
        end loop;
    end process;

end Behavioral;