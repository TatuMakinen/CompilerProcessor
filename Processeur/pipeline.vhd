----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:33:12 05/14/2018 
-- Design Name: 
-- Module Name:    Pipeline - Behavioral 
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
-- use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Pipeline is
    Port ( CK 	: in  STD_LOGIC;
			  OP_IN : in  STD_LOGIC_VECTOR (7 downto 0);
			  A_IN : in  STD_LOGIC_VECTOR (15 downto 0);
           B_IN : in  STD_LOGIC_VECTOR (15 downto 0);
           C_IN : in  STD_LOGIC_VECTOR (15 downto 0);
			  ENABLE : in  STD_LOGIC;
			  OP_OUT : out  STD_LOGIC_VECTOR (7 downto 0) := x"FF";
           A_OUT : out  STD_LOGIC_VECTOR (15 downto 0) := x"000D";
           B_OUT : out  STD_LOGIC_VECTOR (15 downto 0) := x"000E";
           C_OUT : out  STD_LOGIC_VECTOR (15 downto 0) := x"000F");
end Pipeline;

architecture Behavioral of Pipeline is
signal enable_counter: STD_LOGIC_VECTOR (3 downto 0);

begin
	
	process
	begin
		wait until CK'event and CK='1';
		if(ENABLE ='0') then 
			enable_counter <= x"0";
			A_OUT <= x"000D";
			B_OUT <= x"000E";
			C_OUT <= x"000F";
			OP_OUT <= x"FF";
		elsif(enable_counter < x"2") then
			enable_counter <= enable_counter+1;
			A_OUT <= x"000D";
			B_OUT <= x"000E";
			C_OUT <= x"000F";
			OP_OUT <= x"FF";
		else
			A_OUT <= A_IN;
			B_OUT <= B_IN;
			C_OUT <= C_IN;
			OP_OUT <= OP_IN;
		end if;
	end process;

end Behavioral;

