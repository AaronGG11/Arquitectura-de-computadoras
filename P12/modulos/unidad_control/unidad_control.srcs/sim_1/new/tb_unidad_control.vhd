library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_unidad_control is
end tb_unidad_control;

architecture Behavioral of tb_unidad_control is
    component unidad_control
    Port ( ini : in STD_LOGIC;
           clr : in STD_LOGIC;
           clk : in STD_LOGIC;
           a0 : in STD_LOGIC;
           z : in STD_LOGIC;
           la : out STD_LOGIC;
           ea : out STD_LOGIC;
           lb : out STD_LOGIC;
           ec : out STD_LOGIC;
           eb : out STD_LOGIC);
    end component;
    -- input signs
    signal ini, clk, clr, a0, z : STD_LOGIC;
    
    -- output signs
    signal la, lb, ea, eb, ec : STD_LOGIC;
    
    -- Clock period 
    constant clk_period : time := 10ns;
    
    begin
    -- Instanciate 
    UC : unidad_control Port map (
           ini => ini,
           clr => clr,
           clk => clk,
           a0 => a0,
           z => z,
           la => la,
           ea => ea,
           lb => lb,
           ec => ec,
           eb => eb
    );
    
    -- Clock process
    CLOCK : process
        begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;
    
    -- process stimulli
    SP : process
        begin
        clr <= '1';
        wait for 30 ns;
        clr <= '0';
        wait for 60 ns;
        ini <= '1';
        wait for 10 ns;
        ini <= '0';
        wait for 50 ns;
        a0 <= '1';
        wait for 20 ns;
        a0 <= '0';
        wait for 20 ns;
        a0 <= '1';
        wait for 10 ns;
        a0 <= '0';
        wait for 120 ns;
        z <= '1';
        wait;
    end process;


end Behavioral;
