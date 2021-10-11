-- Multiplicador dato de ADC
-- Codigo encrito por : SANTIAGO DUQUE RAMOS, Cod: 1733527

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

entity ADC_MULT is
	port (
			CLK					  : in  STD_LOGIC;
			Reset               : in  STD_LOGIC;
			select_factor       : in  STD_LOGIC_VECTOR (2 downto 0);		  --Factor de 0 a 7
			ADC_IN       		  : in  STD_LOGIC_VECTOR (9 downto 0);		  --Entrada que recibe el ADC en complemento a2
			ADC_OUT   			  : out STD_LOGIC_VECTOR(24 downto 0);		  --Salida 200*Select*ADC_in
		 --out_aux				  : out STD_LOGIC_VECTOR(13 downto 0));     --Test para conocer los valores de primera multiplicacion
			
end ADC_MULT;

architecture Behavioral of ADC_MULT is

signal mult1 				: STD_LOGIC_VECTOR (14 downto 0);              -- Señal donde se recibe la multiplicacion 200*Select
signal factor_200 		: STD_LOGIC_VECTOR (10 downto 0);				  -- Constante
signal control_tiempo 	: natural;												  --Control de tiempo para la salida
signal salve_in 			: STD_LOGIC_VECTOR (9 downto 0);					  --Guarda el dato actual de ADC_IN

begin
	
process (CLK,Reset,ADC_IN,select_factor)

begin
	
	factor_200 <= "00011001000";
	
	if(Reset = '1') then                                               -- En caso que el reset marque 1 todo adquiere el valor de 0
		
		control_tiempo <= 0;
		
		ADC_OUT <= (others =>'0');
	 --out_aux <= (others =>'0');
		
		salve_in <= (others =>'0');
		
	else if(rising_edge(CLK)) then	
		
		salve_in <= ADC_IN;
		
		mult1(13 downto 0)  <= std_logic_vector(unsigned(select_factor) * unsigned(factor_200));
																							-- La primera multiplicaion se asume que todo los valores son sin signo
		
		mult1(14)  <= '0';															--Se le agrega un cero que es el bit de signo, aunque este siempre va ser 0
	 --out_aux <= mult1(13 downto 0);
		
		control_tiempo <= control_tiempo + 1;									--Se aumenta el contador
		
			if (control_tiempo = 1) then										   -- Retardo de tiempo para esperar que la multiplicacion 200*select este lista y que el valor de la salida no muestre un valor intermedio
			
				control_tiempo <= 0;													--Volvemos a 0 el contador
				
				ADC_OUT <=  std_logic_vector(signed(mult1) * signed(salve_in)); --Este caso la multiplicacion se considera con signo por la entrada ADC_IN
		
			end if;	
		end if;
	end if;
	

end process;


end Behavioral;
