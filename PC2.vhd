library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--permuted choice 2 of key schedule

entity PC2 is
    Port ( i : in  STD_LOGIC_VECTOR (0 to 55);
           o : out  STD_LOGIC_VECTOR (0 to 47));
end PC2;

architecture Behavioral of PC2 is

begin


	o <=	i(13) & i(16) & i(10) & i(23) & i(0)  & i(4)  & 
			i(2)  & i(27) & i(14) & i(5)  & i(20) & i(9)  & 
			i(22) & i(18) & i(11) & i(3)  & i(25) & i(7)  & 
			i(15) & i(6)  & i(26) & i(19) & i(12) & i(1)  & 
			i(40) & i(51) & i(30) & i(36) & i(46) & i(54) & 
			i(29) & i(39) & i(50) & i(44) & i(32) & i(47) & 
			i(43) & i(48) & i(38) & i(55) & i(33) & i(52) & 
			i(45) & i(41) & i(49) & i(35) & i(28) & i(31); 

end Behavioral;

