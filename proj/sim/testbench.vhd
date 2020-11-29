library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;
use STD.TEXTIO.ALL;
use IEEE.MATH_REAL.all;

library work;
use work.util_package.ALL;

entity testbench is
--  Port ( );
end testbench;

architecture bhv of testbench is
    component AES is
    Port ( 
        clk   : in  STD_LOGIC;
        rst   : in  STD_LOGIC;
        init  : in  STD_LOGIC;
        key   : in  STD_LOGIC_VECTOR(127 downto 0);
        input : in  STD_LOGIC_VECTOR(127 downto 0);
        done  : out STD_LOGIC := '0';
        output: out STD_LOGIC_VECTOR(127 downto 0) := (others => '0'));
    end component;
    signal clk   : STD_LOGIC := '0';
    signal rst   : STD_LOGIC := '1';
    signal init  : STD_LOGIC := '0';
    signal key   : STD_LOGIC_VECTOR(127 downto 0) := (others => '0');
    signal input : STD_LOGIC_VECTOR(127 downto 0) := (others => '0');
    signal done  : STD_LOGIC;
    signal output: STD_LOGIC_VECTOR(127 downto 0) := (others => '0');
begin
    uut:AES
        port map( 
            clk    => clk,
            rst    => rst,
            init   => init,
            key    => key,
            input  => input,
            done   => done,
            output => output);

    clock_generate: process
        begin
            wait for 5 ns;
            clk <= not clk;
        end process clock_generate;

    rst_generate: process
        begin
            wait for 20 ns;
            rst <= '0';
            wait;
        end process;

--    Init_gen: process
--        begin
--            if (done = '1') then
--                init <= '1';
--            end if;
--        end process Init_gen;
    init <= done;
    IO: process
        file file_in: text;
        file file_out: text;
        variable file_status: file_open_status;
        variable buf_input: line;
        variable buf_output: line;
        variable data: STD_LOGIC_VECTOR(255 downto 0);
        begin
            file_open(file_status, file_in, "input.txt", read_mode);
            file_open(file_out, "output.txt", write_mode);
            --wait until (rst = '0');
            while (not endfile(file_in)) loop
                readline(file_in, buf_input);
                read(buf_input, data);
                input <= data(255 downto 128);
                key <= data(127 downto 0);

                wait until rising_edge(done);
                write(buf_output, output);
                writeline(file_out, buf_output);
                wait until (done = '0');
--                init <= '0';


--                init <= '1';
            end loop;
            file_close(file_out);
            std.env.finish;
        end process IO;
end architecture;