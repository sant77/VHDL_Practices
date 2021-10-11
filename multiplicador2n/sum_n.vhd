library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;


entity sum_n is
generic(n: natural:=16);

port 
	(
	A : in std_logic_vector ((n-1) downto 0);
	B : in std_logic_vector ((n-1) downto 0);
	S : out std_logic_vector ((n-1) downto 0)
	);
	
end entity sum_n;

Architecture a of sum_n is
begin
process(A,B)
begin
S <= A + B;
end process;
end architecture a;