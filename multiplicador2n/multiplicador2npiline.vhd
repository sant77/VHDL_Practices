library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity multiplicador2npiline is

generic(m: natural:=32 ; n: natural:= 16);--m=2*n

port 
	(
	clk_in : in std_logic;
	A : in std_logic_vector ((m-1) downto 0);
	X : in std_logic_vector ((m-1) downto 0);
	P_total : out std_logic_vector ((2*m-1) downto 0)
	);
end entity multiplicador2npiline ;

Architecture a of multiplicador2npiline is

-- ---------------------COMPONENTES----------------------
component  sum_n is

generic(n:natural:=16);
port 
	(
	A : in std_logic_vector ((n-1) downto 0);
	B : in std_logic_vector ((n-1) downto 0);
	S : out std_logic_vector ((n-1) downto 0)
	);
	
end component sum_n;

component  mult_n is

generic(n:natural:=16);

port 
	(
		A : in std_logic_vector ((n-1) downto 0);
		B : in std_logic_vector ((n-1) downto 0);
		P : out std_logic_vector((2*n-1) downto 0)
		
		);
end component mult_n;

component registroD is
generic(n: natural:=16);

port 
	(
	CLK: in std_logic;
	DATA : in std_logic_vector ((n-1) downto 0);
	Q : out std_logic_vector ((n-1) downto 0)
	);

-------------------------DEFINICION_INDIVIDUAL-------------------------------	
end component registroD;
--Signal

signal P_HH, P_LL, P_LH, P_HL : std_logic_vector ((m-1) downto 0);
signal S_LL_HL, S_LH_HH :std_logic_vector((3*n-1) downto 0);
--signal S_LL_HL, S_LH_HH :std_logic_vector((3*n-1) downto 0);
signal regA_out, regA_out: std_logic_vector(n downto 0);

constant z_16:std_logic_vector((n-1) downto 0):= "0000000000000000";
begin

RegA: registroD generic map(n=>32)
port MAP(
				clk  => clk_in,
				DATA => A,
				q    => regA_out

			);
RegX: registroD generic map(n=>32)
port MAP(
				clk  => clk_in,
				DATA => x,
				q    => regx_out

			)
			

mult_HH: mult_n generic MAP(n=>16)
port map(
			A     => A((m-1) downto n),
			B     => X((m-1) downto n),   
			P     => P_HH
	);

mult_LL: mult_n generic MAP(n=>16)
port map(
			A     => A((n-1) downto 0),
			B     => X((n-1) downto 0),   
			P     => P_LL
	);

mult_LH: mult_n generic MAP(n=>16)
port map(
			A     => A((n-1) downto 0),
			B     => X((m-1) downto n),   
			P     => P_LH
	);

mult_HL :mult_n generic MAP(n=>16)
port map(
			A     => A((m-1) downto n),
			B     => X((n-1) downto 0),   
			P     => P_HL
	);
	
sum_LL_HL: sum_n generic MAP(n=>3*n)
port map(
			A     => Z_16 & P_LL,
			B     => P_HL & z_16,   
			S     => S_LL_HL
	);
	
sum_LH_HH: sum_n generic MAP(n=>3*n)
port map(
			A     => Z_16 & P_LH,
			B     => P_HH & z_16,   
			S     => S_LH_HH
	);
	
suma_total: sum_n generic MAP(n=>4*n)
port map(
			A     => Z_16 & S_LL_HL,
			B     => S_LH_HH & z_16,   
			S     => P_total
	);	
	
end architecture a;