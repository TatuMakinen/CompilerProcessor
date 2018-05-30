----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:13:17 05/17/2018 
-- Design Name: 
-- Module Name:    Decoder - Behavioral 
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

entity Decoder is
    Port ( INS_DI : in  STD_LOGIC_VECTOR (31 downto 0);
           OP_OUT : out  STD_LOGIC_VECTOR (7 downto 0);
           A_OUT : out  STD_LOGIC_VECTOR (15 downto 0);
           B_OUT : out  STD_LOGIC_VECTOR (15 downto 0);
           C_OUT : out  STD_LOGIC_VECTOR (15 downto 0));
end Decoder;

architecture Behavioral of Decoder is

	Signal OP_IN : std_logic_vector(7 downto 0);
	Signal A_IN : std_logic_vector(7 downto 0);
	Signal B_IN : std_logic_vector(7 downto 0);
	Signal C_IN : std_logic_vector(7 downto 0);
	
begin

	OP_IN <= INS_DI(31 downto 24);
	A_IN <= INS_DI(23 downto 16);
	B_IN <= INS_DI(15 downto 8);
	C_IN <= INS_DI(7 downto 0);
	
	OP_OUT <= OP_IN(7 downto 0);
	
	A_OUT(15 downto 8) <= A_IN when OP_IN = x"08" or OP_IN = x"0E" or OP_IN = x"0F" else
								 x"00";
	A_OUT(7 downto 0) <= B_IN when OP_IN = x"08" or OP_IN = x"0E" or OP_IN = x"0F" else
								A_IN;
	
	B_OUT(15 downto 8) <= B_IN when OP_IN = x"06" or OP_IN = x"07" else
								 x"00";
	
	B_OUT(7 downto 0) <= C_IN when OP_IN = x"06" or OP_IN = x"07" else
								B_IN;
	
	C_OUT(15 downto 8) <= x"00";
	
	C_OUT(7 downto 0) <= C_IN;

end Behavioral;

