library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

entity teshbench is
generic(nq: INTEGER := 4;
        nm: INTEGER := 5);
--  Port ( );
end teshbench;

architecture Behavioral of teshbench is
component MUL is
    generic(nq: INTEGER := 4;
            nm: INTEGER := 5);
    port(Multiplicand: in  STD_LOGIC_VECTOR(nm-1 downto 0);
         Multiplier  : in  STD_LOGIC_VECTOR(nq-1 downto 0);
         Start       : in  STD_LOGIC;
         CLK         : in  STD_LOGIC;
         Done        : out STD_LOGIC;
         Product     : out STD_LOGIC_VECTOR(nm+nq-1 downto 0));
end component MUL;

signal clk_sig         : STD_LOGIC;
signal multiplicand_sig: STD_LOGIC_VECTOR(nm-1 downto 0);
signal multiplier_sig  : STD_LOGIC_VECTOR(nq-1 downto 0);
signal product_sig     : STD_LOGIC_VECTOR(nm+nq-1 downto 0);
signal product_ref     : STD_LOGIC_VECTOR(nm+nq-1 downto 0);
signal start_sig       : STD_LOGIC;
signal done_sig        : STD_LOGIC;

begin
    uut: MUL port map (Multiplicand => multiplicand_sig,
                       Multiplier   => multiplier_sig,
                       Start        => start_sig,
                       CLK          => clk_sig,
                       Done         => done_sig,
                       Product      => product_sig);

    process 
    variable is_right: STD_LOGIC;
    begin
        for i in (2**nm)-1 downto 0 loop
            for j in (2**nq)-1 downto 0 loop
                multiplicand_sig <= STD_LOGIC_VECTOR(TO_UNSIGNED(i, nm));
                multiplier_sig   <= STD_LOGIC_VECTOR(TO_UNSIGNED(j, nq));
                product_ref      <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*j, nm+nq));
                start_sig        <= '1';
                wait until rising_edge(clk_sig);
                start_sig <= '0';
                wait until done_sig = '1';
                wait for 1 ns;
                if product_sig = product_ref then
                    is_right := '1';
                else
                    is_right := '0';
                end if;
                wait until rising_edge(clk_sig);
            end loop;
        end loop;
    end process;

    process
    begin 
        loop
            clk_sig <= '0';
            wait for 1 ns;
            clk_sig <= '1';
            wait for 1 ns;
        end loop;
    end process;

end Behavioral;