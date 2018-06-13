--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:16:13 05/29/2018
-- Design Name:   
-- Module Name:   /home/makinen/Processeur/test_processor.vhd
-- Project Name:  Processeur
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Processor
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test_processor IS
END test_processor;
 
ARCHITECTURE behavior OF test_processor IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Processor
    PORT(
			ins_di : IN std_logic_vector(31 downto 0);
         sys_clk : IN  std_logic;
         sys_rst : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal sys_clk : std_logic := '0';
   signal sys_rst : std_logic := '0';
	signal ins_di: std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant sys_clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Processor PORT MAP (
          ins_di => ins_di,
          sys_clk => sys_clk,
          sys_rst => sys_rst
        );

   -- Clock process definitions
   sys_clk_process :process
   begin
		sys_clk <= '0';
		wait for sys_clk_period/2;
		sys_clk <= '1';
		wait for sys_clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      -- Test AFC
		ins_di <= x"06000004"; --AFC r0 x"4"
		wait for sys_clk_period;
		ins_di <= x"0601FFFF"; --AFC r1 x"FFFF"
		
		-- Test COP
		wait for sys_clk_period;
		ins_di <= x"05020000"; --COP [r2]<-[r0]
		
		--Test ADD -- doit attendre que r0 et r2 sont attribués
		wait for sys_clk_period*10;
		ins_di <= x"01030002"; --ADD [r3]<-[r0]+[r2] (4+4)
		
		--Test MUL
		wait for sys_clk_period;
		ins_di <= x"02040002"; --MUL [r4]<-[r0]*[r2] (4*4)
		
		--Test SOU -- doit attendre que r4 est attribué
		wait for sys_clk_period*10;
		ins_di <= x"03050402"; --SOU [r5]<-[r4]-[r2] (16-4)
		
		--TEST STORE -- doit attendre pour qque raison
		wait for sys_clk_period*10;
		ins_di <= x"08000000"; -- STORE @0 <- [r0]
		
		--TEST LOAD -- doit attendre que store est fait
		wait for sys_clk_period*10;
		ins_di <= x"07060000"; -- LOAD [r6] <- @0
		
		--TEST EQU
		--wait for sys_clk_period*10;
		--ins_di <= x"09070002"; -- EQU [r7] <- [r0] == [r2]

      wait;
   end process;

END;
