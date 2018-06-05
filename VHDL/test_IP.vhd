--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:51:00 06/01/2018
-- Design Name:   
-- Module Name:   /home/makinen/Processeur/test_IP.vhd
-- Project Name:  Processeur
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: IP
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
 
ENTITY test_IP IS
END test_IP;
 
ARCHITECTURE behavior OF test_IP IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT IP
    PORT(
         CK : IN  std_logic;
         RST : IN  std_logic;
         INST_ADR : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CK : std_logic := '0';
   signal RST : std_logic := '0';

 	--Outputs
   signal INST_ADR : std_logic_vector(15 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant CK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: IP PORT MAP (
          CK => CK,
          RST => RST,
          INST_ADR => INST_ADR
        );

   -- Clock process definitions
   CK_process :process
   begin
		CK <= '0';
		wait for CK_period/2;
		CK <= '1';
		wait for CK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for CK_period*10;

      -- insert stimulus here
		
		RST <= '1';
		wait for CK_period;
		RST <= '0';
		
		

      wait;
   end process;

END;
