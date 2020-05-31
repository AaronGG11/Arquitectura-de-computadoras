library IEEE;
LIBRARY STD;
USE STD.TEXTIO.ALL;
USE ieee.std_logic_TEXTIO.ALL;	--PERMITE USAR STD_LOGIC 

use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity tb_memDatos is
--  Port ( );
end tb_memDatos;

architecture tb_arq_memDatos of tb_memDatos is
    component memDatos is
        Port (
            dir : in std_logic_vector(10 downto 0);
            dataIn : in std_logic_vector(15 downto 0);
            dataOut : out std_logic_vector(15 downto 0);
            CLK, WD : in std_logic);   
    end component;

    signal dir : std_logic_vector(10 downto 0) := (others => '0');
    signal dataIn : std_logic_vector(15 downto 0) := (others => '0');
    signal dataOut : std_logic_vector(15 downto 0);
    signal CLK : std_logic := '0';
    signal WD : std_logic := '0'; 
    
    -- DEFINICION DEL PERIDO PARA EL RELOJ
    constant CLK_period : time := 10 ns;
    
    begin
    
    u1 : memDatos
        Port map(
           dir => dir,
           dataIn => dataIn,
           CLK => CLK,
           dataOut => dataOut,
           WD => WD  
        );

   -- DEFINICION DE PROCESO RELOJ
   CLK_process : process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
   
   -- PROCESO DE ESTIMULOS																
   PRUEBAS: process
    	--LINEAS Y ARCHIVOS REQUERIDOS PARA LAS ENTRADAS
        file ENTRADAS   : TEXT;
        variable LINEA_E : line;
        variable VAR_DIRECCION : std_logic_vector(10 downto 0);
        variable VAR_DATAIN : std_logic_vector(15 downto 0);
        variable VAR_WD : std_logic;
        
        -- lINEAS Y ARCHIVOS REQUERIDOS PARA LAS SALIDAS
        file SALIDAS    : TEXT;	
        variable LINEA_R : line;																				
        variable VAR_DATAOUT : std_logic_vector(15 downto 0);
       
        -- LA VARIABLE QUE VA LEER CADENAS
        variable CADENA : STRING(1 TO 7);
 
   begin
        file_open(ENTRADAS, "C:\Users\aaron\OneDrive\Escritorio\P7_MEMORIA_DE_DATOS\memData\ENTRADA.TXT", READ_MODE);
        file_open(SALIDAS, "C:\Users\aaron\OneDrive\Escritorio\P7_MEMORIA_DE_DATOS\memData\SALIDA.TXT", WRITE_MODE);
            
        -- ESCRIBIR ENCABEZADO DE ARCHIVO
		CADENA := "ADD    ";
		write(LINEA_R, CADENA, left, CADENA'LENGTH+1);	--ESCRIBE LA CADENA "ADD    "
		CADENA := "WD     ";
		write(LINEA_R, CADENA, left, CADENA'LENGTH+1);	--ESCRIBE LA CADENA "WD     "
		CADENA := "DATAIN ";
		write(LINEA_R, CADENA, left, CADENA'LENGTH+1);	--ESCRIBE LA CADENA "DATAIN "
		CADENA := "DATAOUT";
		write(LINEA_R, CADENA, left, CADENA'LENGTH+1); --ESCRIBE LA CADENA "DATAOUT"
		
		writeline(SALIDAS,LINEA_R); -- escribe la linea en el archivo
		
		wait for 100 ns;
		
		for i in 0 to 11 loop
		  readline(ENTRADAS, LINEA_E);
		  Hread(LINEA_E, VAR_DIRECCION);
		  dir <= VAR_DIRECCION;
		  read(LINEA_E, VAR_WD);
		  WD <= VAR_WD;
		  Hread(LINEA_E, VAR_DATAIN);
		  dataIn <= VAR_DATAIN;
	
		  wait until RISING_EDGE(CLK); -- Esperar por el flanco de subida
		  
		  -- la lectura siemore se esta realizando
		  -- la escritura solo se hace cuando WD esta encendido 
		  VAR_DATAOUT := dataOut;
		  VAR_DATAIN := dataIn;
		  VAR_WD := WD;
		  VAR_DIRECCION := dir;
		  
		  Hwrite(LINEA_R, VAR_DIRECCION, left, 8);
		  write(LINEA_R, VAR_WD, left, 8);
		  Hwrite(LINEA_R, VAR_DATAIN, left, 8);
		  Hwrite(LINEA_R, VAR_DATAOUT, left, 8);
		  writeline(SALIDAS, LINEA_R);
		  
		end loop;
		
   	    file_close(ENTRADAS); 
	    file_close(SALIDAS);  
        wait;
   
   end process;
end tb_arq_memDatos;

