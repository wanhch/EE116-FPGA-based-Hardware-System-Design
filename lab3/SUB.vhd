library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

entity SUB is
   port(A : in  STD_LOGIC_VECTOR (6 downto 0);
        B : in  STD_LOGIC_VECTOR (6 downto 0);
        Q : out STD_LOGIC_VECTOR (6 downto 0));
end SUB;

architecture bhv of SUB is
begin
    Q <= A - B;
end bhv;
