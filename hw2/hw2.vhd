process (clk, Reset)
    type StateTpye is (IDLE, EAT, SLEEP);
    variable State: StateTpye;
begin
    if Reset = '1' then
        State := IDLE;
        S <= '1';
        G <= '0';
        D <= '0';
    elsif (rising_egde(clk)) then
        case State is
        when IDLE =>
            if (Hungry = '1') then
                State := EAT;
                S <= '0';
                G <= '1';
                D <= '0';
            end if;
        when EAT =>
            if (Tired = '1') then
                State := SLEEP;
                S <= '0';
                G <= '0';
                D <= '1';
            end if;
        when SLEEP =>
            State := IDLE;
            S <= '1';
            G <= '0';
            D <= '0';
        end case;
    end if;
end process;