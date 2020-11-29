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
        mode  : in  STD_LOGIC; -- '0': encryption, '1': decryption
        key   : in  STD_LOGIC_VECTOR(127 downto 0);
        input : in  STD_LOGIC_VECTOR(127 downto 0);
        done  : out STD_LOGIC := '0';
        output: out STD_LOGIC_VECTOR(127 downto 0) := (others => '0'));
    end component;
    signal clk  : STD_LOGIC := '0';
    signal rst  : STD_LOGIC := '1';
    signal mode : STD_LOGIC := '0';
    signal key  : STD_LOGIC_VECTOR(127 downto 0) := X"d719b01e6d4a4fd17c731f4ae97bc05a";
    signal input: STD_LOGIC_VECTOR(127 downto 0) := X"310d7b9c36edca5bbc02dbb5de3d52b6";
    signal done : STD_LOGIC;
    signal output: STD_LOGIC_VECTOR(127 downto 0) := (others => '0');

begin
    uut:AES
        port map( 
            clk    => clk,
            rst    => rst,
            mode   => mode, -- '0': encryption, '1': decryption
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
end architecture;