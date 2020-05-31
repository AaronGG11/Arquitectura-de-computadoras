library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_Contador is
end tb_Contador;

architecture Behavioral of tb_Contador is
    component Contador is
    Port ( lb : in STD_LOGIC;
           eb : in STD_LOGIC;
           clr : in STD_LOGIC;
           clk : in STD_LOGIC;
           qb : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    -- input signs
    signal lb, eb, clr, clk : STD_LOGIC;
    
    -- output signs
    signal qb : STD_LOGIC_VECTOR(3 downto 0);
    
    begin
    
    -- Instaciate component for test
    COUNT : Contador Port map( 
           lb => lb,
           eb => eb,
           clr => clr,
           clk => clk,
           qb => qb
    );
    
    -- Clock process
    CLOCK : process
        begin
        clk <= '0';
        wait for 5ns;
        clk <= '1';
        wait for 5ns;
    end process;
    
    -- Stimulus process
    SP : process
        begin
        clr <= '1';
        lb <= '0';
        eb <= '0';
        wait for 150 ns;
        
        clr <= '0';
        eb <= '1';
        wait for 150 ns;
        
        eb <= '0';
        lb <= '1';
        wait for 150 ns;
        
        wait;
    end process;



end Behavioral;
