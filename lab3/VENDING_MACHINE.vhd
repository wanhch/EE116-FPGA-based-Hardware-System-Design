library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity VENDING_MACHINE is
    port(Enable    : in  STD_LOGIC;
         RST       : in  STD_LOGIC;
         CLK       : in  STD_LOGIC;
         OneDollar : in  STD_LOGIC;
         FiftyCents: in  STD_LOGIC;
         TenCents  : in  STD_LOGIC;
         FiveCents : in  STD_LOGIC;
         Deliver   : out STD_LOGIC;
         Money     : out STD_LOGIC_VECTOR(5 downto 0));
end entity VENDING_MACHINE;

architecture bhv of VENDING_MACHINE is
    component CONTROL is
        port ();
    end component CONTROL;


    signal PASS: STD_LOGIC;
begin
    G1: CONTROL generic map(nq => nq, nm => nm)
                port map(Multiplier => Multiplier, START => Start, A_I => A_C, Q_I => Q_C, CLK => CLK, PASS => PASS, DONE => Done, PRODUCT => Product, A_O => A_A, Q_O => Q_S, RESET => RESET, SH => shift_flag, AD => add_flag);
end architecture bhv;