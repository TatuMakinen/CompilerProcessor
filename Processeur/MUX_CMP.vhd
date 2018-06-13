----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:00:52 06/01/2018 
-- Design Name: 
-- Module Name:    MUX_CMP - Behavioral 
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

entity MUX_CMP is
    Port ( OP_IN : in  STD_LOGIC_VECTOR (7 downto 0);
           FLAGS_IN : in  STD_LOGIC_VECTOR (15 downto 0);
           MUX2_IN : in  STD_LOGIC_VECTOR (15 downto 0);
           B_OUT : out  STD_LOGIC_VECTOR (15 downto 0));
end MUX_CMP;

architecture Behavioral of MUX_CMP is

begin

	B_OUT <= x"0001" when (OP_IN = x"09" and FLAGS_IN(0) = '1') else  -- EQU - zero flag ON
				x"0000" when (OP_IN = x"09" and FLAGS_IN(0) = '0') else  -- EQU - zero flag OFF
				MUX2_IN;


end Behavioral;

