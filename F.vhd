library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--chipher function f(R, Kn)

entity F is
    Port ( R : in  STD_LOGIC_VECTOR (0 to 31);
           Kn : in  STD_LOGIC_VECTOR (0 to 47);
           F : out  STD_LOGIC_VECTOR (0 to 31));
end F;

architecture Behavioral of F is

	--expansion
	component E is
		 Port ( i : in  STD_LOGIC_VECTOR (0 to 31);
           o : out  STD_LOGIC_VECTOR (0 to 47));
	end component;
	
	--selection functions
	component S1 is
		Port ( i : in  STD_LOGIC_VECTOR (5 downto 0);
           o : out  STD_LOGIC_VECTOR (3 downto 0));
	end component;
	
	component S2 is
		Port ( i : in  STD_LOGIC_VECTOR (5 downto 0);
           o : out  STD_LOGIC_VECTOR (3 downto 0));
	end component;
	
	component S3 is
		Port ( i : in  STD_LOGIC_VECTOR (5 downto 0);
           o : out  STD_LOGIC_VECTOR (3 downto 0));
	end component;
	
	component S4 is
		Port ( i : in  STD_LOGIC_VECTOR (5 downto 0);
           o : out  STD_LOGIC_VECTOR (3 downto 0));
	end component;
	
	component S5 is
		Port ( i : in  STD_LOGIC_VECTOR (5 downto 0);
           o : out  STD_LOGIC_VECTOR (3 downto 0));
	end component;
	
	component S6 is
		Port ( i : in  STD_LOGIC_VECTOR (5 downto 0);
           o : out  STD_LOGIC_VECTOR (3 downto 0));
	end component;
	
	component S7 is
		Port ( i : in  STD_LOGIC_VECTOR (5 downto 0);
           o : out  STD_LOGIC_VECTOR (3 downto 0));
	end component;
	
	component S8 is
		Port ( i : in  STD_LOGIC_VECTOR (5 downto 0);
           o : out  STD_LOGIC_VECTOR (3 downto 0));
	end component;
	
	--final permutation
	component P is
		Port ( i : in  STD_LOGIC_VECTOR (0 to 31);
           o : out  STD_LOGIC_VECTOR (0 to 31));
	end component;
	
	signal expand : STD_LOGIC_VECTOR(0 to 47);
	signal addMod2 : STD_LOGIC_VECTOR(0 to 47);
	signal sF1, sF2, sF3, sF4, sF5, sF6, sF7, sF8 : STD_LOGIC_VECTOR(0 to 3);
	signal sTotal : STD_LOGIC_VECTOR(0 to 31);
	
begin
	Exp : E port map(R, expand);
	
	addMod2 <= expand xor Kn;
	
	SelF1 : S1 port map(addMod2(0 to 5), sF1);
	SelF2 : S2 port map(addMod2(6 to 11), sF2);
	SelF3 : S3 port map(addMod2(12 to 17), sF3);
	SelF4 : S4 port map(addMod2(18 to 23), sF4);
	SelF5 : S5 port map(addMod2(24 to 29), sF5);
	SelF6 : S6 port map(addMod2(30 to 35), sF6);
	SelF7 : S7 port map(addMod2(36 to 41), sF7);
	SelF8 : S8 port map(addMod2(42 to 47), sF8);

	sTotal <= sF1 & sF2 & sF3 & sF4 & sF5 & sF6 & sF7 & sF8;
	Per : P port map(sTotal, F);
	
end Behavioral;

