library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;


entity mult_par_impar is

generic(n : natural := 8);

port 
	(
	In_1 				: in  std_logic_vector ((n-1) downto 0);
	In_2				: in  std_logic_vector ((n-1) downto 0);
	OUT_PAR 			: out std_logic_vector ((n-1) downto 0);
	OUT_IMPAR 		: out std_logic_vector ((n-1) downto 0)
	);
	
end entity mult_par_impar;


 
Architecture a of mult_par_impar is



signal par_1  	  : std_logic_vector ((n-1)/2 downto 0);
signal par_2     : std_logic_vector ((n-1)/2 downto 0);
signal impar_1   : std_logic_vector ((n-1)/2 downto 0);
signal impar_2   : std_logic_vector ((n-1)/2 downto 0);


--Mult
signal mult 	  : std_logic_vector ((n-1) downto 0);
signal mult1 	  : std_logic_vector ((n-1) downto 0);

begin

generate_multimpar: 

	for i in 0 to (n-1)/2 generate
	
        impar_1(i) <= In_1(2*i+1); 
		  impar_2(i) <= In_2(2*i+1); 
		  
    end generate generate_multimpar;
	 
	 mult <= std_logic_vector(unsigned(impar_1) * unsigned(impar_2));
	 OUT_IMPAR <= mult;
	 
generate_multpar:

	 for i in 0 to (n-1)/2 generate
	
        par_1(i) <= In_1(2*i); 
		  par_2(i) <= In_2(2*i); 
		  
    end generate generate_multpar;
	 
	 mult1 <= std_logic_vector(signed(par_1) * signed(par_2));
	 
	 OUT_PAR <= mult1;
	 
end architecture a;