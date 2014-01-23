library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--permuted choice 1 of key schedule

entity PC1 is
    Port ( i : in  STD_LOGIC_VECTOR (0 to 63);
           C, D : out  STD_LOGIC_VECTOR (0 to 27));
end PC1;

architecture Behavioral of PC1 is

begin
	C <=	i(56) & i(48) & i(40) & i(32) & i(24) & i(16) & i(8)  & 
			i(0)  & i(57) & i(49) & i(41) & i(33) & i(25) & i(17) & 
			i(9)  & i(1)  & i(58) & i(50) & i(42) & i(34) & i(26) & 
			i(18) & i(10) & i(2)  & i(59) & i(51) & i(43) & i(35);
			
	D <=  i(62) & i(54) & i(46) & i(38) & i(30) & i(22) & i(14) & 
			i(6)  & i(61) & i(53) & i(45) & i(37) & i(29) & i(21) & 
			i(13) & i(5)  & i(60) & i(52) & i(44) & i(36) & i(28) & 
			i(20) & i(12) & i(4)  & i(27) & i(19) & i(11) & i(3);

end Behavioral;

