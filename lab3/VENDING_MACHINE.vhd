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
   component FSM is
      port(CLK         : in  STD_LOGIC;
           DONE        : in  STD_LOGIC;
           Enable      : in  STD_LOGIC;
           RST         : in  STD_LOGIC;
           Delivered   : in  STD_LOGIC;
           cal_flag    : in  STD_LOGIC;
           default_flag: out STD_LOGIC;
           is_setting  : out STD_LOGIC;
           CLR_price   : out STD_LOGIC;
           CLR_invested: out STD_LOGIC);
   end component FSM;
   component GENERATOR is
      port(OneDollar   : in  STD_LOGIC;
           FiftyCents  : in  STD_LOGIC;
           TenCents    : in  STD_LOGIC;
           FiveCents   : in  STD_LOGIC;
           default_flag: in  STD_LOGIC;
           cal_flag    : out STD_LOGIC;
           A           : out STD_LOGIC_VECTOR(6 downto 0));
   end component GENERATOR;
   component DEBOUNCER is
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
   end component DEBOUNCER;
   component TIMER is
      port(CLK   : in  STD_LOGIC;
           TIMER0: in  STD_LOGIC;
           TIMER1: in  STD_LOGIC;
           RST   : in  STD_LOGIC;
           FLAG0 : out STD_LOGIC;
           FLAG1 : out STD_LOGIC);
   end component TIMER;
   component INTERACTOR is
      port(price     : in  STD_LOGIC_VECTOR(6 downto 0);
           invested  : in  STD_LOGIC_VECTOR(6 downto 0);
           change    : in  STD_LOGIC_VECTOR(6 downto 0);
           is_setting: in  STD_LOGIC;
           Money     : out STD_LOGIC_VECTOR(5 downto 0);
           Deliver   : out STD_LOGIC);
   end component INTERACTOR;
   component ADR is
      port(A : in  STD_LOGIC_VECTOR (6 downto 0);
           B : in  STD_LOGIC_VECTOR (6 downto 0);
           Q : out STD_LOGIC_VECTOR (6 downto 0));
   end component;
   component SUB is
      port(A : in  STD_LOGIC_VECTOR (6 downto 0);
           B : in  STD_LOGIC_VECTOR (6 downto 0);
           Q : out STD_LOGIC_VECTOR (6 downto 0));
   end component;
   component REG is
      port(CLK     : in  STD_LOGIC;
           Load    : in  STD_LOGIC;
           CLR     : in  STD_LOGIC;
           is_price: in  STD_LOGIC;
           Rin     : in  STD_LOGIC_VECTOR(6 downto 0);
           Rout    : out STD_LOGIC_VECTOR(6 downto 0));
   end component REG;
   signal Deliver_sig   : STD_LOGIC;
   signal OneDollar_sig : STD_LOGIC;
   signal FiftyCents_sig: STD_LOGIC;
   signal TenCents_sig  : STD_LOGIC;
   signal FiveCents_sig : STD_LOGIC;
   signal TIMER0        : STD_LOGIC;
   signal FLAG0         : STD_LOGIC;
   signal FLAG1         : STD_LOGIC;
   signal price_sig     : STD_LOGIC_VECTOR(6 downto 0);
   signal invested_sig  : STD_LOGIC_VECTOR(6 downto 0);
   signal change_sig    : STD_LOGIC_VECTOR(6 downto 0);
   signal price_tmp     : STD_LOGIC_VECTOR(6 downto 0);
   signal invested_tmp  : STD_LOGIC_VECTOR(6 downto 0);
   signal is_setting    : STD_LOGIC;
   signal isnot_setting : STD_LOGIC;
   signal CLR_price     : STD_LOGIC;
   signal CLR_invested  : STD_LOGIC;
   signal A             : STD_LOGIC_VECTOR(6 downto 0);
   signal cal_flag      : STD_LOGIC;
   signal default_flag  : STD_LOGIC;
begin
   Deliver <= Deliver_sig;
   isnot_setting <= not(is_setting);
   U1: FSM port map (
      CLK          => CLK,
      DONE         => FLAG1,
      Enable       => Enable,
      RST          => RST,
      Delivered    => Deliver_sig,
      cal_flag     => cal_flag,
      default_flag => default_flag,
      is_setting   => is_setting,
      CLR_price    => CLR_price,
      CLR_invested => CLR_invested);
   U2: GENERATOR port map (
      OneDollar    => OneDollar_sig,
      FiftyCents   => FiftyCents_sig,
      TenCents     => TenCents_sig,
      FiveCents    => FiveCents_sig,
      default_flag => default_flag,
      cal_flag     => cal_flag,
      A            => A);
   AP: ADR port map (
      A => A,
      B => price_sig,
      Q => price_tmp);
   AI: ADR port map (
      A => A,
      B => invested_sig,
      Q => invested_tmp);
   RP: REG port map (
      CLK      => CLK,
      Load     => is_setting,
      CLR      => CLR_price,
      is_price => '1',
      Rin      => price_tmp,
      Rout     => price_sig);
   RI: REG port map (
      CLK      => CLK,
      Load     => isnot_setting,
      CLR      => CLR_invested,
      is_price => '0',
      Rin      => invested_tmp,
      Rout     => invested_sig);
   U3: DEBOUNCER port map (
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
   U4: TIMER port map (
      CLK    => CLK,
      TIMER0 => TIMER0,
      TIMER1 => Deliver_sig,
      RST    => RST,
      FLAG0  => FLAG0,
      FLAG1  => FLAG1);
   SU: SUB port map (
      A => invested_sig,
      B => price_sig,
      Q => change_sig);
   U5: INTERACTOR port map (
      price      => price_sig,
      invested   => invested_sig,
      change     => change_sig,
      is_setting => is_setting,
      Money      => Money,
      Deliver    => Deliver_sig);
end architecture bhv;