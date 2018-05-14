----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:46:24 05/14/2018 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
use ieee.STD_LOGIC_UNSIGNED.all;

entity ALU is
    Port ( 	A_IN : in  STD_LOGIC_VECTOR (15 downto 0);
				B_IN : in  STD_LOGIC_VECTOR (15 downto 0);
				C_IN : in  STD_LOGIC_VECTOR (15 downto 0);
				OP_IN : in  STD_LOGIC_VECTOR (15 downto 0);
				Flag_IN : in  STD_LOGIC_VECTOR (15 downto 0);
				A_OUT : out  STD_LOGIC_VECTOR (15 downto 0);
				B_OUT : out  STD_LOGIC_VECTOR (15 downto 0);
				C_OUT : out  STD_LOGIC_VECTOR (15 downto 0);
				OP_OUT : out  STD_LOGIC_VECTOR (15 downto 0);
				Flag_OUT : out  STD_LOGIC_VECTOR (15 downto 0));
end ALU;

architecture Behavioral of ALU is

signal R : std_logic_vector(15 downto 0);
signal Rmul : std_logic_vector(31 downto 0);
signal Radd : std_logic_vector(16 downto 0);

begin

	Rmul <= A_IN*B_IN;
	Radd <=('0'&A_IN)+('0'&B_IN);
	R <= 	Radd(15 downto 0) when OP_IN = x"01" else
			Rmul(15 downto 0) when OP_IN = x"02" else
			A_IN-B_IN when OP_IN = x"03" else x"0000";
															-- Negative flag and Overflow ?
	Flag_OUT(1) <= Radd(16);							-- Carry flag
	Flag_OUT(0) <= '1' when R=x"0000" else '0';  --ZERO flag
	C_OUT <= R;

end Behavioral;

