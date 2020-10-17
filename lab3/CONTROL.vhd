library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity CONTROL is
    port(CLK    : in  STD_LOGIC;
         DONE   : in  STD_LOGIC;
         Enable : in  STD_LOGIC;
         RESULT : in  UNSIGNED(5 downto 0);
         RST    : in  STD_LOGIC;
         Deliver_I: in STD_LOGIC;
         Money  : out STD_LOGIC_VECTOR(5 downto 0);
         Deliver_O: out STD_LOGIC;
         SET    : out STD_LOGIC;
         SALE   : out STD_LOGIC;
         CHANGE : out STD_LOGIC;
         STATE  : out STD_LOGIC);
end entity CONTROL;

architecture bhv of CONTROL is
begin
    process(CLK, RST, Enable)
    type StateType is (SetState, SaleState, DeliverState);
    variable state: StateType := SetState;
    begin
        if (RST = '1') then
            STATE <= '1';
            Deliver_O <= '0';
            Money <= STD_LOGIC_VECTOR(RESULT);
            state := SetState;
        elsif (rising_edge(clk)) then
            case state is
            when SetState =>
                STATE <= '0';
                Money <= STD_LOGIC_VECTOR(RESULT);
                if (Enable = '1') then
                    STATE <= '1';
                    state := SaleState; 
                end if;
            when SaleState =>
                STATE <= '0';
                Money <= STD_LOGIC_VECTOR(RESULT);
                if (Deliver_I = '1') then
                    Deliver_O <= '1';
                    STATE <= '1';
                    state := DeliverState;
                end if;
            when DeliverState =>
                STATE <= '0';
                if (DONE = '1') then
                    Deliver_O <= '0';
                    STATE <= '1';
                    state := SetState;
                end if;
            end case;
        end if;
    end process;
end architecture bhv;