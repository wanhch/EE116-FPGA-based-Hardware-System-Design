library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;
use STD.TEXTIO.ALL;
use IEEE.MATH_REAL.all;

-- Use the libraries you need

library work;
use work.util_package.ALL;

entity test_systolic is
    Generic(
        MAT_A_ROWS : POSITIVE := 4;
        MAT_LENGTH : POSITIVE := 4;
        MAT_B_COLS : POSITIVE := 4;
        ARRAY_SIZE : POSITIVE := 4;
        INPUT_WIDTH : POSITIVE := 8;
        RAND_SEED_A : POSITIVE := 1;
        RAND_SEED_B : POSITIVE := 2;
        SAMPLE_NUM : POSITIVE := 4;
        VALID_KIND : POSITIVE := get_valid_kind(ARRAY_SIZE, MAT_LENGTH);
        OUTPUT_WIDTH : POSITIVE := INPUT_WIDTH*2 + clog2(MAT_LENGTH));
--  Port ( );
end test_systolic;

architecture Behavioral of test_systolic is
    component systolic is
        Generic ( 
            MAT_A_ROWS : POSITIVE := 4;
            MAT_LENGTH : POSITIVE := 4;
            MAT_B_COLS : POSITIVE := 4;
            ARRAY_SIZE : POSITIVE := 2;
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
    end component;

    signal clk_sig: STD_LOGIC := '0';
    signal rst_sig: STD_LOGIC := '1';
    
    type InputLineType is array(natural range <>) of STD_LOGIC_VECTOR(INPUT_WIDTH-1 downto 0);
    type InputMatrixAType is array(0 to MAT_A_ROWS-1) of InputLineType(0 to MAT_LENGTH-1);
    type InputMatrixBType is array(0 to MAT_LENGTH-1) of InputLineType(0 to MAT_B_COLS-1);
    signal matrix_A: InputMatrixAType := (others => (others => (others => '0')));
    signal matrix_B: InputMatrixBType := (others => (others => (others => '0')));

    type OutputLineType is array(natural range <>) of STD_LOGIC_VECTOR(OUTPUT_WIDTH-1 downto 0);
    type OutputMatrixType is array(0 to MAT_A_ROWS-1) of OutputLineType(0 to MAT_B_COLS-1);
    type OutputMatrixListType is array(0 to VALID_KIND-1) of OutputMatrixType;
    signal matrix_D: OutputMatrixType := (others => (others => (others => '0')));
    signal D_list: OutputMatrixListType := (others => (others => (others => (others => '0'))));
    signal reference_D: OutputMatrixListType := (others => (others => (others => (others => '0'))));

    signal D_sig: STD_LOGIC_VECTOR (OUTPUT_WIDTH * (ARRAY_SIZE**2)-1 downto 0) := (others => '0');
    signal valid_D_sig: STD_LOGIC_VECTOR (clog2(VALID_KIND+1) * (ARRAY_SIZE**2)-1 downto 0) := (others => '0');

    signal read_address_A_sig: STD_LOGIC_VECTOR (clog2(MAT_A_ROWS * MAT_LENGTH)-1 downto 0) := (others => '0');
    signal read_address_B_sig: STD_LOGIC_VECTOR (clog2(MAT_LENGTH * MAT_B_COLS)-1 downto 0) := (others => '0');
    
    signal input_A_sig: STD_LOGIC_VECTOR(INPUT_WIDTH * ARRAY_SIZE-1 downto 0) := (others => '0');
    signal input_B_sig: STD_LOGIC_VECTOR(INPUT_WIDTH * ARRAY_SIZE-1 downto 0) := (others => '0');
    
    signal matrix_in_done_sig: STD_LOGIC := '0';
    signal matrix_out_done_sig: STD_LOGIC := '0';

    signal gen_done: STD_LOGIC := '0';
    signal read_done: STD_LOGIC := '0';

-- Add your own code here
begin

    clock_generate: process
        begin
            wait for 5 ns;
            clk_sig <= not clk_sig;
        end process clock_generate;

    rst_generate: process
        begin
            wait until (gen_done = '1');
            wait for 20 ns;
            rst_sig <= '0';
            wait;
        end process;

    uut:systolic
        Generic map (
            MAT_A_ROWS => MAT_A_ROWS,
            MAT_LENGTH => MAT_LENGTH,
            MAT_B_COLS => MAT_B_COLS,
            ARRAY_SIZE => ARRAY_SIZE,
            INPUT_WIDTH => INPUT_WIDTH,
            VALID_KIND => VALID_KIND,
            OUTPUT_WIDTH => OUTPUT_WIDTH)
        Port map (
            clk => clk_sig,
            rst => rst_sig,
            read_address_A => read_address_A_sig,
            read_address_B => read_address_B_sig,
            A => input_A_sig,
            B => input_B_sig,
            D => D_sig,
            valid_D => valid_D_sig,
            input_done => matrix_in_done_sig); -- uut

    gen_input: process
        variable seed1, seed2: positive;
        variable rand_num, rand_max: real;
        variable rand_int: integer range 0 to 2**INPUT_WIDTH-1;

        FILE file_out: text;
        variable file_status: file_open_status;
        variable buf: line;
        begin
            gen_done <= '0';
            seed1 := RAND_SEED_A;
            seed2 := RAND_SEED_B;
            rand_max := real(2**INPUT_WIDTH);

            file_open(file_status, file_out, "testcase.txt", write_mode);

            for matrix_index in 0 to SAMPLE_NUM - 1 loop
                for length in 0 to MAT_LENGTH - 1 loop
                    for row in 0 to MAT_A_ROWS - 1 loop
                        uniform(seed1, seed2, rand_num);
                        rand_int := integer(trunc(rand_num * rand_max));
                        write(buf, std_logic_vector(to_unsigned(rand_int, INPUT_WIDTH)));
                    end loop;
                    for col in 0 to MAT_B_COLS - 1 loop
                        uniform(seed1, seed2, rand_num);
                        rand_int := integer(trunc(rand_num * rand_max));
                        write(buf, std_logic_vector(to_unsigned(rand_int, INPUT_WIDTH)));
                    end loop;
                end loop;
                writeline(file_out,buf);
                wait until falling_edge(clk_sig);
            end loop;
            file_close(file_out);
            wait for 20 ns;
            gen_done <= '1';
            wait;
        end process gen_input;

    read_input: process
        FILE file_in: text;
        variable file_status: file_open_status;
        variable buf: line;
        variable data: STD_LOGIC_VECTOR(INPUT_WIDTH-1 downto 0);
        begin
            wait until (gen_done = '1');
            file_open(file_status, file_in, "testcase.txt", read_mode);

            for matrix_index in 0 to SAMPLE_NUM - 1 loop
                readline(file_in, buf);
                for length in 0 to MAT_LENGTH - 1 loop
                    for row in 0 to MAT_A_ROWS - 1 loop
                        read(buf, data);
                        matrix_A(row)(length) <= data;
                    end loop;
                    for col in 0 to MAT_B_COLS - 1 loop
                        read(buf, data);
                        matrix_B(length)(col) <= data;
                    end loop;
                end loop;
                wait until falling_edge(matrix_in_done_sig);
            end loop;
            wait;
        end process read_input;

    send_input: process(matrix_A, matrix_B, read_address_A_sig, read_address_B_sig)
        variable address_A: integer range 0 to MAT_A_ROWS*MAT_LENGTH-1;
        variable address_B: integer range 0 to MAT_LENGTH*MAT_B_COLS-1;
        variable row_A: integer range 0 to MAT_A_ROWS-1;
        variable col_A: integer range 0 to MAT_LENGTH-1;
        variable row_B: integer range 0 to MAT_LENGTH-1;
        variable col_B: integer range 0 to MAT_B_COLS-1;
        begin
            address_A := to_integer(unsigned(read_address_A_sig));
            row_A := address_A / MAT_LENGTH;
            col_A := address_A mod MAT_LENGTH;

            address_B := to_integer(unsigned(read_address_B_sig));
            row_B := address_B / MAT_B_COLS;
            col_B := address_B mod MAT_B_COLS;

            for idx in 0 to ARRAY_SIZE - 1 loop
                input_A_sig(INPUT_WIDTH*(idx+1)-1 downto INPUT_WIDTH*idx) <= matrix_A(row_A + idx)(col_A);
                input_B_sig(INPUT_WIDTH*(idx+1)-1 downto INPUT_WIDTH*idx) <= matrix_B(row_B)(col_B + idx);
            end loop;
        end process send_input;

    --cal_result: process(clk_sig)
    --    type ValidLineType is array(0 to ARRAY_SIZE-1) of STD_LOGIC_VECTOR(clog2(MAT_A_ROWS * MAT_B_COLS / (ARRAY_SIZE**2) + 1)-1 downto 0);
    --    type ValidMatrixType is array(0 to ARRAY_SIZE-1) of ValidLineType;
    --    type ValidMatrixListType is array(0 to VALID_KIND-1) of ValidMatrixType;
    --    variable valid_count: ValidMatrixListType := ( others => (others => (others => (others => '0'))));

    --    variable valid_sig: INTEGER := 0; --UNSIGNED(clog2(VALID_KIND+1) * (ARRAY_SIZE**2)-1 downto 0) := (others => '0');
    --    variable slice: INTEGER := MAT_B_COLS / ARRAY_SIZE;
    --    begin
    --        if (rising_edge(clk_sig)) then
    --            matrix_out_done_sig <= '0';
    --            for idx in 0 to VALID_KIND-1 loop 
    --                if (TO_INTEGER(UNSIGNED(valid_count(idx)(ARRAY_SIZE-1)(ARRAY_SIZE-1))) >= MAT_A_ROWS * MAT_B_COLS / (ARRAY_SIZE**2)) then
    --                    matrix_D <= D_list(idx);
    --                    valid_count(idx) := (others => (others => (others => '0')));
    --                    matrix_out_done_sig <= '1';
    --                end if;
    --            end loop;

    --            for row in 0 to ARRAY_SIZE-1 loop 
    --                for col in 0 to ARRAY_SIZE-1 loop 
    --                    valid_sig := TO_INTEGER(UNSIGNED(valid_D_sig(clog2(VALID_KIND+1) * (row*ARRAY_SIZE+col + 1) -1 downto clog2(VALID_KIND+1) * (row*ARRAY_SIZE+col))));
    --                    if (valid_sig > 0 and valid_sig <= VALID_KIND and TO_INTEGER(UNSIGNED(valid_count(valid_sig-1)(row)(col))) < MAT_A_ROWS * MAT_B_COLS / (ARRAY_SIZE**2)) then
    --                        D_list(valid_sig-1)(row + TO_INTEGER(UNSIGNED(valid_count(valid_sig-1)(row)(col))) / slice * ARRAY_SIZE)(col + TO_INTEGER(UNSIGNED(valid_count(valid_sig-1)(row)(col))) mod slice * ARRAY_SIZE) <= D_sig(OUTPUT_WIDTH * (row*ARRAY_SIZE+col + 1) -1 downto OUTPUT_WIDTH * (row*ARRAY_SIZE+col));
    --                        if (TO_INTEGER(UNSIGNED(valid_count(valid_sig-1)(row)(col))) < MAT_A_ROWS * MAT_B_COLS / (ARRAY_SIZE**2)) then
    --                            valid_count(valid_sig-1)(row)(col) := STD_LOGIC_VECTOR(UNSIGNED(valid_count(valid_sig-1)(row)(col)) + 1);
    --                        end if;
    --                    end if;
    --                end loop;
    --            end loop;
    --        end if;
    --    end process cal_result;

    cal_result: process(clk_sig)
        type TempLineType is array(natural range <>) of STD_LOGIC_VECTOR(OUTPUT_WIDTH-1 downto 0);
        type TempMatrixType is array(0 to ARRAY_SIZE-1) of TempLineType(0 to ARRAY_SIZE-1);
        type TempMatrixListType is array(0 to VALID_KIND-1) of TempMatrixType;
        variable Temp_list: TempMatrixListType := (others => (others => (others => (others => '0'))));

        type SliceType is array(0 to VALID_KIND-1) of INTEGER;
        variable SliceArray: SliceType := (others => 0);

        --type ValidLineType is array(0 to MAT_B_COLS / ARRAY_SIZE -1) of INTEGER;
        --type ValidMatrixType is array(0 to MAT_A_ROWS / ARRAY_SIZE -1) of ValidLineType;
        --variable valid_reg: ValidMatrixType := (others => (others => 0));

        variable valid_reg: INTEGER := 0;
        variable valid_sig: INTEGER := 0;
        variable slice: INTEGER := MAT_B_COLS / ARRAY_SIZE;
        begin
            if (rising_edge(clk_sig)) then
                matrix_out_done_sig <= '0';
                for idx in 0  to VALID_KIND-1 loop
                    if (SliceArray(idx) >= MAT_A_ROWS * MAT_B_COLS / (ARRAY_SIZE**2)) then
                        SliceArray(idx) := 0;
                        matrix_D <= D_list(idx);
                        matrix_out_done_sig <= '1';
                        valid_reg := valid_reg + 1;
                        if (valid_reg >= VALID_KIND) then
                            valid_reg := 0;
                        end if;
                     end if;
                end loop;

                for row in 0 to ARRAY_SIZE-1 loop
                    for col in 0 to ARRAY_SIZE-1 loop
                        valid_sig := TO_INTEGER(UNSIGNED(valid_D_sig(clog2(VALID_KIND+1) * (row*ARRAY_SIZE+col + 1) -1 downto clog2(VALID_KIND+1) * (row*ARRAY_SIZE+col))));
                        if (valid_sig > 0 and valid_sig <= VALID_KIND and SliceArray(valid_sig-1) < MAT_A_ROWS * MAT_B_COLS / (ARRAY_SIZE**2)) then
                            Temp_list(valid_sig - 1)(row)(col) := D_sig(OUTPUT_WIDTH * (row*ARRAY_SIZE+col + 1) -1 downto OUTPUT_WIDTH * (row*ARRAY_SIZE+col));
                            if (row = ARRAY_SIZE-1 and col = ARRAY_SIZE-1) then
                                for sub_row in 0 to ARRAY_SIZE-1 loop
                                    for sub_col in 0 to ARRAY_SIZE-1 loop
                                        if (valid_reg < VALID_KIND) then
                                            if (SliceArray(valid_reg) < MAT_A_ROWS * MAT_B_COLS / (ARRAY_SIZE**2)) then
                                                D_list(valid_reg)(sub_row + SliceArray(valid_reg) / slice * ARRAY_SIZE)(sub_col + SliceArray(valid_reg) mod slice * ARRAY_SIZE) <= Temp_list(valid_sig-1)(sub_row)(sub_col);
                                            end if;
                                        end if;                                    
                                    end loop;
                                end loop;
                                SliceArray(valid_reg) := SliceArray(valid_reg) + 1;
                            end if;
                        end if;
                    end loop;
                end loop;
            end if;
        end process cal_result;

    save_result: process
        file file_out: TEXT;
        variable file_status: file_open_status;
        variable buf: LINE;
        begin
            wait until (gen_done = '1');
            file_open(file_out, "output.txt", write_mode);
            for matrix_index in 0 to SAMPLE_NUM - 1 loop
                wait until rising_edge(matrix_out_done_sig);
                for row in 0 to MAT_A_ROWS - 1 loop
                    for col in 0 to MAT_B_COLS - 1 loop
                        write(buf, matrix_D(row)(col));
                    end loop;
                end loop;
                writeline(file_out,buf);
            end loop;
            file_close(file_out);
            
            wait;
        end process save_result;

    gen_refernece: process
        FILE file_in: text;
        variable file_status: file_open_status;
        variable buf: line;
        variable data: STD_LOGIC_VECTOR(INPUT_WIDTH-1 downto 0);
        variable tmp_res: integer range 0 to 2**OUTPUT_WIDTH-1;

        type InputLineType is array(natural range <>) of STD_LOGIC_VECTOR(INPUT_WIDTH-1 downto 0);
        type InputMatrixAType is array(0 to MAT_A_ROWS-1) of InputLineType(0 to MAT_LENGTH-1);
        type InputMatrixBType is array(0 to MAT_LENGTH-1) of InputLineType(0 to MAT_B_COLS-1);
        variable matrix_A_reference: InputMatrixAType := (others => (others => (others => '0')));
        variable matrix_B_reference: InputMatrixBType := (others => (others => (others => '0')));

        begin
            wait until (gen_done = '1');
            file_open(file_status, file_in, "testcase.txt", read_mode);

            for matrix_index in 0 to SAMPLE_NUM - 1 loop
                readline(file_in, buf);
                for length in 0 to MAT_LENGTH - 1 loop
                    for row in 0 to MAT_A_ROWS - 1 loop
                        read(buf, data);
                        matrix_A_reference(row)(length) := data;
                    end loop;
                    for col in 0 to MAT_B_COLS - 1 loop
                        read(buf, data);
                        matrix_B_reference(length)(col) := data;
                    end loop;
                end loop;

                for row in 0 to MAT_A_ROWS - 1 loop
                    for col in 0 to MAT_B_COLS - 1 loop
                        tmp_res := 0;
                        for k in 0 to MAT_LENGTH - 1 loop
                            tmp_res := tmp_res + to_integer(unsigned(matrix_A_reference(row)(k))) * to_integer(unsigned(matrix_B_reference(k)(col)));
                        end loop;
                        reference_D(matrix_index mod VALID_KIND)(row)(col) <= std_logic_vector(to_unsigned(tmp_res, OUTPUT_WIDTH));
                    end loop;
                end loop;
                wait until rising_edge(matrix_out_done_sig);
            end loop;
            wait;
        end process gen_refernece;

    check_result: process
        file file_out: TEXT;
        variable file_status: file_open_status;
        variable buf: LINE;
        variable is_right: STD_LOGIC;
        begin
            wait until (gen_done = '1');
            file_open(file_out, "result.txt", write_mode);
            for matrix_index in 0 to SAMPLE_NUM - 1 loop
                wait until rising_edge(matrix_out_done_sig);
                for row in 0 to MAT_A_ROWS - 1 loop
                    for col in 0 to MAT_B_COLS - 1 loop
                        if matrix_D(row)(col) /= reference_D(matrix_index mod VALID_KIND)(row)(col) then
                            is_right := '0';
                        else
                            is_right := '1';
                        end if;
                        write(buf, is_right);
                    end loop;
                end loop;
                writeline(file_out,buf);
            end loop;
            file_close(file_out);

            wait until falling_edge(clk_sig);
            std.env.finish;
        end process check_result;

end architecture;