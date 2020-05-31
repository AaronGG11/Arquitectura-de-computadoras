LIBRARY ieee;
LIBRARY STD;
USE STD.TEXTIO.ALL;
USE ieee.std_logic_TEXTIO.ALL;	--PERMITE USAR STD_LOGIC 

USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_UNSIGNED.ALL;
USE ieee.std_logic_ARITH.ALL;
 
ENTITY tb_archivo IS

END tb_archivo;
 
ARCHITECTURE behavior OF tb_archivo IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 component archivoRegistros is
    Port ( registro1,registro2,write_registro,shamt: in  STD_LOGIC_VECTOR (3 downto 0);
            wdata: in  STD_LOGIC_VECTOR (15 downto 0);
            read_data1, read_data2 : out  STD_LOGIC_VECTOR (15 downto 0);
            wd,she, clk ,dir, clr : in  STD_LOGIC);
end component;

    

   --Inputs
   signal registro1 : std_logic_vector(3 downto 0) := (others => '0');
   signal registro2 : std_logic_vector(3 downto 0) := (others => '0');
   signal write_registro : std_logic_vector(3 downto 0) := (others => '0');
   signal shamt : std_logic_vector(3 downto 0) := (others => '0');
   signal wdata : std_logic_vector(15 downto 0) := (others => '0');
   signal wd : std_logic := '0';
   signal she : std_logic := '0';
   signal dir : std_logic := '0';
   signal clk : std_logic := '0';
   signal clr : std_logic := '0';

 	--Outputs
   signal read_data1 : std_logic_vector(15 downto 0);
   signal read_data2 : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: archivoRegistros PORT MAP (
          registro1 => registro1,
          registro2 => registro2,
          write_registro => write_registro,
          shamt => shamt,
          wdata => wdata,
          read_data1 => read_data1,
          read_data2 => read_data2,
          wd => wd,
          she => she,
          dir => dir,
          clk => clk,
          clr => clr
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
 stim_proc: process
	file ARCH_RES : TEXT;																					
	variable LINEA_RES : line;
	variable var_read_data1 : std_logic_vector(15 downto 0);
   variable var_read_data2 : std_logic_vector(15 downto 0);
	
	
	file ARCH_VEC : TEXT;
	variable LINEA_VEC : line;
	variable var_registro1 : std_logic_vector(3 downto 0);
	variable var_registro2 : std_logic_vector(3 downto 0);
	variable var_shamt : std_logic_vector(3 downto 0);
	variable var_write_registro : std_logic_vector(3 downto 0);
	variable var_wdata : std_logic_vector(15 downto 0);
	variable var_wd : std_logic;
	variable var_she : std_logic;
	variable var_dir : std_logic;
	variable var_clr : std_logic;
	VARIABLE CADENA : STRING(1 TO 4);
   begin		
		file_open(ARCH_RES, "C:\Users\end user\Documents\6to Semestre Escom\Arquitectura de Computadoras\Practica 6\RESULTADO1.TXT", WRITE_MODE); 
		file_open(ARCH_VEC, "C:\Users\end user\Documents\6to Semestre Escom\Arquitectura de Computadoras\Practica 6\VECTORES1.TXT", READ_MODE); 	
			

		CADENA := " RR1";
		write(LINEA_RES, CADENA, right, CADENA'LENGTH+1);	--ESCRIBE LA CADENA "RR1"
		CADENA := " RR2";
		write(LINEA_RES, CADENA, right, CADENA'LENGTH+1);	--ESCRIBE LA CADENA "RR1"
		CADENA := "SHAM";
		write(LINEA_RES, CADENA, right, CADENA'LENGTH+1);	--ESCRIBE LA CADENA "SHAM"
		CADENA := "WREG";
		write(LINEA_RES, CADENA, right, CADENA'LENGTH+1);	--ESCRIBE LA CADENA "WREG"
		CADENA := "  WD";
		write(LINEA_RES, CADENA, right, CADENA'LENGTH+1);	--ESCRIBE LA CADENA "WD"
		CADENA := "  WR";
		write(LINEA_RES, CADENA, right, CADENA'LENGTH+1);	--ESCRIBE LA CADENA "WR"
		CADENA := " SHE";
		write(LINEA_RES, CADENA, right, CADENA'LENGTH+1);	--ESCRIBE LA CADENA "SHE"
		CADENA := " DIR";
		write(LINEA_RES, CADENA, right, CADENA'LENGTH+1);	--ESCRIBE LA CADENA "DIR"
		CADENA := " RD1";
		write(LINEA_RES, CADENA, right, CADENA'LENGTH+1);	--ESCRIBE LA CADENA "RD1"
		CADENA := " RD2";
		write(LINEA_RES, CADENA, right, CADENA'LENGTH+1);	--ESCRIBE LA CADENA "RD2"
		writeline(ARCH_RES,LINEA_RES);-- escribe la linea en el archivo

		WAIT FOR 100 NS;
		FOR I IN 0 TO 9 LOOP
			readline(ARCH_VEC,LINEA_VEC); -- lee una linea completa

			read(LINEA_VEC, var_registro1);
			registro1 <= var_registro1;
			read(LINEA_VEC, var_registro2);
			registro2 <= var_registro2;		
			read(LINEA_VEC, var_shamt);  
			shamt <= var_shamt;
			read(LINEA_VEC, var_write_registro);
			write_registro <= var_write_registro;
			read(LINEA_VEC, var_wdata);
			wdata <= var_wdata;
			read(LINEA_VEC, var_wd);
			wd <= var_wd;
			read(LINEA_VEC, var_she);
			she <= var_she;
			read(LINEA_VEC, var_dir);
			dir<= var_dir;
			read(LINEA_VEC, var_clr);
			clr <= var_clr;
			
			WAIT UNTIL RISING_EDGE(CLK);	--ESPERO AL FLANCO DE SUBIDA 

			var_read_data1 := read_data1;
			var_read_data2 := read_data2;
			
			Hwrite(LINEA_RES, var_registro1, right, 5);	--ESCRIBE EL CAMPO rr1
			Hwrite(LINEA_RES, var_registro2, 	right, 5);	--ESCRIBE EL CAMPO rr2
			Hwrite(LINEA_RES, var_shamt, 	right, 5);	--ESCRIBE EL CAMPO shamt
			Hwrite(LINEA_RES, var_write_registro, 	right, 5);	--ESCRIBE EL CAMPO wreg
			Hwrite(LINEA_RES, var_wdata, 	right, 5);	--ESCRIBE EL CAMPO wdata
			write(LINEA_RES, var_wd, 	right, 5);	--ESCRIBE EL CAMPO wr
			write(LINEA_RES, var_she, 	right, 5);	--ESCRIBE EL CAMPO she
			write(LINEA_RES, var_dir, 	right, 5);	--ESCRIBE EL CAMPO dir
			Hwrite(LINEA_RES, var_read_data1, 	right, 5);	--ESCRIBE EL CAMPO read_data1
			Hwrite(LINEA_RES, var_read_data2, 	right, 5);	--ESCRIBE EL CAMPO read_data2

			writeline(ARCH_RES,LINEA_RES);-- escribe la linea en el archivo
			
		end loop;
		file_close(ARCH_VEC);  -- cierra el archivo
		file_close(ARCH_RES);  -- cierra el archivo

		wait for clk_period*10;
      wait;
   end process;

END;
