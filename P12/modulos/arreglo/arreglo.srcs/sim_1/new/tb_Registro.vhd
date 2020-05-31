library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_Registro is
end tb_Registro;

architecture Behavioral of tb_Registro is
    component Registro is
    Port ( la : in STD_LOGIC;
           ea : in STD_LOGIC;
           clk : in STD_LOGIC;
           clr : in STD_LOGIC;
           da : in STD_LOGIC_VECTOR (8 downto 0);
           qa : out STD_LOGIC_VECTOR (8 downto 0));
    end component;
    
    -- input signs
    signal la, ea, clk, clr : STD_LOGIC;
    signal da : STD_LOGIC_VECTOR(8 downto 0);
    
    -- output signs 
    signal qa : STD_LOGIC_VECTOR(8 downto 0);
    
    -- clock period definition
    constant clk_period : time := 10 ns;
    
    begin
    
    -- Instaciate component
    REG : Registro Port map(
           la => la,
           ea => ea,
           clk => clk,
           clr => clr,
           da => da,
           qa => qa
    );
    
    -- clock process
    CLOCK : process
        begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;
    
    -- Stimulus process
    SP : process
        begin
        da <= "110011001";
        wait for 150 ns;
        clr <= '0';
        la <= '1';
        ea <= '0';
        wait for 150 ns;
        la <= '0';
        ea <= '1';
        wait for 150 ns;
        
        

        wait;
    end process;
end Behavioral;
