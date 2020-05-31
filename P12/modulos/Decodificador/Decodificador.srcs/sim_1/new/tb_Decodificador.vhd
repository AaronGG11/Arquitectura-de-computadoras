library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_Decodificador is
end tb_Decodificador;

architecture Behavioral of tb_Decodificador is
    component Decodificador is
    Port ( qb : in STD_LOGIC_VECTOR (3 downto 0);
           digito_out : out STD_LOGIC_VECTOR (6 downto 0));
    end component;
    
    -- input signal
    signal qb : STD_LOGIC_VECTOR (3 downto 0);
    
    -- output signal 
    signal digito_out : STD_LOGIC_VECTOR (6 downto 0);
    
    begin
    
    -- Insatnciate compornent
    DECO : Decodificador Port map( 
           qb => qb,
           digito_out => digito_out 
    );
    
    -- Stimulus process
    SP : process
        begin
        -- Vamos a probar con cada numero 
        qb <= "0000"; -- 0
        wait for 10 ns;
        qb <= "0001"; -- 1
        wait for 10 ns;
        qb <= "0010"; -- 2
        wait for 10 ns;
        qb <= "0011"; -- 3
        wait for 10 ns;
        qb <= "0100"; -- 4
        wait for 10 ns;
        qb <= "0101"; -- 5
        wait for 10 ns;
        qb <= "0110"; -- 6
        wait for 10 ns;
        qb <= "0111"; -- 7
        wait for 10 ns;
        qb <= "1000"; -- 8
        wait for 10 ns;
        qb <= "1001"; -- 9
        
        wait;
    end process;


end Behavioral;
