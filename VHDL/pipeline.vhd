----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:33:12 05/14/2018 
-- Design Name: 
-- Module Name:    Pipeline - Behavioral 
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

entity Pipeline is
    Port ( CK 	: in  STD_LOGIC;
			  A_IN : in  STD_LOGIC_VECTOR (15 downto 0);
           B_IN : in  STD_LOGIC_VECTOR (15 downto 0);
           C_IN : in  STD_LOGIC_VECTOR (15 downto 0);
           OP_IN : in  STD_LOGIC_VECTOR (15 downto 0);
           Flag_IN : in  STD_LOGIC_VECTOR (15 downto 0);
           A_OUT : out  STD_LOGIC_VECTOR (15 downto 0);
           B_OUT : out  STD_LOGIC_VECTOR (15 downto 0);
           C_OUT : out  STD_LOGIC_VECTOR (15 downto 0);
           OP_OUT : out  STD_LOGIC_VECTOR (15 downto 0);
           Flag_OUT : out  STD_LOGIC_VECTOR (15 downto 0));
end Pipeline;

architecture Behavioral of Pipeline is

begin

	process(CK)
	begin
		if(CK='1') then
			A_OUT <= A_IN;
			B_OUT <= B_IN;
			C_OUT <= C_IN;
			OP_OUT <= OP_IN;
			Flag_OUT <= Flag_IN;
		end if;
	end process;

end Behavioral;

