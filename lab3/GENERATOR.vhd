library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity GENERATOR is
   port(OneDollar   : in  STD_LOGIC;
        FiftyCents  : in  STD_LOGIC;
        TenCents    : in  STD_LOGIC;
        FiveCents   : in  STD_LOGIC;
        default_flag: in  STD_LOGIC;
        cal_flag    : out STD_LOGIC;
        A           : out STD_LOGIC_VECTOR(6 downto 0));
end GENERATOR;

architecture bhv of GENERATOR is
begin
   process(OneDollar, FiftyCents, TenCents, FiveCents)
   begin
      cal_flag <= '0';
      A <= (others => '0');
      if (OneDollar = '1') then
         cal_flag <= '1';
         if (default_flag = '1') then
            A <= STD_LOGIC_VECTOR(TO_SIGNED(-5, 7));
         else 
            A <= STD_LOGIC_VECTOR(TO_SIGNED(20, 7));
         end if;
      elsif (FiftyCents = '1') then
         cal_flag <= '1';
         if (default_flag = '1') then
            A <= STD_LOGIC_VECTOR(TO_SIGNED(-15 ,7));
         else 
            A <= STD_LOGIC_VECTOR(TO_SIGNED(10, 7));
         end if;
      elsif (TenCents = '1') then
         cal_flag <= '1';
         if (default_flag = '1') then
            A <= STD_LOGIC_VECTOR(TO_SIGNED(-23, 7));
         else 
            A <= STD_LOGIC_VECTOR(TO_SIGNED(2, 7));
         end if;
      elsif (FiveCents = '1') then
         cal_flag <= '1';
         if (default_flag = '1') then
            A <= STD_LOGIC_VECTOR(TO_SIGNED(-24, 7));
         else
            A <= STD_LOGIC_VECTOR(TO_SIGNED(1, 7));
         end if;
      end if;
   end process;
end bhv;
