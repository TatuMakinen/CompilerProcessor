----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:52:44 05/15/2018 
-- Design Name: 
-- Module Name:    Register - Behavioral 
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

entity Registery is
	Generic ( 	regwidth : natural := 16;
					adrwidth : natural := 4;
					nbregisters : natural := 16);
					

	Port (  CK : in  STD_LOGIC;
			  W : in  STD_LOGIC;
			  A_ADR : in  STD_LOGIC_VECTOR (adrwidth-1 downto 0);
			  B_ADR : in  STD_LOGIC_VECTOR (adrwidth-1 downto 0);
			  W_ADR : in  STD_LOGIC_VECTOR (adrwidth-1 downto 0);
			  DATA : in  STD_LOGIC_VECTOR (15 downto 0);
			  QA : out  STD_LOGIC_VECTOR (15 downto 0);
			  QB : out  STD_LOGIC_VECTOR (15 downto 0));
end Registery;

architecture Behavioral of Registery is

type register_array is array (natural range 0 to nbregisters-1) of 
                               std_logic_vector ( regwidth-1 downto 0);
										 
signal register_bank: register_array := (others => x"0000");
signal RST : std_logic;

begin
	-- READ registers at 2 addresses:
	-- QX <=  register @ X_ADR;
	-- bypass if reading and writing in same register
	QA <= DATA when W_ADR = A_ADR else
			register_bank(to_integer(unsigned(A_ADR)));
	QB <= DATA when W_ADR = B_ADR else
			register_bank(to_integer(unsigned(B_ADR)));
	process
	begin
		wait until CK'event and CK='1';
		if(RST='0') then
			-- RESET registers to 0
			register_bank <= (others => x"0000");
		else
			if(W='1') then
				-- Writing active:
				-- DATA should be copied to register at W_ADR
				register_bank(to_integer(unsigned(W_ADR))) <= DATA;
			end if;
		end if;
	end process;
		
		


end Behavioral;

