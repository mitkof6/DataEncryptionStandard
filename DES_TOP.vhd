library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use WORK.MY_ARRAY.ALL;

entity DES_TOP is
    Port ( dataIn : in  STD_LOGIC_VECTOR (0 to 63);
           key : in  STD_LOGIC_VECTOR (0 to 63);
			  clk, rst, soc : in STD_LOGIC;
           dataOut : out  STD_LOGIC_VECTOR (0 to 63);
			  busy, dataReady : out STD_LOGIC);
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
signal Lint_in, Lint_out, Rint_in, Rint_out : STD_LOGIC_VECTOR(0 to 31); 
signal Kn_int : ARRAY47;
signal Kn_vec : STD_LOGIC_VECTOR(0 to 47);

begin
	KS : KEY_SCHEDULE port map(key, Kn_int);
	
	ML : MAIN_LOOP port map(Lint_in, Rint_in, Kn_vec, Lint_out, Rint_out);
	
	Kn_vec <= Kn_int(conv_integer(keySelector));
	
	process(clk, rst)
	
	begin
		if rst = '1' then
			nxState <= WAITDATA;
			counter <= "0000";
			keySelector <= "0000";
			busy <= '0';
			dataReady <= '0';
		elsif CLK'EVENT and CLK = '1'then
			case nxState is
				
				when WAITDATA =>
					
					if soc = '0' then
						nxState <= WAITDATA;
					else
						Lint_in <= dataIn(57) & dataIn(49) & dataIn(41) & dataIn(33) & dataIn(25) & dataIn(17) & 
                          dataIn(9)  & dataIn(1)  & dataIn(59) & dataIn(51) & dataIn(43) & dataIn(35) & 
                          dataIn(27) & dataIn(19) & dataIn(11) & dataIn(3)  & dataIn(61) & dataIn(53) & 
                          dataIn(45) & dataIn(37) & dataIn(29) & dataIn(21) & dataIn(13) & dataIn(5)  & 
                          dataIn(63) & dataIn(55) & dataIn(47) & dataIn(39) & dataIn(31) & dataIn(23) & 
                          dataIn(15) & dataIn(7);
 
						Rint_in <= dataIn(56) & dataIn(48) & dataIn(40) & dataIn(32) & dataIn(24) & dataIn(16) & 
                          dataIn(8)  & dataIn(0)  & dataIn(58) & dataIn(50) & dataIn(42) & dataIn(34) & 
                          dataIn(26) & dataIn(18) & dataIn(10) & dataIn(2)  & dataIn(60) & dataIn(52) & 
                          dataIn(44) & dataIn(36) & dataIn(28) & dataIn(20) & dataIn(12) & dataIn(4)  & 
                          dataIn(62) & dataIn(54) & dataIn(46) & dataIn(38) & dataIn(30) & dataIn(22) & 
                          dataIn(14) & dataIn(6);
																																
						busy <= '1';
						nxState <= ROUND;
						keySelector <= "0000";
						counter <= "0000";
					end if;
					
				when ROUND =>
					Lint_in <= Lint_out;
					Rint_in <= Rint_out;
					
					keySelector <= keySelector + '1';
					counter <= counter + '1';
					
					if counter = "1110" then
						dataOut <= Lint_out(7)  & Rint_out(7)  & Lint_out(15) & Rint_out(15) & 
                             Lint_out(23) & Rint_out(23) & Lint_out(31) & Rint_out(31) & 
                             Lint_out(6)  & Rint_out(6)  & Lint_out(14) & Rint_out(14) & 
                             Lint_out(22) & Rint_out(22) & Lint_out(30) & Rint_out(30) & 
                             Lint_out(5)  & Rint_out(5)  & Lint_out(13) & Rint_out(13) & 
                             Lint_out(21) & Rint_out(21) & Lint_out(29) & Rint_out(29) & 
                             Lint_out(4)  & Rint_out(4)  & Lint_out(12) & Rint_out(12) & 
                             Lint_out(20) & Rint_out(20) & Lint_out(28) & Rint_out(28) & 
                             Lint_out(3)  & Rint_out(3)  & Lint_out(11) & Rint_out(11) & 
                             Lint_out(19) & Rint_out(19) & Lint_out(27) & Rint_out(27) & 
                             Lint_out(2)  & Rint_out(2)  & Lint_out(10) & Rint_out(10) & 
                             Lint_out(18) & Rint_out(18) & Lint_out(26) & Rint_out(26) & 
                             Lint_out(1)  & Rint_out(1)  & Lint_out(9)  & Rint_out(9)  & 
                             Lint_out(17) & Rint_out(17) & Lint_out(25) & Rint_out(25) & 
                             Lint_out(0)  & Rint_out(0)  & Lint_out(8)  & Rint_out(8)  & 
                             Lint_out(16) & Rint_out(16) & Lint_out(24) & Rint_out(24);
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

