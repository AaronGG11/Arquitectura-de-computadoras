library IEEE;
library STD;
use STD.TEXTIO.ALL;
use ieee.std_logic_textio.all;

use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;


entity tb_memPrograma is
--  Port ( );
end tb_memPrograma;

architecture arq_memPrograma of tb_memPrograma is
    component memPrograma is
        Port ( dir : in STD_LOGIC_VECTOR (9 downto 0);
               inst : out STD_LOGIC_VECTOR (24 downto 0));
    end component;
    
    signal dir :  STD_LOGIC_VECTOR (9 downto 0) := "0000000000";
    signal inst : STD_LOGIC_VECTOR (24 downto 0);
    
    begin
    
    
    u1 : memPrograma port map (
        dir => dir,
        inst => inst
    );
    
    uno : process
        file SALIDAS : TEXT;
        variable LINEA_R : line;
        variable VAR_INSTRUCCION : std_logic_vector(24 downto 0);
        variable CADENA : STRING(1 to 9);
        --variable PC : std_logic_vector(9 downto 0);
    
        begin
        file_open(SALIDAS, "C:\Users\aaron\OneDrive\Escritorio\P8_MEMORIA_DE_PROGRAMA\memProg\SALIDA.TXT", WRITE_MODE);
        -- ESCRIBIR ENCABEZADOS
        CADENA := "PC       ";
        write(LINEA_R, CADENA, left, CADENA'LENGTH+1);
        CADENA := "OPCODE   ";
        write(LINEA_R, CADENA, left, CADENA'LENGTH+1);
        CADENA := "19...16  ";
        write(LINEA_R, CADENA, left, CADENA'LENGTH+1);
        CADENA := "15...12  ";
        write(LINEA_R, CADENA, left, CADENA'LENGTH+1);
        CADENA := "11...08  ";
        write(LINEA_R, CADENA, left, CADENA'LENGTH+1);
        CADENA := "07...04  ";
        write(LINEA_R, CADENA, left, CADENA'LENGTH+1);
        CADENA := "03...00  ";
        write(LINEA_R, CADENA, left, CADENA'LENGTH+1);
        writeline(SALIDAS,LINEA_R); -- escribe la linea en el archivo

        dir <= "0000000000";
        wait for 1 ns;
        
        while inst(24 downto 20) /= "10110" loop
            
            VAR_INSTRUCCION := inst;
            

            Hwrite(LINEA_R, dir, left, 10);
            write(LINEA_R, VAR_INSTRUCCION(24 downto 20), left, 10);
            write(LINEA_R, VAR_INSTRUCCION(19 downto 16), left, 10);
            write(LINEA_R, VAR_INSTRUCCION(15 downto 12), left, 10);
            write(LINEA_R, VAR_INSTRUCCION(11 downto 8), left, 10);
            write(LINEA_R, VAR_INSTRUCCION(7 downto 4), left, 10);
            write(LINEA_R, VAR_INSTRUCCION(3 downto 0), left, 10);
            writeline(SALIDAS, LINEA_R);
            
            if inst(24 downto 20) > "01100" and inst(24 downto 20) < "10011" then
                dir <= dir + inst(9 downto 0);
            elsif inst(24 downto 20) = "10011" then -- 
                dir <= inst(9 downto 0);
            else
                dir <= dir + 1;
            end if;
            wait for 1 ns;
        end loop;
        wait;
    end process;
end arq_memPrograma;
