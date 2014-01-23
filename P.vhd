library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--cipher function P

entity P is
    Port ( i : in  STD_LOGIC_VECTOR (0 to 31);
           o : out  STD_LOGIC_VECTOR (0 to 31));
end P;

architecture Behavioral of P is

begin
	o <=	i(15) & i(6)  & i(19) & i(20) & 
			i(28) & i(11) & i(27) & i(16) & 
			i(0)  & i(14) & i(22) & i(25) & 
			i(4)  & i(17) & i(30) & i(9) & 
			i(1)  & i(7)  & i(23) & i(13) & 
			i(31) & i(26) & i(2)  & i(8) & 
			i(18) & i(12) & i(29) & i(5) & 
			i(21) & i(10) & i(3)  & i(24);


end Behavioral;

