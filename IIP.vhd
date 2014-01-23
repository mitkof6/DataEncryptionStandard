library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--inverse initial permuntation

entity IIP is
    Port ( i : in  STD_LOGIC_VECTOR (0 to 63);
           o : out  STD_LOGIC_VECTOR (0 to 63));
end IIP;

architecture Behavioral of IIP is

begin
	o <=	i(39) & i(7) & i(47) & i(15) & i(55) & i(23) & i(63) & i(31) & 
			i(38) & i(6) & i(46) & i(14) & i(54) & i(22) & i(62) & i(30) & 
			i(37) & i(5) & i(45) & i(13) & i(53) & i(21) & i(61) & i(29) & 
			i(36) & i(4) & i(44) & i(12) & i(52) & i(20) & i(60) & i(28) & 
			i(35) & i(3) & i(43) & i(11) & i(51) & i(19) & i(59) & i(27) & 
			i(34) & i(2) & i(42) & i(10) & i(50) & i(18) & i(58) & i(26) & 
			i(33) & i(1) & i(41) & i(9)  & i(49) & i(17) & i(57) & i(25) & 
			i(32) & i(0) & i(40) & i(8)  & i(48) & i(16) & i(56) & i(24);
			
end Behavioral;

