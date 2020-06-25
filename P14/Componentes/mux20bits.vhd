library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux20bits is
    Port ( 
        codigo_fu: in STD_LOGIC_VECTOR(19 downto 0);
        codigo_op: in STD_LOGIC_VECTOR(19 downto 0);
        sm : in STD_LOGIC;
        salida : out STD_LOGIC_VECTOR(19 downto 0)
    );
end mux20bits;

architecture Behavioral of mux20bits is
    begin
    
    with sm select 
        salida <= codigo_op when '1',
        codigo_fu when others;
end Behavioral;


