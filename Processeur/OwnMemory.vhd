----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:39:46 06/05/2018 
-- Design Name: 
-- Module Name:    OwnMemory - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity OwnMemory is

	Generic ( 	memwidth : natural := 16;
					adrwidth : natural := 11;
					memorysize : natural := 1024);
					
    Port ( CK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           DO : in  STD_LOGIC_VECTOR (15 downto 0);
           A : in  STD_LOGIC_VECTOR (15 downto 0);
           WE : in  STD_LOGIC;
           DI : out  STD_LOGIC_VECTOR (15 downto 0));
end OwnMemory;

architecture Behavioral of OwnMemory is

type memory_array is array (natural range 0 to memorysize-1) of 
                               std_logic_vector ( memwidth-1 downto 0);
										 
signal memory_bank: memory_array := (others => x"0000");

begin
	
	process
	begin
		wait until CK'event and CK='1';
		DI <= memory_bank(to_integer(unsigned(A(memwidth-1 downto 0))));
		if(RST='1') then
			-- RESET memory to 0
			memory_bank <= (others => x"0000");
		else
			if(WE='1') then
				-- Writing active:
				-- DATA should be copied to register at W_ADR
				memory_bank(to_integer(unsigned(A(memwidth-1 downto 0)))) <= DO;
			end if;
		end if;
	end process;


end Behavioral;

