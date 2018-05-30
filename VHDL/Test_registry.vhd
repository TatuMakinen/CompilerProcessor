--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:19:53 05/15/2018
-- Design Name:   
-- Module Name:   /home/makinen/Processeur/Test_registry.vhd
-- Project Name:  Processeur
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Registery
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
 
ENTITY Test_registry IS
END Test_registry;
 
ARCHITECTURE behavior OF Test_registry IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Registery
    PORT(
         CK : IN  std_logic;
         W : IN  std_logic;
         A_ADR : IN  std_logic_vector(3 downto 0);
         B_ADR : IN  std_logic_vector(3 downto 0);
         W_ADR : IN  std_logic_vector(3 downto 0);
         DATA : IN  std_logic_vector(15 downto 0);
         QA : OUT  std_logic_vector(15 downto 0);
         QB : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CK : std_logic := '0';
   signal W : std_logic := '0';
   signal A_ADR : std_logic_vector(3 downto 0) := (others => '0');
   signal B_ADR : std_logic_vector(3 downto 0) := (others => '0');
   signal W_ADR : std_logic_vector(3 downto 0) := (others => '0');
   signal DATA : std_logic_vector(15 downto 0) := (others => '0');
	signal RST : std_logic := '1';

 	--Outputs
   signal QA : std_logic_vector(15 downto 0);
   signal QB : std_logic_vector(15 downto 0);
	
   -- No clocks detected in port list. Replace CK below with 
   -- appropriate port name 
 
   constant CK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Registery PORT MAP (
          CK => CK,
          W => W,
          A_ADR => A_ADR,
          B_ADR => B_ADR,
          W_ADR => W_ADR,
          DATA => DATA,
          QA => QA,
          QB => QB
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

      -- insert stimulus here
		
		-- Test writing and then reading the same register
		W <= '1';
		W_ADR <= x"3";
		DATA <= x"0002";
		
		wait for CK_period*10;
		A_ADR <= x"3";
		B_ADR <= x"3";
		wait for CK_period*10;
		
		-- Test simultaneous writing and reading
		A_ADR <= x"4";
		B_ADR <= x"4";
		W_ADR <= x"4";
		DATA <= x"000A";

      wait;
   end process;

END;
