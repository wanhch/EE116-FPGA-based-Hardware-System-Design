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
        port(CLK       : in  STD_LOGIC;
             OneDollar : in  STD_LOGIC;
             FiftyCents: in  STD_LOGIC;
             TenCents  : in  STD_LOGIC;
             FiveCents : in  STD_LOGIC;
             DONE      : in  STD_LOGIC;
             Enable    : in  STD_LOGIC;
             RST       : in  STD_LOGIC;
             Money     : out STD_LOGIC_VECTOR(5 downto 0);
             Deliver   : out STD_LOGIC);
    end component CONTROL;
    component ACCOUNTANT is
        port(OneDollar_I : in  STD_LOGIC;
             FiftyCents_I: in  STD_LOGIC;
             TenCents_I  : in  STD_LOGIC;
             FiveCents_I : in  STD_LOGIC;
             FLAG        : in  STD_LOGIC;
             RST         : in  STD_LOGIC;
             OneDollar_O : out STD_LOGIC;
             FiftyCents_O: out STD_LOGIC;
             TenCents_O  : out STD_LOGIC;
             FiveCents_O : out STD_LOGIC;
             TIMER0      : out STD_LOGIC);
    end component ACCOUNTANT;
    component TIMER is
        port(CLK   : in  STD_LOGIC;
             TIMER0: in  STD_LOGIC;
             TIMER1: in  STD_LOGIC;
             RST   : in  STD_LOGIC;
             FLAG0 : out STD_LOGIC;
             FLAG1 : out STD_LOGIC);
    end component TIMER;

    signal PASS: STD_LOGIC;
begin
    G1: CONTROL generic map(nq => nq, nm => nm)
                port map(Multiplier => Multiplier, START => Start, A_I => A_C, Q_I => Q_C, CLK => CLK, PASS => PASS, DONE => Done, PRODUCT => Product, A_O => A_A, Q_O => Q_S, RESET => RESET, SH => shift_flag, AD => add_flag);
end architecture bhv;