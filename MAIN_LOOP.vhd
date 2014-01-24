library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MAIN_LOOP is
    Port ( L : in  STD_LOGIC_VECTOR (0 to 31);
           R : in  STD_LOGIC_VECTOR (0 to 31);
           KN : in  STD_LOGIC_VECTOR (0 to 47);
			  CLK, RST, EN : in STD_LOGIC;
           LF : out  STD_LOGIC_VECTOR (0 to 31);
           RF : out  STD_LOGIC_VECTOR (0 to 31);
			  RDY : out STD_LOGIC);
end MAIN_LOOP;

architecture Behavioral of MAIN_LOOP is

component F is
	Port ( R : in  STD_LOGIC_VECTOR (0 to 31);
           Kn : in  STD_LOGIC_VECTOR (0 to 47);
           F : out  STD_LOGIC_VECTOR (0 to 31));
end component;

signal tempR, tempF : STD_LOGIC_VECTOR(0 to 31);

begin
	--cipher function
	Fun : F port map(tempR, KN, tempF);
	
	process(CLK, RST, EN)
		variable leftFF, rightFF : STD_LOGIC_VECTOR(0 to 31);
		
		variable counter : INTEGER range 0 to 16 := 0;
		begin
		
			if RST = '1' then
				leftFF := (others => '0');
				rightFF := (others => '0');
				counter := 0;
				
				LF <= (others => '0');
				RF <= (others => '0');
				RDY <= '0';
			elsif CLK'EVENT and CLK = '1' and EN = '1' then
				if counter = 0 then
					leftFF := L;
					rightFF := R;
				elsif counter = 16 then
					counter := 0;
					
					RF <= leftFF xor tempF;
					LF <= tempR;
					
					RDY <= '1';
				else
					rightFF := leftFF xor tempF;
					leftFF := tempR;
				end if;
				
				tempR <= rightFF;
				
				counter := counter + 1;
				
			end if;
	end process;

end Behavioral;

