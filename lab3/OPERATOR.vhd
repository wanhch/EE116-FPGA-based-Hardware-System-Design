library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity OPERATOR is
    port(OneDollar : in  STD_LOGIC;
         FiftyCents: in  STD_LOGIC;
         TenCents  : in  STD_LOGIC;
         FiveCents : in  STD_LOGIC;
         SET       : in  STD_LOGIC;
         SALE      : in  STD_LOGIC;
         CHANGE    : in  STD_LOGIC;
         STATE     : in  STD_LOGIC;
         Deliver   : out STD_LOGIC;
         RESULT    : out UNSIGNED(5 downto 0));
end entity OPERATOR;

architecture bhv of OPERATOR is
begin
    process(OneDollar, FiftyCents, TenCents, FiveCents, SET, SALE, CHANGE, STATE)
    variable price: UNSIGNED(5 downto 0);
    variable invested: UNSIGNED(5 downto 0);
    variable price_default: STD_LOGIC := '1';
    begin
        if (SET = '1') then
            if (STATE = '1') then
                price_default := '1';
                price := 25;
            elsif (STATE = '0') then
                if (OneDollar = '1') then
                    if (price_default = '1') then
                        price := 0;
                    end if;
                    price := price + 20;
                elsif (FiftyCents = '1') then
                    if (price_default = '1') then
                        price := 0;
                    end if;
                    price := price + 10;
                elsif (TenCents = '1') then
                    if (price_default = '1') then
                        price := 0;
                    end if;
                    price := price + 2;
                elsif (FiveCents = '1') then
                    if (price_default = '1') then
                        price := 0;
                    end if;
                    price := price + 1;
                end if;
            end if;
            RESULT <= price;
        elsif (SALE = '1') then
            if (STATE = '1') then
                Deliver := 0;
                invested := 0;
            elsif (STATE = '0') then
                if (OneDollar = '1') then
                    invested := invested + 20;
                elsif (FiftyCents = '1') then
                    invested := invested + 10;
                elsif (TenCents = '1') then
                    invested := invested + 2;
                elsif (FiveCents = '1') then
                    invested := invested + 1;
                end if;
                if (invested >= price) then
                    RESULT <= invested - price;
                    Deliver <= '1';
            end if;
            RESULT <= invested;
        elsif (CHANGE = '1') then
            RESULT <= invested - price;
        end if;
    end process;
end architecture bhv;