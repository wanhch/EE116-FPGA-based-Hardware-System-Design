library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity REG is
   port(CLK     : in  STD_LOGIC;
        Load    : in  STD_LOGIC;
        CLR     : in  STD_LOGIC;
        is_price: in  STD_LOGIC;
        Rin     : in  STD_LOGIC_VECTOR(6 downto 0);
        Rout    : out STD_LOGIC_VECTOR(6 downto 0));
end REG;

architecture bhv of REG is
signal Save: STD_LOGIC_VECTOR(6 downto 0) := (others => '0');
begin
   process(CLK)
   begin
      if rising_edge(CLK) then
         if (CLR = '1') then
            if (is_price = '1') then
               Save <= STD_LOGIC_VECTOR(TO_SIGNED(25, 7));
            else
               Save <= (others => '0');
            end if;
         elsif (Load = '1') then
            Save <= Rin;
         end if;
      end if;
   end process;
   Rout <= Save;
end bhv;
