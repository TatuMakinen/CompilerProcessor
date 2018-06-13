----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:38:46 05/29/2018 
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

entity MUX4 is
    Port ( OP_IN : in  STD_LOGIC_VECTOR (7 downto 0);
           B_IN : in  STD_LOGIC_VECTOR (15 downto 0);
           DATA_IN : in  STD_LOGIC_VECTOR (15 downto 0);
           DATA_OUT : out  STD_LOGIC_VECTOR (15 downto 0));
end MUX4;

architecture Behavioral of MUX4 is

begin

	DATA_OUT <= DATA_IN when OP_IN = x"07" else
					B_IN;


end Behavioral;

