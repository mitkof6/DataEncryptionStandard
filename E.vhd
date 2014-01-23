library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--cipher function E

entity E is
    Port ( i : in  STD_LOGIC_VECTOR (0 to 31);
           o : out  STD_LOGIC_VECTOR (0 to 47));
end E;

architecture Behavioral of E is

begin
	o <=	i(31) & i(0)  & i(1)  & i(2)  & i(3)  & i(4)  & 
			i(3)  & i(4)  & i(5)  & i(6)  & i(7)  & i(8)  & 
			i(7)  & i(8)  & i(9)  & i(10) & i(11) & i(12) & 
			i(11) & i(12) & i(13) & i(14) & i(15) & i(16) & 
			i(15) & i(16) & i(17) & i(18) & i(19) & i(20) & 
			i(19) & i(20) & i(21) & i(22) & i(23) & i(24) & 
			i(23) & i(24) & i(25) & i(26) & i(27) & i(28) & 
			i(27) & i(28) & i(29) & i(30) & i(31) & i(0);

end Behavioral;

