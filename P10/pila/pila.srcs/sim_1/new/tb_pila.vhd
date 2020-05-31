library IEEE;
library STD;
use STD.TEXTIO.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity tb_pila is
end tb_pila;

architecture a_tb_pila of tb_pila is

component pila is
    Port(
    CLK, CLR, UP, DOWN, WPC : in std_logic;
    PCin : in std_logic_vector(15 downto 0);
    SP_OUT : out std_logic_vector(2 downto 0); 
    PCout : out std_logic_vector(15 downto 0)
    );
end component;

signal CLK, CLR, UP, DOWN, WPC : std_logic;
signal PCin : std_logic_vector(15 downto 0);

signal PCout : std_logic_vector(15 downto 0);
signal SP_OUT : std_logic_vector(2 downto 0);
 
begin
    reloj : process
        begin
            CLK <= '0';
            wait for 10 ns;
            CLK <= '1';
            wait for 10 ns;
    end process;
    
-- STACK

Stack_port : pila 
    Port map(
        CLK => CLK, 
        CLR => CLR, 
        UP => UP, 
        DOWN => DOWN, 
        WPC => WPC,
        PCin => PCin,
        PCout => PCout,
        SP_OUT => SP_OUT
    );

-- Estimullos

PRUBEAS : process

    -- Lineas y archivos requeridos para las salidas
    file SALIDAS : text;
    variable LINEA_R : line;
    variable VAR_PCOUT : std_logic_vector(15 downto 0);
    variable VAR_SPOUT : std_logic_vector(2 downto 0);
    
    -- Lineas y archivos requeridos para las entradas
    file ENTRADAS : text;
    variable LINEA_E : line;
    variable VAR_PCIN : std_logic_vector(15 downto 0);
    variable VAR_CLR : std_logic;
    variable VAR_WPC : std_logic;
    variable VAR_UP : std_logic;
    variable VAR_DOWN : std_logic;
    
    -- La varibale que va a leer cadenas 
    variable CADENA : string(1 to 5);
    
    begin 
        file_open(ENTRADAS,"C:\Users\Aaron\Desktop\P10\pila\INSTRUCCIONES.txt",READ_MODE);
        file_open(SALIDAS,"C:\Users\Aaron\Desktop\P10\pila\VECTORES.txt",WRITE_MODE);
        
        -- Encabezados de archivo 
        CADENA := "SP   ";
        write(LINEA_R,CADENA,left,1);
        CADENA := "PC   ";
        write(LINEA_R,CADENA,left,1);
        
        writeline(SALIDAS,LINEA_R);
        
        -- Leer y escribir estimulos
        
        wait for 20 ns;
        
        for i in 0 to 25 loop
            -- leer linea completa
            readline(ENTRADAS,LINEA_E);
            
            -- lee clr
            read(LINEA_E,VAR_CLR);
            CLR <= VAR_CLR;
            
            -- lee WPC
            read(LINEA_E,VAR_WPC);
            WPC <= VAR_WPC;
            
            -- lee UP
            read(LINEA_E,VAR_UP);
            UP <= VAR_UP;
            
            -- lee DOWN
            read(LINEA_E, VAR_DOWN);
            DOWN <= VAR_DOWN;
            
            -- lee PC IN 
            hread(LINEA_E, VAR_PCIN);
            PCin <= VAR_PCIN;
            
            wait until rising_edge(CLK);
            
            VAR_PCOUT := PCout;
            VAR_SPOUT := SP_OUT;
            
            hwrite(LINEA_R,VAR_SPOUT,left,5);
            hwrite(LINEA_R,VAR_PCOUT,left, 5);
            
            writeline(SALIDAS,LINEA_R);
                     
        end loop;
        
        file_close(ENTRADAS);
        file_close(SALIDAS);
        
        WAIT;
    
end process;
    



end a_tb_pila;
