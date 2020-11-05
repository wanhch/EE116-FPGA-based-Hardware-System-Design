library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Use the libraries you need

entity pipe is
    Generic(
            DATA_WIDTH : POSITIVE := 8;
            LENGTH : POSITIVE := 10);  
    Port ( 
            clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            D : in STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
            Q : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0) := (others => '0'));
end pipe;

architecture Behavioral of pipe is
signal reg: STD_LOGIC_VECTOR(DATA_WIDTH * LENGTH -1 downto 0) := (others => '0');
begin
    Q <= reg(DATA_WIDTH-1 downto 0);
    process(clk)
    begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                reg <= (others => '0');
            else
                for idx in 0 to LENGTH-2 loop
                    reg(DATA_WIDTH * (idx+1) -1 downto DATA_WIDTH * idx) <= reg(DATA_WIDTH * (idx+2) -1 downto DATA_WIDTH * (idx+1));
                end loop;
                reg(DATA_WIDTH * LENGTH -1 downto DATA_WIDTH * (LENGTH-1)) <= D;
            end if;
        end if;
    end process;
end Behavioral;