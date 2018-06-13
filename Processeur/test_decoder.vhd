--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:49:03 05/29/2018
-- Design Name:   
-- Module Name:   /home/makinen/Processeur/test_decoder.vhd
-- Project Name:  Processeur
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Decoder
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
 
ENTITY test_decoder IS
END test_decoder;
 
ARCHITECTURE behavior OF test_decoder IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Decoder
    PORT(
         OP_IN : IN  std_logic_vector(15 downto 0);
         A_IN : IN  std_logic_vector(15 downto 0);
         B_IN : IN  std_logic_vector(15 downto 0);
         C_IN : IN  std_logic_vector(15 downto 0);
         OP_OUT : OUT  std_logic_vector(7 downto 0);
         A_OUT : OUT  std_logic_vector(7 downto 0);
         B_OUT : OUT  std_logic_vector(7 downto 0);
         C_OUT : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal OP_IN : std_logic_vector(15 downto 0) := (others => '0');
   signal A_IN : std_logic_vector(15 downto 0) := (others => '0');
   signal B_IN : std_logic_vector(15 downto 0) := (others => '0');
   signal C_IN : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal OP_OUT : std_logic_vector(7 downto 0);
   signal A_OUT : std_logic_vector(7 downto 0);
   signal B_OUT : std_logic_vector(7 downto 0);
   signal C_OUT : std_logic_vector(7 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Decoder PORT MAP (
          OP_IN => OP_IN,
          A_IN => A_IN,
          B_IN => B_IN,
          C_IN => C_IN,
          OP_OUT => OP_OUT,
          A_OUT => A_OUT,
          B_OUT => B_OUT,
          C_OUT => C_OUT
        );

 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      -- insert stimulus here
		
		-- Normal case
		
		OP_IN <= x"0001";
		B_IN <= x"4040"; -- 16448
		C_IN <= x"0404"; -- 1028
		A_IN <= x"0101";
		
		wait for 100 ns;	
		
		OP_IN <= x"0006";
		B_IN <= x"4040"; -- 16448
		C_IN <= x"0404"; -- 1028
		A_IN <= x"1111";
		
		wait for 100 ns;	
		
		OP_IN <= x"0008";
		B_IN <= x"4040"; -- 16448
		C_IN <= x"0404"; -- 1028
		A_IN <= x"1111";
		
      wait;
   end process;

END;
