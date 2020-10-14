library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity CONTROL is
    port(CLK       : in  STD_LOGIC;
         OneDollar : in  STD_LOGIC;
         FiftyCents: in  STD_LOGIC;
         TenCents  : in  STD_LOGIC;
         FiveCents : in  STD_LOGIC;
         DONE      : in  STD_LOGIC;
         Enable    : in  STD_LOGIC;
         RST       : in  STD_LOGIC;
         Money     : out STD_LOGIC_VECTOR(5 downto 0);
         Deliver   : out STD_LOGIC;);
end entity CONTROL;

architecture bhv of CONTROL is
begin
    process(CLK, RST, DONE, Enable)
    type StateType is (Set, Sale, Deliver);
    variable state        : StateType := Set;
    variable flag         : STD_LOGIC := '0';
    variable price_default: STD_LOGIC := '1';
    variable price        : UNSIGNED(5 downto 0);
    variable invested     : UNSIGNED(5 downto 0);
    variable change       : UNSIGNED(5 downto 0);
    begin
        if (RESET = '1') then
            price := 25;
            flag := '0';
            price_default := '1';
            Money <= TO_STD_LOGIC_VECTOR(price);
            state := Set;
        elsif (rising_edge(clk)) then
            case state is
            when Set => 
                if (Enable = '1') then
                    invested := 0;
                    flag := '0';
                    Money <= TO_STD_LOGIC_VECTOR(invested);
                    state := Sale; 
                elsif (flag = '0') then
                    if (OneDollar = '1') then
                        if (price_default = '1') then
                            price := 0;
                            price_default := '0';
                        end if;
                        flag = '1';
                        price := price + 20;
                    elsif (FiftyCents = '1') then
                        if (price_default = '1') then
                            price := 0;
                            price_default := '0';
                        end if;
                        flag = '1';
                        price := price + 10;
                    elsif (TenCents = '1') then
                        if (price_default = '1') then
                            price := 0;
                            price_default := '0';
                        end if;
                        flag = '1';
                        price := price + 2;
                    elsif (FiveCents = '1') then
                        if (price_default = '1') then
                            price := 0;
                            price_default := '0';
                        end if;
                        flag = '1';
                        price := price + 1;
                    end if;
                elsif (OneDollar = '0' and FiftyCents = '0' and TenCents = '0' and FiveCents = '0') then
                    flag = '0';
                end if;
                Money <= TO_STD_LOGIC_VECTOR(price);
            when Sale =>
                if (invested >= price) then
                    change := invested - price;
                    Deliver <= '1';
                    Money <= TO_STD_LOGIC_VECTOR(change);
                    state := Deliver;
                elsif (flag = '0') then
                    if (OneDollar = '1') then
                        flag = '1';
                        invested := invested + 20;
                    elsif (FiftyCents = '1') then
                        flag = '1';
                        invested := invested + 10;
                    elsif (TenCents = '1') then
                        flag = '1';
                        invested := invested + 2;
                    elsif (FiveCents = '1') then
                        flag = '1';
                        invested := invested + 1;
                    end if;
                elsif (OneDollar = '0' and FiftyCents = '0' and TenCents = '0' and FiveCents = '0') then
                    flag = '0';
                end if;
                Money <= TO_STD_LOGIC_VECTOR(invested);
            when Deliver =>
                if (DONE = '1') then
                    Deliver <= '0';
                    state := Set;
                end if;
            end case;
        end if;
    end process;
end architecture bhv;