library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity MY_AND2 is
    port(A: in STD_LOGIC;
    	 B: in STD_LOGIC;
         C: out STD_LOGIC);
end MY_AND2;

Architecture and1 of MY_AND2 is
Begin 
    C <= A and B;
End and1;