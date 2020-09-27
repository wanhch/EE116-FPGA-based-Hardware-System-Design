library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity MY_OR2 is
    port(A: in STD_LOGIC;
    	 B: in STD_LOGIC;
         C: out STD_LOGIC);
end MY_OR2;

Architecture or1 of MY_OR2 is
Begin 
    C <= A or B;
End or1;