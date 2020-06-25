library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux5bits is
    Port ( 
        codigo_op: in STD_LOGIC_VECTOR(4 downto 0);
        sdopc : in STD_LOGIC;
        salida : out STD_LOGIC_VECTOR(4 downto 0)
    );
end mux5bits;

architecture Behavioral of mux5bits is
    constant cero : STD_LOGIC_VECTOR(4 downto 0) := "00000";
    begin
        with sdopc select
            salida <= 
                codigo_op when '1',
                cero when others;
              
end Behavioral;
