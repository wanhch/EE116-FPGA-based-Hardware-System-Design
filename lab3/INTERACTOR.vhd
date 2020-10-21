library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity INTERACTOR is
   port(price     : in  STD_LOGIC_VECTOR(6 downto 0);
        invested  : in  STD_LOGIC_VECTOR(6 downto 0);
        change    : in  STD_LOGIC_VECTOR(6 downto 0);
        is_setting: in  STD_LOGIC;
        Money     : out STD_LOGIC_VECTOR(5 downto 0);
        Deliver   : out STD_LOGIC);
end entity INTERACTOR;

architecture bhv of INTERACTOR is
begin
   process(is_setting, price, invested, change)
   variable price_default: STD_LOGIC := '1';
   begin
      Deliver <= '0';
      if (is_setting = '1') then
         Money <= price(5 downto 0);
      elsif (SIGNED(change) > 0) then
         Deliver <= '1';
         Money <= change(5 downto 0);
      else
         Money <= invested(5 downto 0);
      end if;
   end process;
end architecture bhv;