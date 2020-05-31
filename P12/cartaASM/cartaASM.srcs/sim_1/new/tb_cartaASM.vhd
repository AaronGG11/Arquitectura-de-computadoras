library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_asm is
end tb_asm;

architecture Behavioral of tb_asm is
    
    component cartaASM 
    Port ( clr : in STD_LOGIC;
           clk : in STD_LOGIC;
           ini : in STD_LOGIC;
           data_in : in STD_LOGIC_VECTOR (8 downto 0);
           data_out : out STD_LOGIC_VECTOR (8 downto 0);
           digit_out : out STD_LOGIC_VECTOR (6 downto 0));
    end component;
    
    -- input signs
    signal ini : STD_LOGIC;
    signal clk : STD_LOGIC;
    signal clr : STD_LOGIC;
    signal data_in : STD_LOGIC_VECTOR (8 downto 0);
    
    -- outpuu signs
    signal data_out : STD_LOGIC_VECTOR (8 downto 0);
    signal digit_out : STD_LOGIC_VECTOR (6 downto 0);
    
    constant clk_period : time := 10 ns;

    begin
    
    -- clock
    CLOCK_P : process
        begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;
    
    uut :  cartaASM Port map(
           clr => clr,
           clk => clk,
           ini => ini,
           data_in => data_in,
           data_out => data_out,
           digit_out => digit_out
    );
    
    -- Process stimuli
    process_stimuli : process
        begin 

        clr <= '1';
        clr <= '0';
        wait for 20ns;
        data_in <= "101101011";
        wait for 20 ns;
        ini <= '1';
        wait for 150 ns;
        
        ini <= '0';
        clr <= '1';
        wait for 20 ns;
        clr <= '0';
        data_in <= "000011101";
        wait for 20 ns;
        ini <= '1';
        wait for 150 ns;
        
        ini <= '0';
        clr <= '1';
        wait for 20 ns;
        clr <= '0';
        data_in <= "000010000";
        wait for 20 ns;
        ini <= '1';
        wait for 150 ns;
        
        ini <= '0';
        clr <= '1';
        wait for 20 ns;
        clr <= '0';
        data_in <= "100001000";
        wait for 20 ns;
        ini <= '1';
        wait for 150 ns;
        
        ini <= '0';
        clr <= '1';
        wait for 20 ns;
        clr <= '0';
        data_in <= "000000000";
        wait for 20 ns;
        ini <= '1';
        wait for 150 ns;
        
    wait;   
    end process;
end Behavioral;

