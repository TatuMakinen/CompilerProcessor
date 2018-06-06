----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:35:59 06/01/2018 
-- Design Name: 
-- Module Name:    MUX3 - Behavioral 
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

entity MUX3 is
    Port ( A_IN : in  STD_LOGIC_VECTOR (15 downto 0);
           OP_IN : in  STD_LOGIC_VECTOR (7 downto 0);
           B_IN : in  STD_LOGIC_VECTOR (15 downto 0);
           DATA_A : out  STD_LOGIC_VECTOR (15 downto 0));
end MUX3;

architecture Behavioral of MUX3 is

begin

	DATA_A <= A_IN when OP_IN = x"08" else
					B_IN;

end Behavioral;

