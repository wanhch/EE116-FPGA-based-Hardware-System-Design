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
         Deliver   : out STD_LOGIC);
end entity CONTROL;

architecture bhv of CONTROL is
begin
    process(CLK, RST, DONE, Enable)
    type StateType is (SetState, SaleState, DeliverState);
    variable state        : StateType := SetState;
    variable flag         : STD_LOGIC := '0';
    variable price_default: STD_LOGIC := '1';
    variable price        : UNSIGNED(5 downto 0);
    variable invested     : UNSIGNED(5 downto 0);
    variable change       : UNSIGNED(5 downto 0);
    begin
        if (RST = '1') then
            price := TO_UNSIGNED(25, 6);
            flag := '0';
            price_default := '1';
            Deliver <= '0';
            Money <= STD_LOGIC_VECTOR(price);
            state := SetState;
        elsif (rising_edge(clk)) then
            case state is
            when SetState => 
                if (Enable = '1') then
                    invested := TO_UNSIGNED(0, 6);
                    flag := '0';
                    Money <= STD_LOGIC_VECTOR(invested);
                    state := SaleState; 
                elsif (flag = '0') then
                    if (OneDollar = '1') then
                        if (price_default = '1') then
                            price := TO_UNSIGNED(0, 6);
                            price_default := '0';
                        end if;
                        flag := '1';
                        price := price + 20;
                    elsif (FiftyCents = '1') then
                        if (price_default = '1') then
                            price := TO_UNSIGNED(0, 6);
                            price_default := '0';
                        end if;
                        flag := '1';
                        price := price + 10;
                    elsif (TenCents = '1') then
                        if (price_default = '1') then
                            price := TO_UNSIGNED(0, 6);
                            price_default := '0';
                        end if;
                        flag := '1';
                        price := price + 2;
                    elsif (FiveCents = '1') then
                        if (price_default = '1') then
                            price := TO_UNSIGNED(0, 6);
                            price_default := '0';
                        end if;
                        flag := '1';
                        price := price + 1;
                    end if;
                elsif (OneDollar = '0' and FiftyCents = '0' and TenCents = '0' and FiveCents = '0') then
                    flag := '0';
                end if;
                Deliver <= '0';
                Money <= STD_LOGIC_VECTOR(price);
            when SaleState =>
                if (invested >= price) then
                    change := invested - price;
                    Deliver <= '1';
                    Money <= STD_LOGIC_VECTOR(change);
                    state := DeliverState;
                elsif (flag = '0') then
                    if (OneDollar = '1') then
                        flag := '1';
                        invested := invested + 20;
                    elsif (FiftyCents = '1') then
                        flag := '1';
                        invested := invested + 10;
                    elsif (TenCents = '1') then
                        flag := '1';
                        invested := invested + 2;
                    elsif (FiveCents = '1') then
                        flag := '1';
                        invested := invested + 1;
                    end if;
                    Money <= STD_LOGIC_VECTOR(invested);
                elsif (OneDollar = '0' and FiftyCents = '0' and TenCents = '0' and FiveCents = '0') then
                    flag := '0';
                end if;
            when DeliverState =>
                if (DONE = '1') then
                    Deliver <= '0';
                    state := SetState;
                end if;
            end case;
        end if;
    end process;
end architecture bhv;