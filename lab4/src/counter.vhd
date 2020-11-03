library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Use the libraries you need

library work;
use work.util_package.ALL;

entity counter is
    Generic ( 
            WIDTH : POSITIVE := 32;
            HEIGHT : POSITIVE := 32);
    Port ( 
            clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            enable_row_count : in STD_LOGIC;
            pixel_cntr : out STD_LOGIC_VECTOR (clog2(WIDTH)-1 downto 0) := (others => '0');
            slice_cntr : out STD_LOGIC_VECTOR (clog2(HEIGHT)-1 downto 0) := (others => '0'));
end counter;

architecture Behavioral of counter is
signal pixel: UNSIGNED(clog2(WIDTH)-1 downto 0) := (others => '0');
signal slice: UNSIGNED(clog2(HEIGHT)-1 downto 0) := (others => '0');
begin
    pixel_cntr <= STD_LOGIC_VECTOR(pixel);
    slice_cntr <= STD_LOGIC_VECTOR(slice);

process(clk)
begin
    if (rising_edge(clk)) then
        if (rst = '1') then
            pixel <= (others => '0');
            slice <= (others => '0');
        elsif (enable_row_count = '1') then
            if (pixel < WIDTH) then
                pixel <= pixel + 1;
            else
                pixel <= (others => '0');
                if (slice < HEIGHT - 1) then
                    slice <= slice + 1;
                else
                    slice <= (others => '0');
                end if;
            end if;
        end if;
    end if;
end process;
end Behavioral;
