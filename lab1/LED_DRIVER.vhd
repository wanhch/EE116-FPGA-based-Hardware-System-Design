library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity LED_DRIVER is
--    generic(addrwidth: INTEGER := 4);
    port(CLK_50 : in  STD_LOGIC;
         DATA_in: in  unsigned(3 downto 0);
         CE     : in  STD_LOGIC;
         LOAD   : in  STD_LOGIC;
         UPDN   : in  STD_LOGIC;
         RST    : in  STD_LOGIC;
         LED    : out unsigned(7 downto 0));
end entity LED_DRIVER;

architecture bhv of LED_DRIVER is
    component CLK_DIV is
        port(clk    : in  STD_LOGIC;
             clk_out: out STD_LOGIC);
    end component CLK_DIV;
    component ADDR_CNTR is
        generic (addrwidth: INTEGER);
        port(DATA: in  unsigned(addrwidth-1 downto 0);
             CE  : in  STD_LOGIC;
             LOAD: in  STD_LOGIC;
             UPDN: in  STD_LOGIC;
             clk : in  STD_LOGIC;
             RST : in  STD_LOGIC;
             Q   : out unsigned(addrwidth-1 downto 0));
    end component ADDR_CNTR;
    component MEM is
        generic (addrwidth: INTEGER);
        port(addr: in  unsigned(addrwidth-1 downto 0);
             data: out unsigned(7 downto 0));
    end component MEM;
    signal clk_divided: STD_LOGIC;
    signal ADDR: unsigned(3 downto 0);
begin
    G1: CLK_DIV port map(clk => CLK_50, clk_out => clk_divided);
    G2: ADDR_CNTR generic map(addrwidth => 4)
                  port map(DATA => DATA_in, CE => CE, LOAD => LOAD, UPDN => UPDN, clk => clk_divided, RST => RST, Q => ADDR);
    G3: MEM generic map(addrwidth => 4)
            port map(addr => ADDR, data => LED);
end architecture bhv;