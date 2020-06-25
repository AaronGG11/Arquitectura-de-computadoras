library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity nivel is
    Port ( clk : in STD_LOGIC;
           clr : in STD_LOGIC;
           na : out STD_LOGIC);
end nivel;

architecture Behavioral of nivel is
    signal pclk, nclk : STD_LOGIC;
    begin
    
    ALTO : process(clr, clk)
        begin
        if(clr = '1') then 
            pclk <= '0';
        elsif(rising_edge(clk)) then
            pclk <= not pclk;
        end if;
    end process;
    
    BAJO : process(clr, clk)
        begin
        if(clr = '1') then
            nclk <= '0';
        elsif(falling_edge(clk)) then
            nclk <= not nclk;
        end if;
    end process;

    na <= nclk xor pclk; -- LOGICA COMBINATORIA

end Behavioral;
