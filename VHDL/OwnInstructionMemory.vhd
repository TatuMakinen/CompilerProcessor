----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:12:01 06/07/2018 
-- Design Name: 
-- Module Name:    OwnInstructionMemory - Behavioral 
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
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use IEEE.numeric_std.all;

use IEEE.std_logic_signed.all;
use IEEE.std_logic_unsigned.all;


library std;
use std.textio.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity OwnInstructionMemory is
	Generic ( 	DATA_BITS : natural := 32;
					DEPTH : natural := 1024;
					FILENAME : string := "none");
					
	Port ( 	A : in  STD_LOGIC_VECTOR (15 downto 0);
				DI : out  STD_LOGIC_VECTOR (31 downto 0));
			  
end OwnInstructionMemory;

architecture Behavioral of OwnInstructionMemory is

subtype word_t  is std_logic_vector(DATA_BITS - 1 downto 0);
type    ram_t   is array(0 to DEPTH - 1) of word_t;

impure function ocram_ReadMemFile(FileName : STRING) return ram_t is
  file FileHandle       : TEXT open READ_MODE is FileName;
  variable CurrentLine  : LINE;
  variable TempWord     : STD_LOGIC_VECTOR(DATA_BITS - 1 downto 0);
  variable Result       : ram_t    := (others => (others => '0'));

begin
  for i in 0 to DEPTH - 1 loop
    exit when endfile(FileHandle);

    readline(FileHandle, CurrentLine);
    hread(CurrentLine, TempWord);
    Result(i)    := TempWord;
  end loop;

  return Result;
end function;

signal ram    : ram_t    := ocram_ReadMemFile(FILENAME);

begin
	DI <= ram(to_integer(unsigned(A)));


end Behavioral;

