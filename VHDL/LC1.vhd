----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:28:39 05/29/2018 
-- Design Name: 
-- Module Name:    LC1 - Behavioral 
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

entity LC1 is
    Port ( op : in  STD_LOGIC_VECTOR (7 downto 0);
           w : out  STD_LOGIC);
end LC1;

architecture Behavioral of LC1 is

begin
	w <= 	'1' when op = x"07" else
			'0';


end Behavioral;

