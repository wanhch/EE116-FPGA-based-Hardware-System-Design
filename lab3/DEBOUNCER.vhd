library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity DEBOUNCER is
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
end entity DEBOUNCER;

architecture bhv of DEBOUNCER is
begin
   process(OneDollar_I, FiftyCents_I, TenCents_I, FiveCents_I, FLAG, RST)
   variable count : INTEGER;
   begin
      if (RST = '1') then
         OneDollar_O  <= '0';
         FiftyCents_O <= '0';
         TenCents_O   <= '0';
         FiveCents_O  <= '0';
         TIMER0       <= '0';
      else 
         TIMER0 <= '0';
         if (OneDollar_I = '1') then 
            TIMER0 <= '1';
            if (FLAG = '1') then
               OneDollar_O  <= '1';
            else
               OneDollar_O  <= '0';
            end if;
         else 
            OneDollar_O <= '0';
         end if;

         if (FiftyCents_I = '1') then 
            TIMER0 <= '1';
            if (FLAG = '1') then
               FiftyCents_O <= '1';
            else
               FiftyCents_O <= '0';
            end if;
         else
            FiftyCents_O <= '0';
         end if;

         if (TenCents_I = '1') then 
            TIMER0 <= '1';
            if (FLAG = '1') then
               TenCents_O   <= '1';
            else 
               TenCents_O   <= '0';
            end if;
         else
            TenCents_O <= '0';
         end if;

         if (FiveCents_I = '1') then 
            TIMER0 <= '1';
            if (FLAG = '1') then
               FiveCents_O  <= '1';
            else
               FiveCents_O  <= '0';
            end if;
         else
            FiveCents_O <= '0';
         end if;
      end if;
   end process;
end architecture bhv;