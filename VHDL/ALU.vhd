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
    Port ( 	CTRL_ALU : in  STD_LOGIC_VECTOR (7 downto 0);
				A_IN : in  STD_LOGIC_VECTOR (15 downto 0);
				B_IN : in  STD_LOGIC_VECTOR (15 downto 0);
				R_OUT : out  STD_LOGIC_VECTOR (15 downto 0);
				FLAGS_OUT: out  STD_LOGIC_VECTOR (15 downto 0));
end ALU;

architecture Behavioral of ALU is

signal R : std_logic_vector(15 downto 0);
signal Rmul : std_logic_vector(31 downto 0);
signal Radd : std_logic_vector(16 downto 0);
signal Rsub : std_logic_vector(16 downto 0);

begin

	Rmul 	<= A_IN*B_IN;
	Radd 	<=	('0'&A_IN)+('0'&B_IN);
	Rsub 	<=	('0'&A_IN)-('0'&B_IN);
	R_OUT <=	Radd(15 downto 0) when CTRL_ALU = x"01" else
				Rmul(15 downto 0) when CTRL_ALU = x"02" else
				Rsub(15 downto 0) when CTRL_ALU = x"03" else
				B_IN 					when CTRL_ALU = x"08" else
				x"0000";
	-- Z
	FLAGS_OUT(0) <= 	'1' when R=x"0000" else 
							'0';
	-- C - for unsigned arithmetics to detect errors
	FLAGS_OUT(1) <=	Radd(16) when CTRL_ALU = x"01" else
							Rsub(16) when CTRL_ALU = x"03" or CTRL_ALU = x"09" else 
							'0';
	-- N
	FLAGS_OUT(2)	<= R(15);
	-- O - for signed arithmetics to detect errors
	FLAGS_OUT(3)	<= '1' when A_IN(15) = B_IN(15) and not A_IN(15) = R(15) else 
							'0';

end Behavioral;

