library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity registro is
    Port (
        banderas_entrada : in STD_LOGIC_VECTOR(3 downto 0);
        lf : in STD_LOGIC;
        clk : in STD_LOGIC;
        clr : in STD_LOGIC;
        banderas_salida : out STD_LOGIC_VECTOR(3 downto 0)
    );
end registro;

architecture Behavioral of registro is
    begin
    
    process (clr, clk)
        begin
        if(clr = '1') then 
            banderas_salida <= "0000";
        elsif(falling_edge(clk)) then 
            if(lf = '1')then
                banderas_salida <= banderas_entrada;
            end if;
        end if;
    end process;
end Behavioral;
