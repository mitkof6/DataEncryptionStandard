library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use WORK.MY_ARRAY.ALL;

entity DES_TOP is
    Port ( dataIn : in  STD_LOGIC_VECTOR (0 to 63);
           key : in  STD_LOGIC_VECTOR (0 to 63);
			  clk, rst, soc : in STD_LOGIC;--clock, reset, start of conversion
			  encrypt : in  STD_LOGIC;--encryption '1' or decryption '0' of data
           dataOut : out  STD_LOGIC_VECTOR (0 to 63);
			  busy, dataReady : out STD_LOGIC);--busy of working and data ready when finish
end DES_TOP;

architecture Behavioral of DES_TOP is

--key schedule
component KEY_SCHEDULE is
    Port ( key : in  STD_LOGIC_VECTOR (0 to 63);
           Kn : out  ARRAY47);
end component;

--main loop
component MAIN_LOOP is
    Port ( Lin : in  STD_LOGIC_VECTOR (0 to 31);
           Rin : in  STD_LOGIC_VECTOR (0 to 31);
           Kn : in  STD_LOGIC_VECTOR (0 to 47);
			 
           Lout : out  STD_LOGIC_VECTOR (0 to 31);
           Rout : out  STD_LOGIC_VECTOR (0 to 31));
			  
end component;

--state
type state is (WAITDATA, ROUND, FINAL);
signal nxState : state;

--counter and key selector
signal counter, keySelector : STD_LOGIC_VECTOR(3 downto 0);

--internal signals
signal Lin_inter, Lout_inter, Rin_inter, Rout_inter : STD_LOGIC_VECTOR(0 to 31); 
signal Kn_inter : ARRAY47;
signal Kn_vec_inter : STD_LOGIC_VECTOR(0 to 47);
signal encryption_int : STD_LOGIC;

begin
	--key schedule
	KS : KEY_SCHEDULE port map(key, Kn_inter);
	
	--main loop
	ML : MAIN_LOOP port map(Lin_inter, Rin_inter, Kn_vec_inter, Lout_inter, Rout_inter);
	
	Kn_vec_inter <= Kn_inter(conv_integer(keySelector));
	
	process(clk, rst)
	
	begin
		if rst = '1' then
			nxState <= WAITDATA;
			counter <= "0000";
			
			busy <= '0';
			dataReady <= '0';
		elsif CLK'EVENT and CLK = '1'then
			case nxState is
				
				when WAITDATA =>
					
					if soc = '0' then
						nxState <= WAITDATA;
					else
						--initial permutation
						Lin_inter <= dataIn(57) & dataIn(49) & dataIn(41) & dataIn(33) & dataIn(25) & dataIn(17) & 
                          dataIn(9)  & dataIn(1)  & dataIn(59) & dataIn(51) & dataIn(43) & dataIn(35) & 
                          dataIn(27) & dataIn(19) & dataIn(11) & dataIn(3)  & dataIn(61) & dataIn(53) & 
                          dataIn(45) & dataIn(37) & dataIn(29) & dataIn(21) & dataIn(13) & dataIn(5)  & 
                          dataIn(63) & dataIn(55) & dataIn(47) & dataIn(39) & dataIn(31) & dataIn(23) & 
                          dataIn(15) & dataIn(7);
 
						Rin_inter <= dataIn(56) & dataIn(48) & dataIn(40) & dataIn(32) & dataIn(24) & dataIn(16) & 
                          dataIn(8)  & dataIn(0)  & dataIn(58) & dataIn(50) & dataIn(42) & dataIn(34) & 
                          dataIn(26) & dataIn(18) & dataIn(10) & dataIn(2)  & dataIn(60) & dataIn(52) & 
                          dataIn(44) & dataIn(36) & dataIn(28) & dataIn(20) & dataIn(12) & dataIn(4)  & 
                          dataIn(62) & dataIn(54) & dataIn(46) & dataIn(38) & dataIn(30) & dataIn(22) & 
                          dataIn(14) & dataIn(6);
							
						--output signals
						busy <= '1';
						
						--state
						nxState <= ROUND;
						counter <= "0000";
						
						--encryption/decryption
						if encrypt = '1' then 
							keySelector <= "0000";
						else
							keySelector <= "1111";
						end if;
						
						--assigne internal to prevent changes
						encryption_int <= encrypt;
					end if;
					
				when ROUND =>
					Lin_inter <= Lout_inter;
					Rin_inter <= Rout_inter;
					
					if encryption_int = '1' then 
						keySelector <= keySelector + '1';
					else
						keySelector <= keySelector - '1';
					end if;
					
					counter <= counter + '1';
					
					if counter = "1111" then
						dataOut <= Lout_inter(7)  & Rout_inter(7)  & Lout_inter(15) & Rout_inter(15) & 
                             Lout_inter(23) & Rout_inter(23) & Lout_inter(31) & Rout_inter(31) & 
                             Lout_inter(6)  & Rout_inter(6)  & Lout_inter(14) & Rout_inter(14) & 
                             Lout_inter(22) & Rout_inter(22) & Lout_inter(30) & Rout_inter(30) & 
                             Lout_inter(5)  & Rout_inter(5)  & Lout_inter(13) & Rout_inter(13) & 
                             Lout_inter(21) & Rout_inter(21) & Lout_inter(29) & Rout_inter(29) & 
                             Lout_inter(4)  & Rout_inter(4)  & Lout_inter(12) & Rout_inter(12) & 
                             Lout_inter(20) & Rout_inter(20) & Lout_inter(28) & Rout_inter(28) & 
                             Lout_inter(3)  & Rout_inter(3)  & Lout_inter(11) & Rout_inter(11) & 
                             Lout_inter(19) & Rout_inter(19) & Lout_inter(27) & Rout_inter(27) & 
                             Lout_inter(2)  & Rout_inter(2)  & Lout_inter(10) & Rout_inter(10) & 
                             Lout_inter(18) & Rout_inter(18) & Lout_inter(26) & Rout_inter(26) & 
                             Lout_inter(1)  & Rout_inter(1)  & Lout_inter(9)  & Rout_inter(9)  & 
                             Lout_inter(17) & Rout_inter(17) & Lout_inter(25) & Rout_inter(25) & 
                             Lout_inter(0)  & Rout_inter(0)  & Lout_inter(8)  & Rout_inter(8)  & 
                             Lout_inter(16) & Rout_inter(16) & Lout_inter(24) & Rout_inter(24);
						nxState <= FINAL;
					else
						nxState <= ROUND;
					end if;
					
				when FINAL =>
					busy <= '0';
					dataReady <= '1';
					nxState <= WAITDATA;
					
			end case;
			
		end if;
		
	end process;

end Behavioral;

