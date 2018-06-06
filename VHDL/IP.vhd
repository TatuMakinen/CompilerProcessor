----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:17:31 06/01/2018 
-- Design Name: 
-- Module Name:    IP - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IP is
    Port ( CK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           INST_ADR : out  STD_LOGIC_VECTOR (15 downto 0));
end IP;

architecture Behavioral of IP is
signal temp,divide_counter: STD_LOGIC_VECTOR (15 downto 0);

begin
	INST_ADR<=temp;

	process (CK,RST)
	begin
		if RST='1' then temp<=x"0000";divide_counter<=x"0000";
			elsif rising_edge(CK) then 
				if divide_counter > x"0000" then temp<=temp+1; divide_counter<=x"0000";
				else divide_counter <= divide_counter+1;
				end if;	
		end if; 
	end process;


end Behavioral;

