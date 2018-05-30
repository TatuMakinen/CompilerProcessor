----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:40:38 05/29/2018 
-- Design Name: 
-- Module Name:    MUX2 - Behavioral 
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

entity MUX2 is
    Port ( OP_IN : in  STD_LOGIC_VECTOR (7 downto 0);
           B_IN : in  STD_LOGIC_VECTOR (15 downto 0);
           S_IN : in  STD_LOGIC_VECTOR (15 downto 0);
           B_OUT : out  STD_LOGIC_VECTOR (15 downto 0));
end MUX2;

architecture Behavioral of MUX2 is

begin

	B_OUT <= S_IN when OP_IN=x"01" or OP_IN=x"02" or OP_IN=x"03" or OP_IN=x"04" else
				B_IN;

end Behavioral;

