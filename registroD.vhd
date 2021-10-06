library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;


entity registroD is
generic(n: natural:=16);

port 
	(
	CLK: in std_logic;
	DATA : in std_logic_vector ((n-1) downto 0);
	Q : out std_logic_vector ((n-1) downto 0)
	);
	
end entity registroD;

Architecture a of registroD is
begin
process(CLK)
begin
if rising_edge(CLK) then
	Q <= DATA;
	end if;

end process;
end architecture a;