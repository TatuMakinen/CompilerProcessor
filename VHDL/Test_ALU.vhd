--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:20:31 05/14/2018
-- Design Name:   
-- Module Name:   /home/makinen/Processeur/Test_ALU.vhd
-- Project Name:  Processeur
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALU
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
 
ENTITY Test_ALU IS
END Test_ALU;
 
ARCHITECTURE behavior OF Test_ALU IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         A_IN : IN  std_logic_vector(15 downto 0);
         B_IN : IN  std_logic_vector(15 downto 0);
         C_IN : IN  std_logic_vector(15 downto 0);
         OP_IN : IN  std_logic_vector(15 downto 0);
         Flag_IN : IN  std_logic_vector(15 downto 0);
         A_OUT : OUT  std_logic_vector(15 downto 0);
         B_OUT : OUT  std_logic_vector(15 downto 0);
         C_OUT : OUT  std_logic_vector(15 downto 0);
         OP_OUT : OUT  std_logic_vector(15 downto 0);
         Flag_OUT : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A_IN : std_logic_vector(15 downto 0) := (others => '0');
   signal B_IN : std_logic_vector(15 downto 0) := (others => '0');
   signal C_IN : std_logic_vector(15 downto 0) := (others => '0');
   signal OP_IN : std_logic_vector(15 downto 0) := (others => '0');
   signal Flag_IN : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal A_OUT : std_logic_vector(15 downto 0);
   signal B_OUT : std_logic_vector(15 downto 0);
   signal C_OUT : std_logic_vector(15 downto 0);
   signal OP_OUT : std_logic_vector(15 downto 0);
   signal Flag_OUT : std_logic_vector(15 downto 0);
   -- No clocks detected in port list. Replace CK below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
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
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	


      -- insert stimulus here
		-- 1)Test addition without carry
		OP_IN <= x"0001";
		A_IN <= x"000A";
		B_IN <= x"0001";
		wait for 100 ns;	
		-- 2)Test addition with carry
		OP_IN <= x"0001";
		A_IN <= x"FFFF";
		B_IN <= x"FFFF";
		wait for 100 ns;	
		-- 3)Test addition equal to 0
		OP_IN <= x"0001";
		A_IN <= x"0000";
		B_IN <= x"0000";
		wait for 100 ns;
		
		-- 4)Test soustraction
		OP_IN <= x"0003";
		A_IN <= x"0004";
		B_IN <= x"0003";
		wait for 100 ns;
		
		-- Test multiplication 
		OP_IN <= x"0002";
		A_IN <= x"000A";
		B_IN <= x"000A";
		wait for 100 ns;	
		-- Test multiplication equal to 0
		OP_IN <= x"0002";
		A_IN <= x"FFFF";
		B_IN <= x"0000";
      wait for 100 ns;	
   end process;

END;
