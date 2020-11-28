library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package util_package is
    type RcLine is array(1 to 10) of UNSIGNED(31 downto 0);
    constant Rc: RcLine := (TO_UNSIGNED(16#01000000#, 32), TO_UNSIGNED(16#02000000#, 32), TO_UNSIGNED(16#04000000#, 32), TO_UNSIGNED(16#08000000#, 32), TO_UNSIGNED(16#10000000#, 32), TO_UNSIGNED(16#20000000#, 32), TO_UNSIGNED(16#40000000#, 32), TO_UNSIGNED(-2147483648, 32), TO_UNSIGNED(16#1b000000#, 32), TO_UNSIGNED(16#36000000#, 32)); 

    type SboxLine is array(0 to 15) of UNSIGNED(7 downto 0);
    type SboxMatrix is array(0 to 15) of SboxLine;
    constant SubBytes_Table: SboxMatrix := (
        (TO_UNSIGNED(16#63#, 8), TO_UNSIGNED(16#7c#, 8), TO_UNSIGNED(16#77#, 8), TO_UNSIGNED(16#7b#, 8), TO_UNSIGNED(16#f2#, 8), TO_UNSIGNED(16#6b#, 8), TO_UNSIGNED(16#6f#, 8), TO_UNSIGNED(16#c5#, 8), TO_UNSIGNED(16#30#, 8), TO_UNSIGNED(16#01#, 8), TO_UNSIGNED(16#67#, 8), TO_UNSIGNED(16#2b#, 8), TO_UNSIGNED(16#fe#, 8), TO_UNSIGNED(16#d7#, 8), TO_UNSIGNED(16#ab#, 8), TO_UNSIGNED(16#76#, 8)),
        (TO_UNSIGNED(16#ca#, 8), TO_UNSIGNED(16#82#, 8), TO_UNSIGNED(16#c9#, 8), TO_UNSIGNED(16#7d#, 8), TO_UNSIGNED(16#fa#, 8), TO_UNSIGNED(16#59#, 8), TO_UNSIGNED(16#47#, 8), TO_UNSIGNED(16#f0#, 8), TO_UNSIGNED(16#ad#, 8), TO_UNSIGNED(16#d4#, 8), TO_UNSIGNED(16#a2#, 8), TO_UNSIGNED(16#af#, 8), TO_UNSIGNED(16#9c#, 8), TO_UNSIGNED(16#a4#, 8), TO_UNSIGNED(16#72#, 8), TO_UNSIGNED(16#c0#, 8)),
        (TO_UNSIGNED(16#b7#, 8), TO_UNSIGNED(16#fd#, 8), TO_UNSIGNED(16#93#, 8), TO_UNSIGNED(16#26#, 8), TO_UNSIGNED(16#36#, 8), TO_UNSIGNED(16#3f#, 8), TO_UNSIGNED(16#f7#, 8), TO_UNSIGNED(16#cc#, 8), TO_UNSIGNED(16#34#, 8), TO_UNSIGNED(16#a5#, 8), TO_UNSIGNED(16#e5#, 8), TO_UNSIGNED(16#f1#, 8), TO_UNSIGNED(16#71#, 8), TO_UNSIGNED(16#d8#, 8), TO_UNSIGNED(16#31#, 8), TO_UNSIGNED(16#15#, 8)),
        (TO_UNSIGNED(16#04#, 8), TO_UNSIGNED(16#c7#, 8), TO_UNSIGNED(16#23#, 8), TO_UNSIGNED(16#c3#, 8), TO_UNSIGNED(16#18#, 8), TO_UNSIGNED(16#96#, 8), TO_UNSIGNED(16#05#, 8), TO_UNSIGNED(16#9a#, 8), TO_UNSIGNED(16#07#, 8), TO_UNSIGNED(16#12#, 8), TO_UNSIGNED(16#80#, 8), TO_UNSIGNED(16#e2#, 8), TO_UNSIGNED(16#eb#, 8), TO_UNSIGNED(16#27#, 8), TO_UNSIGNED(16#b2#, 8), TO_UNSIGNED(16#75#, 8)),
        (TO_UNSIGNED(16#09#, 8), TO_UNSIGNED(16#83#, 8), TO_UNSIGNED(16#2c#, 8), TO_UNSIGNED(16#1a#, 8), TO_UNSIGNED(16#1b#, 8), TO_UNSIGNED(16#6e#, 8), TO_UNSIGNED(16#5a#, 8), TO_UNSIGNED(16#a0#, 8), TO_UNSIGNED(16#52#, 8), TO_UNSIGNED(16#3b#, 8), TO_UNSIGNED(16#d6#, 8), TO_UNSIGNED(16#b3#, 8), TO_UNSIGNED(16#29#, 8), TO_UNSIGNED(16#e3#, 8), TO_UNSIGNED(16#2f#, 8), TO_UNSIGNED(16#84#, 8)),
        (TO_UNSIGNED(16#53#, 8), TO_UNSIGNED(16#d1#, 8), TO_UNSIGNED(16#00#, 8), TO_UNSIGNED(16#ed#, 8), TO_UNSIGNED(16#20#, 8), TO_UNSIGNED(16#fc#, 8), TO_UNSIGNED(16#b1#, 8), TO_UNSIGNED(16#5b#, 8), TO_UNSIGNED(16#6a#, 8), TO_UNSIGNED(16#cb#, 8), TO_UNSIGNED(16#be#, 8), TO_UNSIGNED(16#39#, 8), TO_UNSIGNED(16#4a#, 8), TO_UNSIGNED(16#4c#, 8), TO_UNSIGNED(16#58#, 8), TO_UNSIGNED(16#cf#, 8)),
        (TO_UNSIGNED(16#d0#, 8), TO_UNSIGNED(16#ef#, 8), TO_UNSIGNED(16#aa#, 8), TO_UNSIGNED(16#fb#, 8), TO_UNSIGNED(16#43#, 8), TO_UNSIGNED(16#4d#, 8), TO_UNSIGNED(16#33#, 8), TO_UNSIGNED(16#85#, 8), TO_UNSIGNED(16#45#, 8), TO_UNSIGNED(16#f9#, 8), TO_UNSIGNED(16#02#, 8), TO_UNSIGNED(16#7f#, 8), TO_UNSIGNED(16#50#, 8), TO_UNSIGNED(16#3c#, 8), TO_UNSIGNED(16#9f#, 8), TO_UNSIGNED(16#a8#, 8)),
        (TO_UNSIGNED(16#51#, 8), TO_UNSIGNED(16#a3#, 8), TO_UNSIGNED(16#40#, 8), TO_UNSIGNED(16#8f#, 8), TO_UNSIGNED(16#92#, 8), TO_UNSIGNED(16#9d#, 8), TO_UNSIGNED(16#38#, 8), TO_UNSIGNED(16#f5#, 8), TO_UNSIGNED(16#bc#, 8), TO_UNSIGNED(16#b6#, 8), TO_UNSIGNED(16#da#, 8), TO_UNSIGNED(16#21#, 8), TO_UNSIGNED(16#10#, 8), TO_UNSIGNED(16#ff#, 8), TO_UNSIGNED(16#f3#, 8), TO_UNSIGNED(16#d2#, 8)),
        (TO_UNSIGNED(16#cd#, 8), TO_UNSIGNED(16#0c#, 8), TO_UNSIGNED(16#13#, 8), TO_UNSIGNED(16#ec#, 8), TO_UNSIGNED(16#5f#, 8), TO_UNSIGNED(16#97#, 8), TO_UNSIGNED(16#44#, 8), TO_UNSIGNED(16#17#, 8), TO_UNSIGNED(16#c4#, 8), TO_UNSIGNED(16#a7#, 8), TO_UNSIGNED(16#7e#, 8), TO_UNSIGNED(16#3d#, 8), TO_UNSIGNED(16#64#, 8), TO_UNSIGNED(16#5d#, 8), TO_UNSIGNED(16#19#, 8), TO_UNSIGNED(16#73#, 8)),
        (TO_UNSIGNED(16#60#, 8), TO_UNSIGNED(16#81#, 8), TO_UNSIGNED(16#4f#, 8), TO_UNSIGNED(16#dc#, 8), TO_UNSIGNED(16#22#, 8), TO_UNSIGNED(16#2a#, 8), TO_UNSIGNED(16#90#, 8), TO_UNSIGNED(16#88#, 8), TO_UNSIGNED(16#46#, 8), TO_UNSIGNED(16#ee#, 8), TO_UNSIGNED(16#b8#, 8), TO_UNSIGNED(16#14#, 8), TO_UNSIGNED(16#de#, 8), TO_UNSIGNED(16#5e#, 8), TO_UNSIGNED(16#0b#, 8), TO_UNSIGNED(16#db#, 8)),
        (TO_UNSIGNED(16#e0#, 8), TO_UNSIGNED(16#32#, 8), TO_UNSIGNED(16#3a#, 8), TO_UNSIGNED(16#0a#, 8), TO_UNSIGNED(16#49#, 8), TO_UNSIGNED(16#06#, 8), TO_UNSIGNED(16#24#, 8), TO_UNSIGNED(16#5c#, 8), TO_UNSIGNED(16#c2#, 8), TO_UNSIGNED(16#d3#, 8), TO_UNSIGNED(16#ac#, 8), TO_UNSIGNED(16#62#, 8), TO_UNSIGNED(16#91#, 8), TO_UNSIGNED(16#95#, 8), TO_UNSIGNED(16#e4#, 8), TO_UNSIGNED(16#79#, 8)),
        (TO_UNSIGNED(16#e7#, 8), TO_UNSIGNED(16#c8#, 8), TO_UNSIGNED(16#37#, 8), TO_UNSIGNED(16#6d#, 8), TO_UNSIGNED(16#8d#, 8), TO_UNSIGNED(16#d5#, 8), TO_UNSIGNED(16#4e#, 8), TO_UNSIGNED(16#a9#, 8), TO_UNSIGNED(16#6c#, 8), TO_UNSIGNED(16#56#, 8), TO_UNSIGNED(16#f4#, 8), TO_UNSIGNED(16#ea#, 8), TO_UNSIGNED(16#65#, 8), TO_UNSIGNED(16#7a#, 8), TO_UNSIGNED(16#ae#, 8), TO_UNSIGNED(16#08#, 8)),
        (TO_UNSIGNED(16#ba#, 8), TO_UNSIGNED(16#78#, 8), TO_UNSIGNED(16#25#, 8), TO_UNSIGNED(16#2e#, 8), TO_UNSIGNED(16#1c#, 8), TO_UNSIGNED(16#a6#, 8), TO_UNSIGNED(16#b4#, 8), TO_UNSIGNED(16#c6#, 8), TO_UNSIGNED(16#e8#, 8), TO_UNSIGNED(16#dd#, 8), TO_UNSIGNED(16#74#, 8), TO_UNSIGNED(16#1f#, 8), TO_UNSIGNED(16#4b#, 8), TO_UNSIGNED(16#bd#, 8), TO_UNSIGNED(16#8b#, 8), TO_UNSIGNED(16#8a#, 8)),
        (TO_UNSIGNED(16#70#, 8), TO_UNSIGNED(16#3e#, 8), TO_UNSIGNED(16#b5#, 8), TO_UNSIGNED(16#66#, 8), TO_UNSIGNED(16#48#, 8), TO_UNSIGNED(16#03#, 8), TO_UNSIGNED(16#f6#, 8), TO_UNSIGNED(16#0e#, 8), TO_UNSIGNED(16#61#, 8), TO_UNSIGNED(16#35#, 8), TO_UNSIGNED(16#57#, 8), TO_UNSIGNED(16#b9#, 8), TO_UNSIGNED(16#86#, 8), TO_UNSIGNED(16#c1#, 8), TO_UNSIGNED(16#1d#, 8), TO_UNSIGNED(16#9e#, 8)),
        (TO_UNSIGNED(16#e1#, 8), TO_UNSIGNED(16#f8#, 8), TO_UNSIGNED(16#98#, 8), TO_UNSIGNED(16#11#, 8), TO_UNSIGNED(16#69#, 8), TO_UNSIGNED(16#d9#, 8), TO_UNSIGNED(16#8e#, 8), TO_UNSIGNED(16#94#, 8), TO_UNSIGNED(16#9b#, 8), TO_UNSIGNED(16#1e#, 8), TO_UNSIGNED(16#87#, 8), TO_UNSIGNED(16#e9#, 8), TO_UNSIGNED(16#ce#, 8), TO_UNSIGNED(16#55#, 8), TO_UNSIGNED(16#28#, 8), TO_UNSIGNED(16#df#, 8)),
        (TO_UNSIGNED(16#8c#, 8), TO_UNSIGNED(16#a1#, 8), TO_UNSIGNED(16#89#, 8), TO_UNSIGNED(16#0d#, 8), TO_UNSIGNED(16#bf#, 8), TO_UNSIGNED(16#e6#, 8), TO_UNSIGNED(16#42#, 8), TO_UNSIGNED(16#68#, 8), TO_UNSIGNED(16#41#, 8), TO_UNSIGNED(16#99#, 8), TO_UNSIGNED(16#2d#, 8), TO_UNSIGNED(16#0f#, 8), TO_UNSIGNED(16#b0#, 8), TO_UNSIGNED(16#54#, 8), TO_UNSIGNED(16#bb#, 8), TO_UNSIGNED(16#16#, 8)));
    constant invSubBytes_Table: SboxMatrix := (
        (TO_UNSIGNED(16#52#, 8), TO_UNSIGNED(16#09#, 8), TO_UNSIGNED(16#6a#, 8), TO_UNSIGNED(16#d5#, 8), TO_UNSIGNED(16#30#, 8), TO_UNSIGNED(16#36#, 8), TO_UNSIGNED(16#a5#, 8), TO_UNSIGNED(16#38#, 8), TO_UNSIGNED(16#bf#, 8), TO_UNSIGNED(16#40#, 8), TO_UNSIGNED(16#a3#, 8), TO_UNSIGNED(16#9e#, 8), TO_UNSIGNED(16#81#, 8), TO_UNSIGNED(16#f3#, 8), TO_UNSIGNED(16#d7#, 8), TO_UNSIGNED(16#fb#, 8)),
        (TO_UNSIGNED(16#7c#, 8), TO_UNSIGNED(16#e3#, 8), TO_UNSIGNED(16#39#, 8), TO_UNSIGNED(16#82#, 8), TO_UNSIGNED(16#9b#, 8), TO_UNSIGNED(16#2f#, 8), TO_UNSIGNED(16#ff#, 8), TO_UNSIGNED(16#87#, 8), TO_UNSIGNED(16#34#, 8), TO_UNSIGNED(16#8e#, 8), TO_UNSIGNED(16#43#, 8), TO_UNSIGNED(16#44#, 8), TO_UNSIGNED(16#c4#, 8), TO_UNSIGNED(16#de#, 8), TO_UNSIGNED(16#e9#, 8), TO_UNSIGNED(16#cb#, 8)),
        (TO_UNSIGNED(16#54#, 8), TO_UNSIGNED(16#7b#, 8), TO_UNSIGNED(16#94#, 8), TO_UNSIGNED(16#32#, 8), TO_UNSIGNED(16#a6#, 8), TO_UNSIGNED(16#c2#, 8), TO_UNSIGNED(16#23#, 8), TO_UNSIGNED(16#3d#, 8), TO_UNSIGNED(16#ee#, 8), TO_UNSIGNED(16#4c#, 8), TO_UNSIGNED(16#95#, 8), TO_UNSIGNED(16#0b#, 8), TO_UNSIGNED(16#42#, 8), TO_UNSIGNED(16#fa#, 8), TO_UNSIGNED(16#c3#, 8), TO_UNSIGNED(16#4e#, 8)),
        (TO_UNSIGNED(16#08#, 8), TO_UNSIGNED(16#2e#, 8), TO_UNSIGNED(16#a1#, 8), TO_UNSIGNED(16#66#, 8), TO_UNSIGNED(16#28#, 8), TO_UNSIGNED(16#d9#, 8), TO_UNSIGNED(16#24#, 8), TO_UNSIGNED(16#b2#, 8), TO_UNSIGNED(16#76#, 8), TO_UNSIGNED(16#5b#, 8), TO_UNSIGNED(16#a2#, 8), TO_UNSIGNED(16#49#, 8), TO_UNSIGNED(16#6d#, 8), TO_UNSIGNED(16#8b#, 8), TO_UNSIGNED(16#d1#, 8), TO_UNSIGNED(16#25#, 8)),
        (TO_UNSIGNED(16#72#, 8), TO_UNSIGNED(16#f8#, 8), TO_UNSIGNED(16#f6#, 8), TO_UNSIGNED(16#64#, 8), TO_UNSIGNED(16#86#, 8), TO_UNSIGNED(16#68#, 8), TO_UNSIGNED(16#98#, 8), TO_UNSIGNED(16#16#, 8), TO_UNSIGNED(16#d4#, 8), TO_UNSIGNED(16#a4#, 8), TO_UNSIGNED(16#5c#, 8), TO_UNSIGNED(16#cc#, 8), TO_UNSIGNED(16#5d#, 8), TO_UNSIGNED(16#65#, 8), TO_UNSIGNED(16#b6#, 8), TO_UNSIGNED(16#92#, 8)),
        (TO_UNSIGNED(16#6c#, 8), TO_UNSIGNED(16#70#, 8), TO_UNSIGNED(16#48#, 8), TO_UNSIGNED(16#50#, 8), TO_UNSIGNED(16#fd#, 8), TO_UNSIGNED(16#ed#, 8), TO_UNSIGNED(16#b9#, 8), TO_UNSIGNED(16#da#, 8), TO_UNSIGNED(16#5e#, 8), TO_UNSIGNED(16#15#, 8), TO_UNSIGNED(16#46#, 8), TO_UNSIGNED(16#57#, 8), TO_UNSIGNED(16#a7#, 8), TO_UNSIGNED(16#8d#, 8), TO_UNSIGNED(16#9d#, 8), TO_UNSIGNED(16#84#, 8)),
        (TO_UNSIGNED(16#90#, 8), TO_UNSIGNED(16#d8#, 8), TO_UNSIGNED(16#ab#, 8), TO_UNSIGNED(16#00#, 8), TO_UNSIGNED(16#8c#, 8), TO_UNSIGNED(16#bc#, 8), TO_UNSIGNED(16#d3#, 8), TO_UNSIGNED(16#0a#, 8), TO_UNSIGNED(16#f7#, 8), TO_UNSIGNED(16#e4#, 8), TO_UNSIGNED(16#58#, 8), TO_UNSIGNED(16#05#, 8), TO_UNSIGNED(16#b8#, 8), TO_UNSIGNED(16#b3#, 8), TO_UNSIGNED(16#45#, 8), TO_UNSIGNED(16#06#, 8)),
        (TO_UNSIGNED(16#d0#, 8), TO_UNSIGNED(16#2c#, 8), TO_UNSIGNED(16#1e#, 8), TO_UNSIGNED(16#8f#, 8), TO_UNSIGNED(16#ca#, 8), TO_UNSIGNED(16#3f#, 8), TO_UNSIGNED(16#0f#, 8), TO_UNSIGNED(16#02#, 8), TO_UNSIGNED(16#c1#, 8), TO_UNSIGNED(16#af#, 8), TO_UNSIGNED(16#bd#, 8), TO_UNSIGNED(16#03#, 8), TO_UNSIGNED(16#01#, 8), TO_UNSIGNED(16#13#, 8), TO_UNSIGNED(16#8a#, 8), TO_UNSIGNED(16#6b#, 8)),
        (TO_UNSIGNED(16#3a#, 8), TO_UNSIGNED(16#91#, 8), TO_UNSIGNED(16#11#, 8), TO_UNSIGNED(16#41#, 8), TO_UNSIGNED(16#4f#, 8), TO_UNSIGNED(16#67#, 8), TO_UNSIGNED(16#dc#, 8), TO_UNSIGNED(16#ea#, 8), TO_UNSIGNED(16#97#, 8), TO_UNSIGNED(16#f2#, 8), TO_UNSIGNED(16#cf#, 8), TO_UNSIGNED(16#ce#, 8), TO_UNSIGNED(16#f0#, 8), TO_UNSIGNED(16#b4#, 8), TO_UNSIGNED(16#e6#, 8), TO_UNSIGNED(16#73#, 8)),
        (TO_UNSIGNED(16#96#, 8), TO_UNSIGNED(16#ac#, 8), TO_UNSIGNED(16#74#, 8), TO_UNSIGNED(16#22#, 8), TO_UNSIGNED(16#e7#, 8), TO_UNSIGNED(16#ad#, 8), TO_UNSIGNED(16#35#, 8), TO_UNSIGNED(16#85#, 8), TO_UNSIGNED(16#e2#, 8), TO_UNSIGNED(16#f9#, 8), TO_UNSIGNED(16#37#, 8), TO_UNSIGNED(16#e8#, 8), TO_UNSIGNED(16#1c#, 8), TO_UNSIGNED(16#75#, 8), TO_UNSIGNED(16#df#, 8), TO_UNSIGNED(16#6e#, 8)),
        (TO_UNSIGNED(16#47#, 8), TO_UNSIGNED(16#f1#, 8), TO_UNSIGNED(16#1a#, 8), TO_UNSIGNED(16#71#, 8), TO_UNSIGNED(16#1d#, 8), TO_UNSIGNED(16#29#, 8), TO_UNSIGNED(16#c5#, 8), TO_UNSIGNED(16#89#, 8), TO_UNSIGNED(16#6f#, 8), TO_UNSIGNED(16#b7#, 8), TO_UNSIGNED(16#62#, 8), TO_UNSIGNED(16#0e#, 8), TO_UNSIGNED(16#aa#, 8), TO_UNSIGNED(16#18#, 8), TO_UNSIGNED(16#be#, 8), TO_UNSIGNED(16#1b#, 8)),
        (TO_UNSIGNED(16#fc#, 8), TO_UNSIGNED(16#56#, 8), TO_UNSIGNED(16#3e#, 8), TO_UNSIGNED(16#4b#, 8), TO_UNSIGNED(16#c6#, 8), TO_UNSIGNED(16#d2#, 8), TO_UNSIGNED(16#79#, 8), TO_UNSIGNED(16#20#, 8), TO_UNSIGNED(16#9a#, 8), TO_UNSIGNED(16#db#, 8), TO_UNSIGNED(16#c0#, 8), TO_UNSIGNED(16#fe#, 8), TO_UNSIGNED(16#78#, 8), TO_UNSIGNED(16#cd#, 8), TO_UNSIGNED(16#5a#, 8), TO_UNSIGNED(16#f4#, 8)),
        (TO_UNSIGNED(16#1f#, 8), TO_UNSIGNED(16#dd#, 8), TO_UNSIGNED(16#a8#, 8), TO_UNSIGNED(16#33#, 8), TO_UNSIGNED(16#88#, 8), TO_UNSIGNED(16#07#, 8), TO_UNSIGNED(16#c7#, 8), TO_UNSIGNED(16#31#, 8), TO_UNSIGNED(16#b1#, 8), TO_UNSIGNED(16#12#, 8), TO_UNSIGNED(16#10#, 8), TO_UNSIGNED(16#59#, 8), TO_UNSIGNED(16#27#, 8), TO_UNSIGNED(16#80#, 8), TO_UNSIGNED(16#ec#, 8), TO_UNSIGNED(16#5f#, 8)),
        (TO_UNSIGNED(16#60#, 8), TO_UNSIGNED(16#51#, 8), TO_UNSIGNED(16#7f#, 8), TO_UNSIGNED(16#a9#, 8), TO_UNSIGNED(16#19#, 8), TO_UNSIGNED(16#b5#, 8), TO_UNSIGNED(16#4a#, 8), TO_UNSIGNED(16#0d#, 8), TO_UNSIGNED(16#2d#, 8), TO_UNSIGNED(16#e5#, 8), TO_UNSIGNED(16#7a#, 8), TO_UNSIGNED(16#9f#, 8), TO_UNSIGNED(16#93#, 8), TO_UNSIGNED(16#c9#, 8), TO_UNSIGNED(16#9c#, 8), TO_UNSIGNED(16#ef#, 8)),
        (TO_UNSIGNED(16#a0#, 8), TO_UNSIGNED(16#e0#, 8), TO_UNSIGNED(16#3b#, 8), TO_UNSIGNED(16#4d#, 8), TO_UNSIGNED(16#ae#, 8), TO_UNSIGNED(16#2a#, 8), TO_UNSIGNED(16#f5#, 8), TO_UNSIGNED(16#b0#, 8), TO_UNSIGNED(16#c8#, 8), TO_UNSIGNED(16#eb#, 8), TO_UNSIGNED(16#bb#, 8), TO_UNSIGNED(16#3c#, 8), TO_UNSIGNED(16#83#, 8), TO_UNSIGNED(16#53#, 8), TO_UNSIGNED(16#99#, 8), TO_UNSIGNED(16#61#, 8)),
        (TO_UNSIGNED(16#17#, 8), TO_UNSIGNED(16#2b#, 8), TO_UNSIGNED(16#04#, 8), TO_UNSIGNED(16#7e#, 8), TO_UNSIGNED(16#ba#, 8), TO_UNSIGNED(16#77#, 8), TO_UNSIGNED(16#d6#, 8), TO_UNSIGNED(16#26#, 8), TO_UNSIGNED(16#e1#, 8), TO_UNSIGNED(16#69#, 8), TO_UNSIGNED(16#14#, 8), TO_UNSIGNED(16#63#, 8), TO_UNSIGNED(16#55#, 8), TO_UNSIGNED(16#21#, 8), TO_UNSIGNED(16#0c#, 8), TO_UNSIGNED(16#7d#, 8))); 

    function gmult(a: STD_LOGIC_VECTOR(7 downto 0); b: STD_LOGIC_VECTOR(7 downto 0)) return STD_LOGIC_VECTOR;
end util_package;

package body util_package is

function gmult(a: STD_LOGIC_VECTOR(7 downto 0); b: STD_LOGIC_VECTOR(7 downto 0)) return STD_LOGIC_VECTOR is
    variable p: STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    variable hbs: STD_LOGIC := '0';
    variable aa: STD_LOGIC_VECTOR(7 downto 0) := a;
    variable bb:  STD_LOGIC_VECTOR(7 downto 0) := b;
begin
    for idx in 0 to 7 loop
        if (b(0) = '1') then
            p := p xor a;
        end if;
        hbs := a(7);
        aa(7 downto 0) := aa(6 downto 0) & '0';
        if (hbs = '1') then 
            aa := aa xor STD_LOGIC_VECTOR(TO_UNSIGNED(16#1b#, 8));
        end if;
        bb := '0' & bb(7 downto 1);
    end loop;
    return p;
end function;

end package body util_package;