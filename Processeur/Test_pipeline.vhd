--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:14:10 05/14/2018
-- Design Name:   
-- Module Name:   /home/makinen/Processeur/Test_pipeline.vhd
-- Project Name:  Processeur
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Pipeline
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
 
ENTITY Test_pipeline IS
END Test_pipeline;
 
ARCHITECTURE behavior OF Test_pipeline IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Pipeline
    PORT(
         CK : IN  std_logic;
         A_IN : IN  std_logic_vector(15 downto 0);
         B_IN : IN  std_logic_vector(15 downto 0);
         C_IN : IN  std_logic_vector(15 downto 0);
         OP_IN : IN  std_logic_vector(7 downto 0);
         Flag_IN : IN  std_logic_vector(15 downto 0);
         A_OUT : OUT  std_logic_vector(15 downto 0);
         B_OUT : OUT  std_logic_vector(15 downto 0);
         C_OUT : OUT  std_logic_vector(15 downto 0);
         OP_OUT : OUT  std_logic_vector(7 downto 0);
         Flag_OUT : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CK : std_logic := '0';
   signal A_IN : std_logic_vector(15 downto 0) := (others => '0');
   signal B_IN : std_logic_vector(15 downto 0) := (others => '0');
   signal C_IN : std_logic_vector(15 downto 0) := (others => '0');
   signal OP_IN : std_logic_vector(7 downto 0) := (others => '0');
   signal Flag_IN : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal A_OUT : std_logic_vector(15 downto 0);
   signal B_OUT : std_logic_vector(15 downto 0);
   signal C_OUT : std_logic_vector(15 downto 0);
   signal OP_OUT : std_logic_vector(7 downto 0);
   signal Flag_OUT : std_logic_vector(15 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant CK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Pipeline PORT MAP (
          CK => CK,
          A_IN => A_IN,
          B_IN => B_IN,
          C_IN => C_IN,
          OP_IN => OP_IN,
          Flag_IN => Flag_IN,
          A_OUT => A_OUT,
          B_OUT => B_OUT,
          C_OUT => C_OUT,
          OP_OUT => OP_OUT,
          Flag_OUT => Flag_OUT
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
		
		A_IN <= x"F81A";
		

      wait;
   end process;

END;
