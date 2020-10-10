library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity MUL is
    generic(nq: INTEGER RANGE 1 TO 15;
            nm: INTEGER RANGE 1 TO 15);
    port(Multiplicand: in  STD_LOGIC_VECTOR(nm-1 downto 0);
         Multiplier  : in  STD_LOGIC_VECTOR(nq-1 downto 0);
         Start       : in  STD_LOGIC;
         CLK         : in  STD_LOGIC;
         Done        : out STD_LOGIC;
         Product     : out STD_LOGIC_VECTOR(nm+nq-1 downto 0));
end entity MUL;

architecture bhv of MUL is
    component CONTROL is
        generic (nq: INTEGER RANGE 1 TO 15;
                 nm: INTEGER RANGE 1 TO 15);
        port (Multiplier: in  STD_LOGIC_VECTOR(nq-1 downto 0);
              START     : in  STD_LOGIC;
              PRODUCT   : out STD_LOGIC_VECTOR(nq+nm-1 downto 0); 
              A_I       : in  UNSIGNED(nm downto 0);
              Q_I       : in  UNSIGNED(nq-1 downto 0);
              CLK       : in  STD_LOGIC;
              DONE      : out STD_LOGIC;
              A_O       : out UNSIGNED(nm downto 0);
              Q_O       : out UNSIGNED(nq-1 downto 0);
              RESET     : out STD_LOGIC;
              SH        : out STD_LOGIC;
              PASS      : out STD_LOGIC;
              AD        : out STD_LOGIC);
    end component CONTROL;
    component ADD is
        generic (nq, nm: INTEGER RANGE 1 TO 15);
        port(A_I  : in  UNSIGNED(nm downto 0);
             M    : in  STD_LOGIC_VECTOR(nm-1 downto 0);
             START: in  STD_LOGIC;
             RESET: in  STD_LOGIC;
             PASS : in  STD_LOGIC;
             A_O  : out UNSIGNED(nm downto 0));
    end component ADD;
    component SHIFT is
        generic (nq, nm: INTEGER RANGE 1 TO 15);
        port(A_I  : in  UNSIGNED(nm downto 0);
             Q_I  : in  UNSIGNED(nq-1 downto 0);
             RESET: in  STD_LOGIC;
             START: in  STD_LOGIC;
             A_O  : out UNSIGNED(nm downto 0);
             Q_O  : out UNSIGNED(nq-1 downto 0));
    end component SHIFT;

    signal A_C       : UNSIGNED(nm downto 0);
    signal Q_C       : UNSIGNED(nq-1 downto 0);
    signal A_A       : UNSIGNED(nm downto 0);
    signal A_S       : UNSIGNED(nm downto 0);
    signal Q_S       : UNSIGNED(nq-1 downto 0);
    signal add_flag  : STD_LOGIC;
    signal shift_flag: STD_LOGIC;
    signal RESET     : STD_LOGIC;
    signal PASS      : STD_LOGIC;
begin
    G1: CONTROL generic map(nq => nq, nm => nm)
                port map(Multiplier => Multiplier, START => Start, A_I => A_C, Q_I => Q_C, CLK => CLK, PASS => PASS, DONE => Done, PRODUCT => Product, A_O => A_A, Q_O => Q_S, RESET => RESET, SH => shift_flag, AD => add_flag);
    G2: ADD     generic map(nq => nq, nm => nm)
                port map(A_I => A_A, M => Multiplicand, START => add_flag, RESET => RESET, A_O => A_S, PASS => PASS);
    G3: SHIFT   generic map(nq => nq, nm => nm)
                port map(A_I => A_S, Q_I => Q_S, RESET => RESET, START => shift_flag, A_O => A_C, Q_O => Q_C);
end architecture bhv;