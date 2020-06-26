LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.all;
USE IEEE.STD_LOGIC_unsigned.ALL;
LIBRARY STD;
USE STD.TEXTIO.ALL;
USE ieee.std_logic_TEXTIO.ALL;

entity tb_uniddad_control is
end tb_uniddad_control;

architecture Behavioral of tb_uniddad_control is
    component uniddad_control is
        Port (
            funCode : in STD_LOGIC_VECTOR(3 downto 0);
            opCode : in STD_LOGIC_VECTOR(4 downto 0);
            clk, clr, lf : in STD_LOGIC;
            banderas : in STD_LOGIC_VECTOR(3 downto 0);
            microInstruccion : out STD_LOGIC_VECTOR(19 downto 0)
        );
    end component;
    
    -- señales de comunicacion (Buses)
    signal funCode : STD_LOGIC_VECTOR(3 downto 0);
    signal opCode : STD_LOGIC_VECTOR(4 downto 0);
    signal clk, clr, lf : STD_LOGIC;
    signal banderas : STD_LOGIC_VECTOR(3 downto 0);
    signal microInstruccion : STD_LOGIC_VECTOR(19 downto 0);
    
    begin
    
    uut : uniddad_control Port map(
        funCode => funCode,
        opCode => opCode,
        clk => clk,
        clr => clr,
        lf => lf,
        banderas => banderas,
        microInstruccion => microInstruccion
    );
    
    -- proceso de reloj 
    CLOCK : process
        begin
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end process;
    
    -- Estimulos de proceso 
    SIM : process
        -- ENTRADAS
        file ENTRADAS : TEXT;
        variable LINEA_E : line;
        
        variable V_OP_CODE : STD_LOGIC_VECTOR(4 downto 0);
        variable V_FUN_CODE : STD_LOGIC_VECTOR(3 downto 0);
        variable V_BANDERAS : STD_LOGIC_VECTOR(3 downto 0);
        variable V_CLR : STD_LOGIC;
        variable V_LF : STD_LOGIC;
        
        variable  CADENA : STRING(1 TO 9);
        variable CADENA2 : STRING(1 TO 21);
        
        -- SALIDAS
        file SALIDAS : TEXT;
        variable LINEA_RES : line;
        
        variable V_MICROINSTRUCCION : STD_LOGIC_VECTOR(19 downto 0);
        
        begin
            file_open(SALIDAS, "C:\Users\Aaron\Desktop\P14\SALIDAS.txt", WRITE_MODE);
            file_open(ENTRADAS, "C:\Users\Aaron\Desktop\P14\ENTRADAS.txt", READ_MODE);
        
            --Encabezados
            CADENA := "OP_CODE  ";
            write(LINEA_RES, CADENA, left, CADENA'LENGTH+1);--ESCRIBE LA CADENA "OP_CODE"
            CADENA := "FUN_CODE ";
            write(LINEA_RES, CADENA, left, CADENA'LENGTH+1);--ESCRIBE LA CADENA "FUN_CODE"
            CADENA := "BANDERAS ";
            write(LINEA_RES, CADENA, left, CADENA'LENGTH+1);--ESCRIBE LA CADENA "BANDERAS"
            CADENA := "CLR      ";
            write(LINEA_RES, CADENA, left, CADENA'LENGTH+1);--ESCRIBE LA CADENA "CLR"
            CADENA := "LF       ";
            write(LINEA_RES, CADENA, left, CADENA'LENGTH+1);--ESCRIBE LA CADENA "LF"
            CADENA2 := "MICROINSTRUCCION     ";
            write(LINEA_RES, CADENA2, left, CADENA'LENGTH+1);--ESCRIBE LA CADENA "MICROINSTRUCCION"
            CADENA := "NIVEL    ";
            write(LINEA_RES, CADENA, left, CADENA'LENGTH+1);--ESCRIBE LA CADENA "NIVEL"
            
            writeline(SALIDAS, LINEA_RES);-- escribe la linea en el archivo
            
            -- Leer y escribir estimulos
            clr <= '1';
            wait for 10 ns;
            clr <= '0';
            wait for 10 ns;
            
            for i in 1 to 52 loop
            
                -- lee la linea completa
                readline(ENTRADAS, LINEA_E); 
                -- leer operacion code
                read(LINEA_E, V_OP_CODE);
                -- leer funcion code
                read(LINEA_E, V_FUN_CODE);
                -- BANDERAS
                read(LINEA_E, V_BANDERAS);
                -- CLR
                read(LINEA_E, V_CLR);
                -- LF
                read(LINEA_E, V_LF);
            
                opCode <= V_OP_CODE;
                funCode <= V_FUN_CODE;
                banderas <= V_BANDERAS;
                lf <= V_LF;

                wait until falling_edge(clk);
               
                clr <= V_CLR;
                wait for 2 ns;

                CADENA := "ALTO     ";
                V_MICROINSTRUCCION := microInstruccion;

                write(LINEA_RES, V_OP_CODE, LEFT, 10);
                write(LINEA_RES, V_FUN_CODE, LEFT, 10);
                write(LINEA_RES, V_BANDERAS, LEFT, 10);
                write(LINEA_RES, V_CLR, LEFT, 10);
                write(LINEA_RES, V_LF, LEFT, 10);
                write(LINEA_RES, V_MICROINSTRUCCION, LEFT, 21);
                write(LINEA_RES, CADENA, LEFT, 10);
                writeline(SALIDAS, LINEA_RES);
                
                wait until rising_edge(clk);

                CADENA := "BAJO     ";
                wait for 2 ns;
                
                V_MICROINSTRUCCION := microInstruccion;

                write(LINEA_RES, V_OP_CODE, LEFT, 10);
                write(LINEA_RES, V_FUN_CODE, LEFT, 10);
                write(LINEA_RES, V_BANDERAS, LEFT, 10);
                write(LINEA_RES, V_CLR, LEFT, 10);
                write(LINEA_RES, V_LF, LEFT, 10);
                write(LINEA_RES, V_MICROINSTRUCCION, LEFT, 21);
                write(LINEA_RES, CADENA, LEFT, 10);
                writeline(SALIDAS, LINEA_RES);
                
                -- CADENA := "         ";
                -- write(LINEA_RES, CADENA, LEFT, 10);
                -- writeline(SALIDAS, LINEA_RES);
                
            end loop;
            
            -- cierra el archivos
            file_close(SALIDAS);  
            file_close(ENTRADAS);

            wait;
    end process;
end Behavioral;
