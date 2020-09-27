library IEEE;
use IEEE.STD_LOGIC_1164.all;


type vector_array IS ARRAY(0 to 15) of STD_LOGIC_VECTOR(7 downto 0);
entity LED_DRIVER is
    generic (addrwidth: INTEGER := 4);
    port(CLK_50:  in STD_LOGIC;
         DATA  :  in STD_LOGIC_VECTOR(addrwidth-1 downto 0);
         CE    :  in STD_LOGIC;
         LOAD  :  in STD_LOGIC;
         UPDN  :  in STD_LOGIC;
         RST   :  in STD_LOGIC;
         LED   : out STD_LOGIC_VECTOR(7 downto 0));
end entity LED_DRIVER;

architecture bhv of LED_DRIVER is
    component CLK_DIV is
        port(clk    : in  STD_LOGIC;
             clk_out: out STD_LOGIC);
    end component CLK_DIV;
    component ADDR_CNTR is
        generic (addrwidth: INTEGER);
        port(DATA: in  STD_LOGIC_VECTOR(addrwidth-1 downto 0);
             CE  : in  STD_LOGIC;
             LOAD: in  STD_LOGIC;
             UPDN: in  STD_LOGIC;
             clk : in  STD_LOGIC;
             RST : in  STD_LOGIC;
             Q   : out STD_LOGIC_VECTOR(addrwidth-1 downto 0));
    end component ADDR_CNTR;
    component MEM is
        port(addr: in  STD_LOGIC_VECTOR(3 downto 0);
             data: out STD_LOGIC_VECTOR(7 downto 0));
    end component MEM;
    signal clk_div: STD_LOGIC;
    signal ADDR: STD_LOGIC_VECTOR(3 downto 0);
begin
    G1: CLK_DIV port map(clk => CLK_50, clk_out => clk_div);
    G2: ADDR_CNTR generic map(addrwidth => 4)
                  port map(DATA => DATA, CE => CE, LOAD => LOAD, UPDN => UPDN, clk => clk_div, RST => RST, Q => ADDR);
    G3: MEM port map(addr => ADDR, data => LED);
end architecture bhv;