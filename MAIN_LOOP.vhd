library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--internal loop

entity MAIN_LOOP is
    Port ( Lin : in  STD_LOGIC_VECTOR (0 to 31);
           Rin : in  STD_LOGIC_VECTOR (0 to 31);
           Kn : in  STD_LOGIC_VECTOR (0 to 47);
			 
           Lout : out  STD_LOGIC_VECTOR (0 to 31);
           Rout : out  STD_LOGIC_VECTOR (0 to 31));
			  
end MAIN_LOOP;

architecture Behavioral of MAIN_LOOP is

component F is
	Port ( R : in  STD_LOGIC_VECTOR (0 to 31);
           Kn : in  STD_LOGIC_VECTOR (0 to 47);
           F : out  STD_LOGIC_VECTOR (0 to 31));
end component;

signal Fout : STD_LOGIC_VECTOR(0 to 31);

begin
	--cipher function
	Fun : F port map(Rin, Kn, Fout);
	
	Lout <= Rin;
	Rout <= Lin xor Fout;
	

end Behavioral;

