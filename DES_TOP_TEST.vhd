LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY DES_TOP_TEST IS
END DES_TOP_TEST;
 
ARCHITECTURE behavior OF DES_TOP_TEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DES_TOP
    PORT(
         dataIn : IN  std_logic_vector(0 to 63);
         key : IN  std_logic_vector(0 to 63);
         clk : IN  std_logic;
         rst : IN  std_logic;
         soc : IN  std_logic;
         encrypt : IN  std_logic;
         dataOut : OUT  std_logic_vector(0 to 63);
         busy : OUT  std_logic;
         dataReady : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal dataIn : std_logic_vector(0 to 63) := (others => '0');
   signal key : std_logic_vector(0 to 63) := (others => '0');
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal soc : std_logic := '0';
   signal encrypt : std_logic := '0';

 	--Outputs
   signal dataOut : std_logic_vector(0 to 63);
   signal busy : std_logic;
   signal dataReady : std_logic;

   -- Clock period definitions
   constant clk_period : time := 1 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DES_TOP PORT MAP (
          dataIn => dataIn,
          key => key,
          clk => clk,
          rst => rst,
          soc => soc,
          encrypt => encrypt,
          dataOut => dataOut,
          busy => busy,
          dataReady => dataReady
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		--encryption
      key <= x"10316E028C8F3B4A";
		dataIn <= x"0000000000000000";
		encrypt <= '1';
		
		rst <= '1';
      wait for 2 ns;	
		
		rst <= '0';
		soc <= '1';
      wait for clk_period*10;
		soc <= '0';
		encrypt <= '0';
		wait for clk_period*7;
		
		--decryption
		dataIn <= x"82dcbafbdeab6602";
		soc <= '1';
		wait for clk_period*10;
		soc <= '0';
		
		wait for clk_period*10;
		
      
		

      wait;
   end process;

END;
