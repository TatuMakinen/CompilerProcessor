----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:39:59 05/29/2018 
-- Design Name: 
-- Module Name:    Processor - Behavioral 
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

entity Processor is
	Generic ( 	adrwidth : natural := 4);
    Port ( 
			  ins_di : in  std_logic_vector(31 downto 0);
			  sys_clk : in  STD_LOGIC;
           sys_rst : in  STD_LOGIC);
end Processor;

architecture Behavioral of Processor is

type stage is record
	op: std_logic_vector(7 downto 0);
	a,b,c,flag : std_logic_vector(15 downto 0);
end record;

type memory_cables is record
	w: std_logic;
	a,do,di : std_logic_vector(15 downto 0);
end record;

component IP
	Port(	CK : in STD_LOGIC;
			RST : in STD_LOGIC;
			INST_ADR : out STD_LOGIC_VECTOR (15 downto 0));
end component;

component Decoder
	Port(	  INS_DI : in  STD_LOGIC_VECTOR (31 downto 0);
           OP_OUT : out  STD_LOGIC_VECTOR (7 downto 0);
           A_OUT : out  STD_LOGIC_VECTOR (15 downto 0);
           B_OUT : out  STD_LOGIC_VECTOR (15 downto 0);
           C_OUT : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

component Pipeline
	Port(	  CK 	: in  STD_LOGIC;
			  OP_IN : in  STD_LOGIC_VECTOR (7 downto 0);
			  A_IN : in  STD_LOGIC_VECTOR (15 downto 0);
           B_IN : in  STD_LOGIC_VECTOR (15 downto 0);
           C_IN : in  STD_LOGIC_VECTOR (15 downto 0);
			  OP_OUT : out  STD_LOGIC_VECTOR (7 downto 0);
           A_OUT : out  STD_LOGIC_VECTOR (15 downto 0);
           B_OUT : out  STD_LOGIC_VECTOR (15 downto 0);
           C_OUT : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

component ALU
    Port (  CTRL_ALU : in  STD_LOGIC_VECTOR (7 downto 0);
				A_IN : in  STD_LOGIC_VECTOR (15 downto 0);
				B_IN : in  STD_LOGIC_VECTOR (15 downto 0);
				R_OUT : out  STD_LOGIC_VECTOR (15 downto 0);
				FLAGS_OUT : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

component Registery
	Port (  CK : in  STD_LOGIC;
			  W : in  STD_LOGIC;
			  A_ADR : in  STD_LOGIC_VECTOR (adrwidth-1 downto 0);
			  B_ADR : in  STD_LOGIC_VECTOR (adrwidth-1 downto 0);
			  W_ADR : in  STD_LOGIC_VECTOR (adrwidth-1 downto 0);
			  DATA : in  STD_LOGIC_VECTOR (15 downto 0);
			  QA : out  STD_LOGIC_VECTOR (15 downto 0);
			  QB : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

component bram16
	Generic (
		init_file : String := "none"; -- initialisation
		adr_width : Integer := 11);
	Port (
		-- System
		sys_clk : in std_logic;
		sys_rst : in std_logic;
		-- Master
		di : out std_logic_vector(15 downto 0);
		do : in std_logic_vector(15 downto 0);
		a : in std_logic_vector(15 downto 0);
		we : in std_logic);
end component;

component OwnMemory
	Port ( 
		CK : in  STD_LOGIC;
		RST : in  STD_LOGIC;
		DO : in  STD_LOGIC_VECTOR (15 downto 0);
		A : in  STD_LOGIC_VECTOR (15 downto 0);
		WE : in  STD_LOGIC;
		DI : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

component bram32
  generic (
    init_file : String := "rom1.hex";
    adr_width : Integer := 11);
  port (
  -- System
  sys_clk : in std_logic;
  sys_rst : in std_logic;
  -- Master
  di : out std_logic_vector(31 downto 0);
  we : in std_logic;
  a : in std_logic_vector(15 downto 0);
  do : in std_logic_vector(31 downto 0));
end component;

component LC1
	Port ( op : in  STD_LOGIC_VECTOR (7 downto 0);
           w : out  STD_LOGIC);
end component;

component LC2
	Port ( op : in  STD_LOGIC_VECTOR (7 downto 0);
           w : out  STD_LOGIC);
end component;

component MUX1
	Port (  OP_IN : in  STD_LOGIC_VECTOR (7 downto 0);
           B_IN : in  STD_LOGIC_VECTOR (15 downto 0);
           QA_IN : in  STD_LOGIC_VECTOR (15 downto 0);
           B_OUT : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

component MUX2
	Port (  OP_IN : in  STD_LOGIC_VECTOR (7 downto 0);
           B_IN : in  STD_LOGIC_VECTOR (15 downto 0);
           S_IN : in  STD_LOGIC_VECTOR (15 downto 0);
           B_OUT : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

component MUX_CMP
	Port (  OP_IN : in  STD_LOGIC_VECTOR (7 downto 0);
           FLAGS_IN : in  STD_LOGIC_VECTOR (15 downto 0);
           MUX2_IN : in  STD_LOGIC_VECTOR (15 downto 0);
           B_OUT : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

component MUX3
	Port (  A_IN : in  STD_LOGIC_VECTOR (15 downto 0);
           OP_IN : in  STD_LOGIC_VECTOR (7 downto 0);
           B_IN : in  STD_LOGIC_VECTOR (15 downto 0);
           DATA_A : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

component MUX4
	Port (  OP_IN : in  STD_LOGIC_VECTOR (7 downto 0);
           B_IN : in  STD_LOGIC_VECTOR (15 downto 0);
           DATA_IN : in  STD_LOGIC_VECTOR (15 downto 0);
           DATA_OUT : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

signal li, di, ex, mem, re : stage;
signal memcab : memory_cables;
signal REG_W, MEM_W: std_logic;
signal QA_dest, QB_dest : std_logic_vector (15 downto 0);
signal MUX1_dest, MUX2_dest, MUX_CMP_dest, MUX3_dest, MUX4_dest : std_logic_vector (15 downto 0);
signal ALU_OUT: std_logic_vector (15 downto 0);
signal ALU_FLAGS: std_logic_vector (15 downto 0);
signal INST_IN: std_logic_vector (15 downto 0);
signal INST_OUT,INST_DO: std_logic_vector (31 downto 0);
signal INST_WE: std_logic;

begin

	Compteur : IP port map(	CK => sys_clk,
									RST => sys_rst,
									INST_ADR => INST_IN);

	InstructionMemoire: bram32 port map(	sys_clk => sys_clk,
														sys_rst => sys_rst,
														di => INST_OUT,
														do => INST_DO,
														a => INST_IN,
														we => INST_WE);

	Dec : Decoder port map(	INS_DI => INST_OUT,
									OP_OUT => li.op,
									A_OUT => li.a,
									B_OUT => li.b,
									C_OUT => li.c);
									
	PipLiDi : Pipeline port map(	CK =>	sys_clk,
											OP_IN => li.op,
											A_IN => li.a,
											B_IN => li.b,
											C_IN => li.c,
											OP_OUT => di.op,
											A_OUT => di.a,
											B_OUT => di.b,
											C_OUT => di.c);
											
	Reg : Registery port map(	CK => sys_clk,
										W => REG_W,
										A_ADR => di.b(adrwidth-1 downto 0),
										B_ADR => di.c(adrwidth-1 downto 0),
										W_ADR => re.a(adrwidth-1 downto 0),
										DATA => MUX4_dest,
										QA => QA_dest,
										QB => QB_dest);
										
	MUX_1 : MUX1 port map(	OP_IN => di.op,
									B_IN => di.b,
									QA_IN => QA_dest,
									B_OUT => MUX1_dest);

										
	PipDiEx : Pipeline port map(	CK =>	sys_clk,
											OP_IN => di.op,
											A_IN => di.a,
											B_IN => MUX1_dest,
											C_IN => QB_dest,
											OP_OUT => ex.op,
											A_OUT => ex.a,
											B_OUT => ex.b,
											C_OUT => ex.c);
											
	UAL : ALU port map(	CTRL_ALU => ex.op,
								A_IN => ex.b,
								B_IN => ex.c,
								R_OUT => ALU_OUT,
								FLAGS_OUT => ALU_FLAGS);

	MUX_2 : MUX2 port map(	OP_IN => ex.op,
									B_IN => ex.b,
									S_IN => ALU_OUT,
									B_OUT => MUX2_dest);
									
	-- Does not work
	--MUX_CMP1 : MUX_CMP port map(	OP_IN => ex.op,
	--										FLAGS_IN => ALU_FLAGS,
	--										MUX2_IN => MUX2_dest,
	--										B_OUT => MUX_CMP_dest);
	
	PipExMem : Pipeline port map(	CK =>	sys_clk,
											OP_IN => ex.op,
											A_IN => ex.a,
											B_IN => MUX2_dest,
											C_IN => ex.c,
											OP_OUT => mem.op,
											A_OUT => mem.a,
											B_OUT => mem.b,
											C_OUT => mem.c);
											
	MUX_3 : MUX3 port map(	A_IN => mem.a,
									OP_IN => mem.op,
									B_IN => mem.b,
									DATA_A => MUX3_dest);													
		
	LC_1 : LC1 port map(	op => mem.op,
								w => MEM_W);
	
	PipMemRE	: Pipeline port map(	CK =>	sys_clk,
											OP_IN => mem.op,
											A_IN => mem.a,
											B_IN => mem.b,
											C_IN => mem.c,
											OP_OUT => re.op,
											A_OUT => re.a,
											B_OUT => re.b,
											C_OUT => re.c);
	
	LC_2 : LC2 port map(	op => re.op,
								w => REG_W);
	
	MUX_4 : MUX4 port map(	OP_IN => re.op,
									B_IN => re.b,
									DATA_IN => memcab.di,
									DATA_OUT => MUX4_dest);
	
	Memoire : OwnMemory port map(	CK => sys_clk,
											RST => sys_rst,
											DI => memcab.di,
											DO => mem.b,
											A => MUX3_dest,
											WE => MEM_W);
	
end Behavioral;

