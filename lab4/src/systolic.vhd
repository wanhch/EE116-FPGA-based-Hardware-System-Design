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
            pixel_cntr : out STD_LOGIC_VECTOR (clog2(WIDTH)-1 downto 0) := (others => 'U');
            slice_cntr : out STD_LOGIC_VECTOR (clog2(HEIGHT)-1 downto 0) := (others => 'U'));
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
            out_sum : out STD_LOGIC_VECTOR (OUTPUT_WIDTH-1 downto 0);
            valid_sum : out STD_LOGIC := '0';
            out_a : out STD_LOGIC_VECTOR (INPUT_WIDTH-1 downto 0) := (others => '0');
            out_b : out STD_LOGIC_VECTOR (INPUT_WIDTH-1 downto 0) := (others => '0'));
    end component;

    type StreamLineType is array(0 to ARRAY_SIZE) of STD_LOGIC_VECTOR(INPUT_WIDTH-1 downto 0);
    type StreamMatrixType is array(0 to ARRAY_SIZE) of StreamLineType;
    
    signal stream_A_input_sig: StreamMatrixType := (others => (others => (others => '0')));
    signal stream_B_input_sig: StreamMatrixType := (others => (others => (others => '0')));
    signal stream_A_output_sig: StreamMatrixType := (others => (others => (others => '0')));
    signal stream_B_output_sig: StreamMatrixType := (others => (others => (others => '0')));

    type ResultLineType is array(0 to ARRAY_SIZE-1) of STD_LOGIC_VECTOR(OUTPUT_WIDTH-1 downto 0);
    type ResultMatrixType is array(0 to ARRAY_SIZE-1) of ResultLineType;

    signal out_sum_sig: ResultMatrixType;

    type LogicLineType is array(0 to ARRAY_SIZE-1) of STD_LOGIC;
    type LogicMatrixType is array (0 to ARRAY_SIZE-1) of LogicLineType;

    signal init_sig: LogicMatrixType := (others => (others => '0'));
    signal valid_sum_sig: LogicMatrixType := (others => (others => '0'));    

    type ValidCountLineType is array(0 to ARRAY_SIZE-1) of INTEGER;
    type ValidCountMatrixType is array (0 to ARRAY_SIZE-1) of ValidCountLineType;

    signal valid_sum_count: ValidCountMatrixType := (others => (others => (1)));

    type ValidLineType is array(0 to ARRAY_SIZE-1) of STD_LOGIC_VECTOR(clog2(VALID_KIND+1)-1 downto 0);
    type ValidMatrixType is array (0 to ARRAY_SIZE-1) of ValidLineType;

    signal valid_sum_reg: ValidMatrixType := (others => (others => (others => '0')));

    signal enable_count_sig: STD_LOGIC;
    signal pixel_cntr: STD_LOGIC_VECTOR(clog2(MAT_LENGTH - 1)-1 downto 0) := (others => 'U');
    signal slice_cntr: STD_LOGIC_VECTOR(clog2((MAT_LENGTH / ARRAY_SIZE)**2)-1 downto 0) := (others => 'U');
    signal slice_cntr_A: STD_LOGIC_VECTOR(clog2(MAT_A_ROWS / ARRAY_SIZE)-1 downto 0) := (others => 'U');
    signal slice_cntr_B: STD_LOGIC_VECTOR(clog2(MAT_B_COLS / ARRAY_SIZE)-1 downto 0) := (others => 'U');

begin
    CNT: counter 
        generic map (
            WIDTH => MAT_LENGTH -1,
            HEIGHT => ((MAT_LENGTH / ARRAY_SIZE)**2))
        port map (
            clk => clk,
            rst => rst,
            enable_row_count => enable_count_sig,
            pixel_cntr => pixel_cntr,
            slice_cntr => slice_cntr);
    PEROW: 
        for row in 0 to ARRAY_SIZE-1 generate
        begin
        PECOL:
            for col in 0 to ARRAY_SIZE-1 generate
            begin
                PEx: pe 
                generic map (
                    MAT_LENGTH => MAT_LENGTH,
                    INPUT_WIDTH => INPUT_WIDTH,
                    OUTPUT_WIDTH => OUTPUT_WIDTH)
                port map (
                    clk => clk,
                    rst => rst,
                    init => init_sig(row)(col),
                    in_a => stream_A_input_sig(row)(col),
                    in_b => stream_B_input_sig(row)(col),
                    out_sum => out_sum_sig(row)(col),
                    valid_sum => valid_sum_sig(row)(col),
                    out_a => stream_A_input_sig(row)(col+1),
                    out_b => stream_B_input_sig(row+1)(col));
            end generate;
        end generate;
