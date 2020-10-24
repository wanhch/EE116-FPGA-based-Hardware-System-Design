library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Use the libraries you need

library work;
use work.util_package.ALL;

entity systolic is
    Generic ( 
        MAT_A_ROWS : POSITIVE := 4;
        MAT_LENGTH : POSITIVE := 4;
        MAT_B_COLS : POSITIVE := 4;
        ARRAY_SIZE : POSITIVE := 4;
        INPUT_WIDTH : POSITIVE := 8;
        VALID_KIND : POSITIVE := get_valid_kind(ARRAY_SIZE, MAT_LENGTH);
        OUTPUT_WIDTH : POSITIVE := INPUT_WIDTH*2 + clog2(MAT_LENGTH));
    Port ( 
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        read_address_A : out STD_LOGIC_VECTOR (clog2(MAT_A_ROWS * MAT_LENGTH)-1 downto 0) := (others => '0');
        read_address_B : out STD_LOGIC_VECTOR (clog2(MAT_LENGTH * MAT_B_COLS)-1 downto 0) := (others => '0');
        A : in STD_LOGIC_VECTOR (INPUT_WIDTH * ARRAY_SIZE-1 downto 0);
        B : in STD_LOGIC_VECTOR (INPUT_WIDTH * ARRAY_SIZE-1 downto 0);
        D : out STD_LOGIC_VECTOR (OUTPUT_WIDTH * (ARRAY_SIZE**2)-1 downto 0) := (others => '0');
        valid_D : out STD_LOGIC_VECTOR (clog2(VALID_KIND+1) * (ARRAY_SIZE**2)-1 downto 0) := (others => '0');
        input_done : out STD_LOGIC := '0');
end systolic;

architecture Behavioral of systolic is

    component counter
        Generic ( 
            WIDTH : POSITIVE := 32;
            HEIGHT : POSITIVE := 32);
        Port ( 
            clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            enable_row_count : in STD_LOGIC;
            pixel_cntr : out STD_LOGIC_VECTOR (clog2(WIDTH)-1 downto 0) := (others => '0');
            slice_cntr : out STD_LOGIC_VECTOR (clog2(HEIGHT)-1 downto 0) := (others => '0'));
    end component;

    component pipe is
        Generic(
            DATA_WIDTH : POSITIVE := 8;
            LENGTH : POSITIVE := 10);  
        Port ( 
            clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            D : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
            Q : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0) := (others => '0'));
    end component;

    component pe
        Generic ( 
            MAT_LENGTH : POSITIVE := 32;
            INPUT_WIDTH : POSITIVE := 8;
            OUTPUT_WIDTH : POSITIVE := INPUT_WIDTH*2 + clog2(MAT_LENGTH));
        Port ( 
            clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            init : in STD_LOGIC;
            in_a : in STD_LOGIC_VECTOR (INPUT_WIDTH-1 downto 0);
            in_b : in STD_LOGIC_VECTOR (INPUT_WIDTH-1 downto 0);
            out_sum : out STD_LOGIC_VECTOR (OUTPUT_WIDTH-1 downto 0) := (others => '0');
            valid_sum : out STD_LOGIC := '0';
            out_a : out STD_LOGIC_VECTOR (INPUT_WIDTH-1 downto 0) := (others => '0');
            out_b : out STD_LOGIC_VECTOR (INPUT_WIDTH-1 downto 0) := (others => '0'));
    end component;
    
-- Add your own code here
begin
-- Add your own code here
end Behavioral;
