library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity mult_n is
generic(n: natural:=16);

port 
	(
		A : in std_logic_vector ((n-1) downto 0);
		B : in std_logic_vector ((n-1) downto 0);
		P : out std_logic_vector((2*n-1) downto 0)
		
		);
end entity mult_n;

Architecture secuencial of mult_n is
begin
process(A,B)
begin
P <= A * B;
end process;
end architecture secuencial;