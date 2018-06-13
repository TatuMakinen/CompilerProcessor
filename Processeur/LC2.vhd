----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:15:32 05/29/2018 
-- Design Name: 
-- Module Name:    LC - Behavioral 
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

entity LC2 is
    Port ( op : in  STD_LOGIC_VECTOR (7 downto 0);
           w : out  STD_LOGIC);
end LC2;

architecture Behavioral of LC2 is

begin

	w <= '1' when op = x"01" or op = x"02" or op = x"03" or op = x"04" or op = x"05" or op = x"06" or op = x"07" or op = x"09" or op = x"0A" or op = x"0B" or op = x"0C" or op = x"0D" else
		  '0';

end Behavioral;

