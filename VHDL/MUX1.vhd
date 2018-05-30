----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:51:57 05/29/2018 
-- Design Name: 
-- Module Name:    MUX - Behavioral 
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

entity MUX1 is
    Port ( OP_IN : in  STD_LOGIC_VECTOR (7 downto 0);
           B_IN : in  STD_LOGIC_VECTOR (15 downto 0);
           QA_IN : in  STD_LOGIC_VECTOR (15 downto 0);
           B_OUT : out  STD_LOGIC_VECTOR (15 downto 0));
end MUX1;

architecture Behavioral of MUX1 is

begin

	B_OUT <= QA_IN when OP_IN = x"01" or OP_IN = x"02" or OP_IN = x"03" or OP_IN = x"04" or OP_IN = x"05" else
				B_IN;


end Behavioral;

