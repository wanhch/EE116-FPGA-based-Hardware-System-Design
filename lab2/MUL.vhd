library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity MUL is
    generic(nq: INTEGER;
            nm: INTEGER);
    port(Multiplicant: in  STD_LOGIC_VECTOR(nm-1 downto 0);
         Multiplier  : in  STD_LOGIC_VECTOR(nq-1 downto 0);
         Start       : in  STD_LOGIC;
         CLK         : in  STD_LOGIC;
         Done        : out STD_LOGIC;
         Product     : out STD_LOGIC_VECTOR(nm+nq-1 downto 0));
end entity MUL;

architecture bhv of MUL is
    component CONTROL is
        generic (nq, nm: INTEGER);
        port (Multiplier: in  unsigned(nq-1 downto 0);
              START     : in  STD_LOGIC;
              A_I       : in  unsigned(nm downto 0);
              Q_I       : in  unsigned(nq-1 downto 0);
              CLK       : in  STD_LOGIC;
              DONE      : out STD_LOGIC;
              PRODUCT   : out unsigned(nq+nm-1 downto 0);
              A_O       : out unsigned(nm downto 0);
              Q_O       : out unsigned(nq-1 downto 0);
              SH        : out STD_LOGIC;
              AD        : out STD_LOGIC);
    end component CONTROL;
    component ADD is
        generic (nq, nm: INTEGER);
        port(A_I  : in  unsigned(nm downto 0);
             M    : in  unsigned(nm-1 downto 0);
             START: in  STD_LOGIC;
             A_O  : out unsigned(nm downto 0));
    end component ADD;
    component SHIFT is
        generic (nq, nm: INTEGER);
        port(A_I  : in  unsigned(nm downto 0);
             Q_I  : in  unsigned(nq-1 downto 0);
             START: in  STD_LOGIC;
             A_O  : out unsigned(nm downto 0);
             Q_O  : out unsigned(nq-1 downto 0));
    end component SHIFT;

    signal A_C       : unsigned(nm downto 0);
    signal Q_C       : unsigned(nq-1 downto 0);
    signal A_A       : unsigned(nm downto 0);
    signal A_S       : unsigned(nm downto 0);
    signal Q_S       : unsigned(nq-1 downto 0);
    signal add_flag  : STD_LOGIC;
    signal shift_flag: STD_LOGIC;
begin
    G1: CONTROL port map(Multiplier => Multiplier, START => Start, A_I => A_C, Q_I => Q_C, CLK => CLK, 
                         DONE => Done, PRODUCT => Product, A_O => A_A, Q_O => Q_S, SH => shift_flag, AD => add_flag);
    G2: ADD     port map(A_I => A_A, M => Multiplicant, START => add_flag, A_O => A_S);
    G3: SHIFT   port map(A_I => A_S, Q_I => Q_S, START => shift_flag, A_O => A_C, Q_O => Q_C);
end architecture bhv;