-- VHDL Test Bench Created by ISE for module: Fetch
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.all;
USE IEEE.STD_LOGIC_unsigned.ALL;
LIBRARY STD;
USE STD.TEXTIO.ALL;
USE ieee.std_logic_TEXTIO.ALL;	--PERMITE USAR STD_LOGIC 
 
ENTITY tb_fetch IS
END tb_fetch;
 
ARCHITECTURE behavior OF tb_fetch IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT Fetch
    PORT(
        pcin : IN  std_logic_vector(15 downto 0);
        wpc : IN  std_logic;
        up : IN  std_logic;
        dw : IN  std_logic;
        clr : IN  std_logic;
        clk : IN  std_logic;
        sp : OUT std_logic_vector(2 downto 0);
        pcout : OUT  std_logic_vector(15 downto 0);
        dataout : OUT  std_logic_vector(24 downto 0)
    );
    END COMPONENT;
    
   --Inputs
    signal pcin : std_logic_vector(15 downto 0) := (others => '0');
    signal wpc : std_logic := '0';
    signal up : std_logic := '0';
    signal dw : std_logic := '0';
    signal clr : std_logic := '1';
    signal clk : std_logic := '0';

    --Outputs
    signal dataout : std_logic_vector(24 downto 0);
    signal sp : std_logic_vector(2 downto 0) := (others => '0');
    signal pcout : std_logic_vector(15
     downto 0);

   -- Clock period definitions
    constant clk_period : time := 10 ns;
 
BEGIN
 
    -- Instantiate the Unit Under Test (UUT)
    uut: Fetch PORT MAP (
        pcin => pcin,
        wpc => wpc,
        up => up,
        dw => dw,
        clr => clr,
        clk => clk,
        sp => sp,
        pcout => pcout,
        dataout => dataout
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
   
   -- SALIDAS
    file SALIDAS : TEXT;	--Apuntadores tipo txt
    variable LINEA_RES : line;

    variable VAR_PCOUT : std_logic_vector(15 downto 0);
    variable VAR_SPOUT : std_logic_vector(2 downto 0);
    variable VAR_OPCODE: std_logic_vector(4 downto 0);
    variable VAR_RD : std_logic_vector(3 downto 0);
    variable VAR_RT : std_logic_vector(3 downto 0);
    variable VAR_RS : std_logic_vector(3 downto 0);
    variable VAR_SHAMT : std_logic_vector(3 downto 0);
    variable VAR_FCODE : std_logic_vector(3 downto 0);
    
   
   -- ENTRADAS
    file ENTRADAS : text;
    variable LINEA_E : line;
    variable VAR_PCIN : std_logic_vector(15 downto 0);
    variable VAR_CLR : std_logic;
    variable VAR_WPC : std_logic;
    variable VAR_UP : std_logic;
    variable VAR_DOWN : std_logic;
   
    variable  CADENA : STRING(1 TO 6);
   
   begin	
        file_open(SALIDAS, "C:\Users\Aaron\Desktop\P11\p11\RESULTADO.txt", WRITE_MODE);
        file_open(ENTRADAS, "C:\Users\Aaron\Desktop\P11\p11\INSTRUCCIONES.txt", READ_MODE);
        
        
        --Encabezados
        CADENA := "sp    ";
        write(LINEA_RES, CADENA, left, CADENA'LENGTH+1);--ESCRIBE LA CADENA "sp"
        CADENA := "cpout ";
        write(LINEA_RES, CADENA, left, CADENA'LENGTH+1);--ESCRIBE LA CADENA "cpout"
        CADENA := "OPCODE";
        write(LINEA_RES, CADENA, left, CADENA'LENGTH+1);--ESCRIBE LA CADENA "OPCODE"
        CADENA := "Rd    ";
        write(LINEA_RES, CADENA, left, CADENA'LENGTH+1);--ESCRIBE LA CADENA "19..16"
        CADENA := "Rt    ";
        write(LINEA_RES, CADENA, left, CADENA'LENGTH+1);--ESCRIBE LA CADENA "15..12"
        CADENA := "Rs    ";
        write(LINEA_RES, CADENA, left, CADENA'LENGTH+1);--ESCRIBE LA CADENA "11...8"
        CADENA := "Shamt ";
        write(LINEA_RES, CADENA, left, CADENA'LENGTH+1);--ESCRIBE LA CADENA "7...4"
        CADENA := "FCODE ";
        write(LINEA_RES, CADENA, left, CADENA'LENGTH+1);--ESCRIBE LA CADENA "3...0"
        writeline(SALIDAS,LINEA_RES);-- escribe la linea en el archivo
        
        wait for 25 ns;
        -- Leer y escribir estimulos
        
        for i in 0 to 19 loop
            readline(ENTRADAS,LINEA_E); -- lee la linea completa 
            
            -- lee clr
            read(LINEA_E,VAR_CLR);
            clr <= VAR_CLR;
            
            -- lee WPC
            read(LINEA_E,VAR_WPC);
            wpc <= VAR_WPC;
            
            -- lee UP
            read(LINEA_E,VAR_UP);
            up <= VAR_UP;
            
            -- lee DOWN
            read(LINEA_E, VAR_DOWN);
            dw <= VAR_DOWN;
            
            -- lee PC IN 
            hread(LINEA_E, VAR_PCIN);
            pcin <= VAR_PCIN;
            
            wait until rising_edge(clk);
            
            VAR_PCOUT := pcout;
            VAR_SPOUT := sp;
            VAR_OPCODE := dataout(24 downto 20);
            VAR_RD := dataout(19 downto 16);
            VAR_RT := dataout(15 downto 12);
            VAR_RS := dataout(11 downto 8);
            VAR_SHAMT := dataout(7 downto 4);
            VAR_FCODE := dataout(3 downto 0);
            
            write(LINEA_RES, VAR_SPOUT, left, 7); --ESCRIBE SP
            Hwrite(LINEA_RES, VAR_PCOUT, left, 7); --ESCRIBE PCout
            write(LINEA_RES, VAR_OPCODE, left, 7); --ESCRIBE daout 
            write(LINEA_RES, VAR_RD, left, 7);
            write(LINEA_RES, VAR_RT, left, 7);
            write(LINEA_RES, VAR_RS, left, 7);
            write(LINEA_RES, VAR_SHAMT, left, 7);
            write(LINEA_RES, VAR_FCODE, left, 7);
            
            writeline(SALIDAS, LINEA_RES);

        end loop;

        file_close(SALIDAS);  -- cierra el archivo
        file_close(ENTRADAS);
        wait;
   
   end process;

END;
