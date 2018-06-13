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
			  ENABLE : in  STD_LOGIC;
           INST_ADR : out  STD_LOGIC_VECTOR (15 downto 0));
end IP;

architecture Behavioral of IP is
signal temp : STD_LOGIC_VECTOR (15 downto 0) :=x"0000";
signal temp2 : STD_LOGIC_VECTOR (15 downto 0) :=x"0000";
signal alea_counter : STD_LOGIC_VECTOR (3 downto 0) :=x"0";

begin
	INST_ADR <=temp;

	process
	begin
		wait until CK'event and CK='1';
		if(RST ='1') then temp <= x"0000";temp2 <= x"0000";
		elsif(ENABLE = '0') then alea_counter<=x"0";temp <= temp2;
		elsif alea_counter < x"1" then alea_counter<=alea_counter+1;
		else temp <= temp+1;temp2<=temp;
		end if;	
	end process;


end Behavioral;

