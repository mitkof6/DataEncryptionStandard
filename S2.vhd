library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--selection function 2

entity S2 is
    Port ( i : in  STD_LOGIC_VECTOR (5 downto 0);
           o : out  STD_LOGIC_VECTOR (3 downto 0));
end S2;

architecture Behavioral of S2 is

begin
	o <=  "1111" when i = "000000" else
			"0001" when i = "000010" else
			"1000" when i = "000100" else
			"1110" when i = "000110" else
			"0110" when i = "001000" else
			"1011" when i = "001010" else
			"0011" when i = "001100" else
			"0100" when i = "001110" else
			"1001" when i = "010000" else
			"0111" when i = "010010" else
			"0010" when i = "010100" else
			"1101" when i = "010110" else
			"1100" when i = "011000" else
			"0000" when i = "011010" else
			"0101" when i = "011100" else
			"1010" when i = "011110" else
			"0011" when i = "000001" else
			"1101" when i = "000011" else
			"0100" when i = "000101" else
			"0111" when i = "000111" else
			"1111" when i = "001001" else
			"0010" when i = "001011" else
			"1000" when i = "001101" else
			"1110" when i = "001111" else
			"1100" when i = "010001" else
			"0000" when i = "010011" else
			"0001" when i = "010101" else
			"1010" when i = "010111" else
			"0110" when i = "011001" else
			"1001" when i = "011011" else
			"1011" when i = "011101" else
			"0101" when i = "011111" else
			"0000" when i = "100000" else
			"1110" when i = "100010" else
			"0111" when i = "100100" else
			"1011" when i = "100110" else
			"1010" when i = "101000" else
			"0100" when i = "101010" else
			"1101" when i = "101100" else
			"0001" when i = "101110" else
			"0101" when i = "110000" else
			"1000" when i = "110010" else
			"1100" when i = "110100" else
			"0110" when i = "110110" else
			"1001" when i = "111000" else
			"0011" when i = "111010" else
			"0010" when i = "111100" else
			"1111" when i = "111110" else
			"1101" when i = "100001" else
			"1000" when i = "100011" else
			"1010" when i = "100101" else
			"0001" when i = "100111" else
			"0011" when i = "101001" else
			"1111" when i = "101011" else
			"0100" when i = "101101" else
			"0010" when i = "101111" else
			"1011" when i = "110001" else
			"0110" when i = "110011" else
			"0111" when i = "110101" else
			"1100" when i = "110111" else
			"0000" when i = "111001" else
			"0101" when i = "111011" else
			"1110" when i = "111101" else
			"1001" when i = "111111" else
			"1001";
	

end Behavioral;

