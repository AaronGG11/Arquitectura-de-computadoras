library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity decodificador is
    Port ( 
        codigo_operacion : in STD_LOGIC_VECTOR(4 downto 0);
        tipo_R : out STD_LOGIC;
        BEQI : out STD_LOGIC;
        BNEI : out STD_LOGIC;
        BLTI : out STD_LOGIC;
        BLETI : out STD_LOGIC;
        BGTI : out STD_LOGIC;
        BGETI : out STD_LOGIC
    );
end decodificador;

architecture Behavioral of decodificador is
    begin
    
    process(codigo_operacion) 
        begin
        if(codigo_operacion = "00000") then -- TIPO R
            tipo_R <= '1';
            BEQI <= '0';
            BNEI <= '0';
            BLTI <= '0';
            BLETI <= '0';
            BGTI <= '0';
            BGETI <= '0';
            
        elsif(codigo_operacion = "01101") then -- BEQI
            tipo_R <= '0';
            BEQI <= '1';
            BNEI <= '0';
            BLTI <= '0';
            BLETI <= '0';
            BGTI <= '0';
            BGETI <= '0';
        elsif(codigo_operacion = "01110") then -- BNEI
            tipo_R <= '0';
            BEQI <= '0';
            BNEI <= '1';
            BLTI <= '0';
            BLETI <= '0';
            BGTI <= '0';
            BGETI <= '0';
        elsif(codigo_operacion = "01111") then -- BLTI
            tipo_R <= '0';
            BEQI <= '0';
            BNEI <= '0';
            BLTI <= '1';
            BLETI <= '0';
            BGTI <= '0';
            BGETI <= '0';
        elsif(codigo_operacion = "10000") then -- BLTEI
            tipo_R <= '0';
            BEQI <= '0';
            BNEI <= '0';
            BLTI <= '0';
            BLETI <= '1';
            BGTI <= '0';
            BGETI <= '0';
            
        elsif(codigo_operacion = "10001") then -- BGTI
            tipo_R <= '0';
            BEQI <= '0';
            BNEI <= '0';
            BLTI <= '0';
            BLETI <= '0';
            BGTI <= '1';
            BGETI <= '0';
        elsif(codigo_operacion = "10010") then -- BGETI
            tipo_R <= '0';
            BEQI <= '0';
            BNEI <= '0';
            BLTI <= '0';
            BLETI <= '0';
            BGTI <= '0';
            BGETI <= '1';
        else -- NO ES TIPO R NI SALTO CONDICIONAL 
            tipo_R <= '0';
            BEQI <= '0';
            BNEI <= '0';
            BLTI <= '0';
            BLETI <= '0';
            BGTI <= '0';
            BGETI <= '0';
        end if;
    end process;
    
end Behavioral;
