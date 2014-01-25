library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use WORK.MY_ARRAY.ALL;

--key schedule

entity KEY_SCHEDULE is
    Port ( key : in  STD_LOGIC_VECTOR (0 to 63);
           Kn : out  ARRAY47);
end KEY_SCHEDULE;

architecture Behavioral of KEY_SCHEDULE is

--permuted choice 1
component PC1 is
	Port ( i : in  STD_LOGIC_VECTOR (0 to 63);
           C, D : out  STD_LOGIC_VECTOR (0 to 27));
end component;

--permuted choice 2
component PC2 is
	Port ( i : in  STD_LOGIC_VECTOR (0 to 55);
           o : out  STD_LOGIC_VECTOR (0 to 47));
end component;

--array (0 to 16) of std_logic_vector(0 to 28)
signal C, D : ARRAY28;
	
--array (0 to 15) of std_logic_vector(0 to 55)	
signal CON : ARRAY55;
		
begin

	PerCh10 : PC1 port map(key, C(0),D(0));
	
	--generate C(i) D(i)
	GEN_CD :
	for i in 1 to 16 generate
		GEN_CD_SINGLE:
		if( i = 1 or i = 2 or i = 9 or i = 16) generate
			C(i) <= C(i-1)(1 to 27) & C(i-1)(0);
			D(i) <= D(i-1)(1 to 27) & D(i-1)(0);
		end generate GEN_CD_SINGLE;
		
		GEN_CD_DOUBLE:
		if((i>2 and i<9) or (i>9 and i<16)) generate
			C(i) <= C(i-1)(2 to 27) & C(i-1)(0) & C(i-1)(1);
			D(i) <= D(i-1)(2 to 27) & D(i-1)(0) & C(i-1)(1);
		end generate GEN_CD_DOUBLE;
		
	end generate GEN_CD;
	
	--generate concatenations
	GEN_CON:
	for i in 0 to 15 generate
		CON(i) <= C(i+1) & D(i+1);
	end generate GEN_CON;
	
	--generate K1...K16
	GEN_KEYS :
	for i in 0 to 15 generate
		PerCh2 : PC2 port map(CON(i), Kn(i));
	end generate GEN_KEYS;
	
end Behavioral;

