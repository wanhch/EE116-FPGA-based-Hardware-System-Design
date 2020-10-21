library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity FSM is
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
end entity FSM;

architecture bhv of FSM is
type StateType is (Idle, DefaultSet, Set, Sale, Deliver);
signal State: StateType := Idle;
signal NextState: StateType := Idle;
begin
   process(CLK, RST)
   begin
      if rising_edge(CLK) then
         if (RST = '1') then
            State <= Idle;
         else
            State <= NextState;
         end if;
      end if;
   end process;

   process(State, Enable, Delivered, cal_flag)
   begin
      case State is
      when Idle =>
         is_setting <= '1';
         CLR_price <= '1';
         CLR_invested <= '1';
         default_flag <= '1';
         NextState <= DefaultSet;
      when DefaultSet =>
         CLR_price <= '0';
         CLR_invested <= '1';
         default_flag <= '1';
         if (Enable = '1') then
            NextState <= Sale;
            is_setting <= '0';
         elsif (cal_flag = '1') then
            NextState <= Set;
            is_setting <= '1';
         else
            NextState <= DefaultSet;
            is_setting <= '1';
         end if;
      when Set =>
         CLR_price <= '0';
         CLR_invested <= '1';
         default_flag <= '0';
         if (Enable = '1') then
            NextState <= Sale;
            is_setting <= '0';
         else
            NextState <= Set;
            is_setting <= '1';
         end if;
      when Sale =>
         CLR_price <= '0';
         CLR_invested <= '0';
         is_setting <= '0';
         default_flag <= '0';
         if (Delivered = '1') then
            NextState <= Deliver;
         else
            NextState <= Sale;
         end if;
      when Deliver =>
         default_flag <= '0';
         if (DONE = '1') then
            NextState <= DefaultSet;
            is_setting <= '1';
            CLR_price <= '1';
            CLR_invested <= '1';
            default_flag <= '1';
         else
            NextState <= Deliver;
            is_setting <= '0';
            CLR_price <= '0';
            CLR_invested <= '0';
         end if;
      when others =>
         NextState <= Idle;
         is_setting <= '1';
         CLR_price <= '1';
         CLR_invested <= '1';
         default_flag <= '0';
      end case;
   end process;
end bhv;