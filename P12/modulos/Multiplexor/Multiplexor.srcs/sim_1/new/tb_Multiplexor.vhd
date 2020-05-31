library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_Multiplexor is
end tb_Multiplexor;

architecture Behavioral of tb_Multiplexor is
    component Multiplexor 
    Port ( digito_in : in STD_LOGIC_VECTOR (6 downto 0);
           ec : in STD_LOGIC;
           digito_final : out STD_LOGIC_VECTOR (6 downto 0));
    end component;
    
    -- input signs
    signal digito_in : STD_LOGIC_VECTOR(6 downto 0);
    signal ec : STD_LOGIC;
    
    -- output sign
    signal digito_final : STD_LOGIC_VECTOR(6 downto 0);
    
    begin
    
    -- Instanciate component 
    MUX : Multiplexor Port map(
           digito_in => digito_in,
           ec => ec,
           digito_final => digito_final 
    );
    
    -- Stimulus process
    SP : process
        begin
        ec <= '0';
        wait for 20 ns;
        
        ec <= '1';
        digito_in <= "0111111"; -- 0 
        wait for 20 ns;
        digito_in <= "0000110"; -- 1 
        wait for 20 ns;
        digito_in <= "1011011"; -- 2
        wait for 20 ns; 
        digito_in <= "1001111"; -- 3 
        wait for 20 ns;
        digito_in <= "1100110"; -- 4 
        wait for 20 ns;
        ec <= '0';
        wait for 20 ns;
        ec <= '1';
        wait for 20 ns;
        digito_in <= "1101101"; -- 5 
        wait for 20 ns;
        digito_in <= "1111101"; -- 6 
        wait for 20 ns;
        digito_in <= "0000111"; -- 7 
        wait for 20 ns;
        digito_in <= "1111111"; -- 8 
        wait for 20 ns;
        digito_in <= "1100111"; -- 9 
        wait for 20 ns;
        ec <= '0';
        wait for 20 ns;
        wait;
    end process;
end Behavioral;























