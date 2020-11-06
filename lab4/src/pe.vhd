library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Use the libraries you need

library work;
use work.util_package.ALL;

entity pe is
    Generic ( 
        MAT_LENGTH : POSITIVE := 32;
        INPUT_WIDTH : POSITIVE := 8;
        OUTPUT_WIDTH : POSITIVE := 21);
    Port ( 
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        init : in STD_LOGIC;
        in_a : in STD_LOGIC_VECTOR (INPUT_WIDTH-1 downto 0);
        in_b : in STD_LOGIC_VECTOR (INPUT_WIDTH-1 downto 0);
        out_sum : out STD_LOGIC_VECTOR (OUTPUT_WIDTH-1 downto 0);
        valid_sum : out STD_LOGIC := '0';
        out_a : out STD_LOGIC_VECTOR (INPUT_WIDTH-1 downto 0) := (others => '0');
        out_b : out STD_LOGIC_VECTOR (INPUT_WIDTH-1 downto 0) := (others => '0'));
end pe;

architecture Behavioral of pe is
signal reg: STD_LOGIC_VECTOR (OUTPUT_WIDTH-1 downto 0) := (others => '0');
begin
    out_sum <= reg;

    process(clk)
    variable count: INTEGER;
    variable count_flag: STD_LOGIC := '0';
    begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                count_flag := '0';
                count := 0;
                reg <= (others => '0');
                valid_sum <= '0';
                out_a <= (others => '0');
                out_b <= (others => '0');
            elsif (init = '1') then
                count_flag := '1';
                count := 1;
                valid_sum <= '0';
                reg(OUTPUT_WIDTH-1 downto 2*INPUT_WIDTH) <= (others => '0');
                reg(2*INPUT_WIDTH -1 downto 0) <= STD_LOGIC_VECTOR(UNSIGNED(in_a) * UNSIGNED(in_b));
                out_a <= in_a;
                out_b <= in_b;
            else
                if (count_flag = '1') then
                    if (count < MAT_LENGTH-1) then
                        count := count + 1;
                        valid_sum <= '0';
                    else
                        valid_sum <= '1';
                    end if;
                else
                    count := 0;
                end if;
                reg <= STD_LOGIC_VECTOR(UNSIGNED(in_a) * UNSIGNED(in_b) + UNSIGNED(reg));
                out_a <= in_a;
                out_b <= in_b;
            end if;
        end if;
    end process;
end Behavioral;
