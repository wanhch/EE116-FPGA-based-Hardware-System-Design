library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity AND_OR is
    port(INP : in STD_LOGIC_VECTOR(3 downto 0);
         OUT1: out STD_LOGIC);
end entity AND_OR;

Architecture and_or1 of AND_OR is
    component MY_AND2 is
        port (A: in STD_LOGIC;
              B: in STD_LOGIC;
              C: out STD_LOGIC);
    end component MY_AND2;
    component MY_OR2 is
        port (A: in STD_LOGIC;
              B: in STD_LOGIC;
              C: out STD_LOGIC);
    end component MY_OR2;   
    signal SIG1, SIG2 : STD_LOGIC;
Begin 
    G1: MY_AND2 port map (A => INP(0), B => INP(1), C => SIG1);
    G2: MY_AND2 port map (A => INP(2), B => INP(3), C => SIG2);
    G3: MY_OR2  port map (A => SIG1,   B => SIG2,   C => OUT1);
End and_or1;
