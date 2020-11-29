library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.util_package.ALL;

entity AES is
    Port ( 
        clk   : in  STD_LOGIC;
        rst   : in  STD_LOGIC;
        mode  : in  STD_LOGIC; -- '0': encryption, '1': decryption
        key   : in  STD_LOGIC_VECTOR(127 downto 0);
        input : in  STD_LOGIC_VECTOR(127 downto 0);
        done  : out STD_LOGIC := '0';
        output: out STD_LOGIC_VECTOR(127 downto 0) := (others => '0'));
end AES;

architecture bhv of AES is

    component AddRoundKey
        Port ( 
            clk   : in  STD_LOGIC;
            rst   : in  STD_LOGIC;
            key   : in  work.util_package.KeyBlock;
            input : in  work.util_package.TextBlock;
            output: out work.util_package.TextBlock := (others => (others => (others => '0'))));
    end component;

    component SubBytes
        Port ( 
            clk   : in  STD_LOGIC;
            rst   : in  STD_LOGIC;
            mode  : in  STD_LOGIC; -- '0': encryption, '1': decryption
            input : in  work.util_package.TextBlock;
            output: out work.util_package.TextBlock := (others => (others => (others => '0'))));
    end component;

    component MixColumns
        Port ( 
            clk   : in  STD_LOGIC;
            rst   : in  STD_LOGIC;
            mode  : in  STD_LOGIC; -- '0': encryption, '1': decryption
            input : in  work.util_package.TextBlock;
            output: out work.util_package.TextBlock := (others => (others => (others => '0'))));
    end component;

    component ShiftRows 
        Port ( 
            clk   : in  STD_LOGIC;
            rst   : in  STD_LOGIC;
            mode  : in  STD_LOGIC; -- '0': encryption, '1': decryption
            input : in  work.util_package.TextBlock;
            output: out work.util_package.TextBlock);
    end component;

    component KeyExpansion
        Port ( 
            clk    : in  STD_LOGIC;
            rst    : in  STD_LOGIC;
            Key_in : in  work.util_package.KeyBlock;
            rc     : in  STD_LOGIC_VECTOR(7 downto 0);
            Key_out: out work.util_package.KeyBlock := (others => (others => (others => '0'))));
    end component;

    type TextArray is array(0 to 3) of work.util_package.TextBlock;
    type TextMartix is array(1 to 10) of TextArray;
    signal text_tran: TextMartix := (others => (others => (others => (others => (others => '0')))));

    type KeyArray is array(0 to 10) of work.util_package.KeyBlock;
    signal key_tran: KeyArray := (others => (others => (others => (others => '0'))));

    signal key_sig : work.util_package.KeyBlock := (others => (others => (others => '0')));
    signal input_sig : work.util_package.TextBlock := (others => (others => (others => '0')));

begin
    key_tran(0) <= key_sig;

    ARK0: AddRoundKey
        port map (
            clk    => clk,
            rst    => rst,
            key    => key_tran(0),
            input  => input_sig,
            output => text_tran(1)(0));

    KeyGen: 
        for idx in 1 to 10 generate
        begin
            KeyExp: KeyExpansion
            port map (
                clk     => clk,
                rst     => rst,
                Key_in  => key_tran(idx -1),
                rc      => work.util_package.Rc(idx),
                Key_out => key_tran(idx));
        end generate;

    SBGen:
        for idx in 1 to 9 generate
        begin
            SB: SubBytes
            port map (
                clk    => clk,
                rst    => rst,
                mode   => mode,
                input  => text_tran(idx)(0),
                output => text_tran(idx)(1));
        end generate;

    SRGen:
        for idx in 1 to 9 generate
        begin
            SR: ShiftRows
            port map (
                clk    => clk,
                rst    => rst,
                mode   => mode,
                input  => text_tran(idx)(1),
                output => text_tran(idx)(2));

        end generate;

    MCGen:
        for idx in 1 to 9 generate
        begin
            MC: MixColumns
            port map (
                clk    => clk,
                rst    => rst,
                mode   => mode,
                input  => text_tran(idx)(2),
                output => text_tran(idx)(3));
        end generate;

    ARKGen:
        for idx in 1 to 9 generate
        begin
            ARK: AddRoundKey
            port map (
                clk    => clk,
                rst    => rst,
                key    => key_tran(idx),
                input  => text_tran(idx)(3),
                output => text_tran(idx+1)(0));
        end generate;

    SB1: SubBytes
        port map (
            clk    => clk,
            rst    => rst,
            mode   => mode,
            input  => text_tran(10)(0),
            output => text_tran(10)(1));

    SR1: ShiftRows
        port map (
            clk    => clk,
            rst    => rst,
            mode   => mode,
            input  => text_tran(10)(1),
            output => text_tran(10)(2));

    ARK1: AddRoundKey
        port map (
            clk    => clk,
            rst    => rst,
            key    => key_tran(10),
            input  => text_tran(10)(2),
            output => text_tran(10)(3));
            
    process(clk)
        begin
        if (rising_edge(clk)) then
            for row in 0 to 3 loop
                for col in 0 to 3 loop
                    key_sig(4-row)(4-col) <= key(((row*4) +col +1) *8 -1 downto ((row*4) +col) *8);
                    input_sig(4-row)(4-col) <= input(((row*4) +col +1) *8 -1 downto ((row*4) +col) *8);
                    output(((row*4) +col +1) *8 -1 downto ((row*4) +col) *8) <= text_tran(10)(3)(4-row)(4-col);
                end loop;
            end loop;
        end if;
    end process;
    
end bhv;