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
    signal OneDollar_sig : STD_LOGIC;
    signal FiftyCents_sig: STD_LOGIC;
    signal TenCents_sig  : STD_LOGIC;
    signal FiveCents_sig : STD_LOGIC;
    signal TIMER0        : STD_LOGIC;
    signal TIMER1        : STD_LOGIC;
    signal FLAG0         : STD_LOGIC;
    signal FLAG1         : STD_LOGIC;
begin
    U1: CONTROL port map (
        CLK        => CLK,
        OneDollar  => OneDollar_sig,
        FiftyCents => FiftyCents_sig,
        TenCents   => TenCents_sig,
        FiveCents  => FiveCents_sig,
        DONE       => FLAG1,
        Enable     => Enable,
        RST        => RST,
        Money      => Money,
        Deliver    => Deliver);
    U2: ACCOUNTANT port map (
        OneDollar_I  => OneDollar,
        FiftyCents_I => FiftyCents,
        TenCents_I   => TenCents,
        FiveCents_I  => FiveCents,
        FLAG         => FLAG0,
        RST          => RST,
        OneDollar_O  => OneDollar_sig,
        FiftyCents_O => FiftyCents_sig,
        TenCents_O   => TenCents_sig,
        FiveCents_O  => FiveCents_sig,
        TIMER0       => TIMER0);
    U3: TIMER port map (
        CLK    => CLK,
        TIMER0 => TIMER0,
        TIMER1 => TIMER1,
        RST    => RST,
        FLAG0  => FLAG0,
        FLAG1  => FLAG1);
end architecture bhv;