--    GENPipeROW_Inside:
--        for row in 1 to ARRAY_SIZE-1 generate
--        begin
--        GENPipeCOL_Inside:
--            for col in 1 to ARRAY_SIZE-1 generate
--                begin
--                PipeA_I: pipe
--                generic map (
--                    DATA_WIDTH => INPUT_WIDTH,
--                    LENGTH => 1)
--                port map (
--                    clk => clk,
--                    rst => rst,
--                    D => stream_A_output_sig(row)(col-1),
--                    Q => stream_A_input_sig(row)(col));
--                PipeB_I: pipe
--                generic map (
--                    DATA_WIDTH => INPUT_WIDTH,
--                    LENGTH => 1)
--                port map (
--                    clk => clk,
--                    rst => rst,
--                    D => stream_B_output_sig(row-1)(col),
--                    Q => stream_B_input_sig(row)(col));
--            end generate;
--        end generate;
    stream_A_input_sig(0)(0)<= A(INPUT_WIDTH-1 downto 0);
    stream_B_input_sig(0)(0)<= B(INPUT_WIDTH-1 downto 0);
    GENPipe_Outside_Out:
        for idx in 1 to ARRAY_SIZE-1 generate
            PipeA_O: pipe
            generic map (
                DATA_WIDTH => INPUT_WIDTH,
                LENGTH => idx)
            port map (
                clk => clk,
                rst => rst,
                D => A(INPUT_WIDTH*(idx+1)-1 downto INPUT_WIDTH*idx),
                Q => stream_A_input_sig(idx)(0));
            PipeB_O: pipe
            generic map (
                DATA_WIDTH => INPUT_WIDTH,
                LENGTH => idx)
            port map (
                clk => clk,
                rst => rst,
                D => B(INPUT_WIDTH*(idx+1)-1 downto INPUT_WIDTH*idx),
                Q => stream_B_input_sig(0)(idx));
        end generate;
        
--    GENPipe_Outside_In:
--        for idx in 1 to ARRAY_SIZE-1 generate
--            PipeA_O: pipe
--            generic map (
--                DATA_WIDTH => INPUT_WIDTH,
--                LENGTH => 1)
--            port map (
--                clk => clk,
--                rst => rst,
--                D => stream_A_input_sig(0)(idx-1),
--                Q => stream_A_input_sig(0)(idx));
--            PipeB_O: pipe
--            generic map (
--                DATA_WIDTH => INPUT_WIDTH,
--                LENGTH => 1)
--            port map (
--                clk => clk,
--                rst => rst,
--                D => stream_B_input_sig(idx-1)(0),
--                Q => stream_B_input_sig(idx)(0));
--        end generate;
    
    slice_cntr_A <= STD_LOGIC_VECTOR(UNSIGNED(slice_cntr) / (MAT_B_COLS / ARRAY_SIZE));
    slice_cntr_B <= STD_LOGIC_VECTOR(UNSIGNED(slice_cntr) mod (MAT_B_COLS / ARRAY_SIZE));

    process(clk)
    begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                init_sig <= (others => (others => '0'));
                enable_count_sig <= '0';
                valid_sum_reg <= (others => (others => (others => '0')));
                valid_sum_count <= (others => (others => 0));
                read_address_A <= (others => '0');
                read_address_B <= (others => '0');
--                out_sum_sig <= (others => (others => (others => '0')));
                D <= (others => '0');
                valid_D <= (others => '0');
                input_done <= '0';
            else
                enable_count_sig <= '1';
                read_address_A <= STD_LOGIC_VECTOR(UNSIGNED(pixel_cntr) + TO_UNSIGNED(TO_INTEGER(UNSIGNED(slice_cntr_A))*MAT_LENGTH*ARRAY_SIZE, clog2(MAT_LENGTH * MAT_B_COLS)));
                read_address_B <= STD_LOGIC_VECTOR(TO_UNSIGNED(TO_INTEGER(UNSIGNED(pixel_cntr)) * MAT_B_COLS + TO_INTEGER(UNSIGNED(slice_cntr_B)*ARRAY_SIZE), clog2(MAT_LENGTH * MAT_B_COLS)));
                for row in 0 to ARRAY_SIZE-1 loop 
                    for col in 0 to ARRAY_SIZE-1 loop 
                        if (UNSIGNED(pixel_cntr) = (row + col) mod ARRAY_SIZE) then
                            init_sig(row)(col) <= '1';
                        else
                            init_sig(row)(col) <= '0';
                        end if;
                        if (valid_sum_sig(row)(col) = '1') then
                            valid_sum_count(row)(col) <= valid_sum_count(row)(col) + 1;
                            if (valid_sum_count(row)(col) > (MAT_A_ROWS / ARRAY_SIZE)*(MAT_B_COLS / ARRAY_SIZE)) then
                                valid_sum_count(row)(col) <= 1;
                                if (UNSIGNED(valid_sum_reg(row)(col)) < VALID_KIND) then
                                    valid_sum_reg(row)(col) <= STD_LOGIC_VECTOR(UNSIGNED(valid_sum_reg(row)(col)) + 1);
                                else
                                    valid_sum_reg(row)(col) <= (others => '0');
                                end if;
                            end if;
                            D(OUTPUT_WIDTH * (row*ARRAY_SIZE+col + 1) -1 downto OUTPUT_WIDTH * (row*ARRAY_SIZE+col)) <= out_sum_sig(row)(col);
                            valid_D(clog2(VALID_KIND+1) * (row*ARRAY_SIZE+col + 1) -1 downto clog2(VALID_KIND+1) * (row*ARRAY_SIZE+col)) <= valid_sum_reg(row)(col);
                        else
                            D(OUTPUT_WIDTH * (row*ARRAY_SIZE+col + 1) -1 downto OUTPUT_WIDTH * (row*ARRAY_SIZE+col)) <= (others => '0');
                            valid_D(clog2(VALID_KIND+1) * (row*ARRAY_SIZE+col + 1) -1 downto clog2(VALID_KIND+1) * (row*ARRAY_SIZE+col)) <= (others => '0');
                        end if;
                    end loop;
                end loop;
                if (UNSIGNED(pixel_cntr) = MAT_LENGTH-1 and UNSIGNED(slice_cntr) = (MAT_A_ROWS / ARRAY_SIZE)*(MAT_B_COLS / ARRAY_SIZE) -1) then
                    input_done <= '1';
                else
                    input_done <= '0';
                end if;
                
            end if;
        end if;
    end process;
end Behavioral;
