----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:43:14 06/06/2018 
-- Design Name: 
-- Module Name:    AleaTreater - Behavioral 
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

entity AleaTreater is
    Port (
		LIDIB : in STD_LOGIC_VECTOR (15 downto 0);
		LIDIC : in STD_LOGIC_VECTOR (15 downto 0);
		DIEXA : in STD_LOGIC_VECTOR (15 downto 0);
		EXMEMA : in STD_LOGIC_VECTOR (15 downto 0);
		RST : in STD_LOGIC;
		ENABLE : out  STD_LOGIC);
end AleaTreater;

architecture Behavioral of AleaTreater is

begin
	ENABLE <= 	'0' when LIDIB = DIEXA or LIDIC = DIEXA or  LIDIB = EXMEMA or LIDIC = EXMEMA else
					'1';


end Behavioral;

